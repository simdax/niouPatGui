(
~timeline=(
	newTime:{arg s, new, post=false;
		var diff, now, pourcentage;
		diff=new-s.time;
		now=s.cl !? {s.cl.beats} ?? {0};
		pourcentage=now.postln/new;
		//Changer place et vitesse
		s.time=new;
		s.offset_(pourcentage);
		s.win.value_(pourcentage);
		2.do(s.toggle(true));
	},
	time:1, offset:0,
	pattern:Pdef(\dispatch),
	fps:1/25,
	toggle:{ arg s, continue=false;
		var toggle={arg rout; if(rout.isPlaying xor: continue.not)
			{rout.reset.play}
			{rout.stop}
		};
		s.offset=(s.win.value*s.time);
		toggle.(s.tmpPattern);
		toggle.(s.routine);
	},
	ini:{ arg s, parent=Window("timeline", 200@40).front;
		s.tmpPattern=Pdef(\timeline,
			Pspawner({arg sp;
				loop{
					sp.seq(
						Pfset({s.cl=TempoClock()},
							PFF(Pfunc{s.offset},
								Psync(
								*[s.pattern]++(Pfunc
									{((s.time-s.offset))}.asStream !2)
						)))); 
					"on revient !".postln;
					s.offset_(0);
					defer{
						s.win.value_(0);
						s.routine.reset.play;
					};
					//sp.wait(0.002)
				}
			});
		).quant_(0);
		s.win=Slider(parent, 200@30)
		.onClose_{s.routine.stop; s.tmpPattern.stop}
		.keyDownAction_{
			arg self, c;
			switch(c, $ , {s.toggle})
		}
		.mouseUpAction_{
			arg self;
			if(s.time==inf){} // do nothing
			{
				s[\offset]=self.value*s.time;				
				s.toggle(true)
			}
		};
		s.routine=Task({
			var b=0;
			var time={(s.time/s.fps).reciprocal}.value;
			while{b<1}{
				{
					b=s.win.value;
					s.win.value_(b+time);
				}.defer;
				s.fps.wait;
			};
		});
	};
)
)

(
Window.closeAll;
a=~timeline.ini; a.time_(10);
a.win.parent.alwaysOnTop_(true);
a.newTime(200)
) 
