(
(
~timeline=(
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
						Pfset({s.cl=SystemClock()},Pfindur(
							Pfunc
							{(s.time-s.offset.postln)}.asStream,
							PFF(Pfunc{s.offset}, s.pattern)
						))
					);
					"on revient !".postln;
					s.offset_(0);
					defer{
						Zyn.panic;
						s.win.value_(0);
						s.routine.reset.play;
					};
					//sp.wait(0.002)
				}
			});
		).quant_(0);
		s.win=Slider(parent, 200@30)
		.onClose_{s.routine.stop; Zyn.panic; s.tmpPattern.stop}
		.keyDownAction_{
			arg self, c;
			switch(c, $ , {s.toggle})
		}
		.mouseUpAction_{
			arg self;
			if(s.time==inf){} // do nothing
			{
				s[\offset]=s.time*self.value;
				Zyn.panic;
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
)

a=~timeline

a.ini
a.time_(10)