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
	pattern:Pbind(\degree,Pseries()),
	fps:1/25,
	toggle:{ arg s, continue=false;
		var toggle={arg rout; if((rout.isPlaying xor: continue.not))
			{"restart".postln; rout.stop.play} //restart
			{"stop".postln; rout.stop} // stop
		};
		[s.tmpPattern,s.routine,s.esp].do{arg x; toggle.(x)}
	},
	ini2:{arg s;
		s.esp=EventPatternProxy().quant_(0);
		s.tmpPattern=TaskProxy({
			var pat=PFF(s.offset,s.pattern);
			s.esp.source_(pat);
			loop{
				var bob=FlowVar();
				s.cl !? {s.cl.stop}; s.cl=TempoClock();
				s.cl.sched((s.time-s.offset),
					{
						"yyyiah".postln;
						s.esp.stop;
						bob.value_(\youpi);
					});				
				bob.value;
				"on revient !".postln;
				s.offset_(0);
				defer{
					s.win.value_(0);
					s.routine.reset.play;
				};
			}
		}
		).quant_(0);
		s.routine= TaskProxy({
			var b=0;
			var time={(s.time/s.fps).reciprocal}.value;
			while{b<1}{ 
				{
					b=s.win.value;
					s.win.value_(b+time);
				}.defer;
				s.fps.wait;
			};
		}).quant_(0)
	},
	ini:{ arg s, parent=Window("timeline", 200@40).front;
		s.win=Slider(parent, 200@30)
		.onClose_{s.routine.stop; s.tmpPattern.stop}
		// stop always
		.keyDownAction_{
			arg self, c;
			switch(c, $ , {s.toggle})
		}
		//retriggers
		.mouseUpAction_{
			arg self;
			if(s.time==inf){} // do nothing
			{
				s[\offset]=self.value*s.time;
				s[\offset].postln;
				s.toggle(true)
			}
		};
	};
)
)

(
s.boot;
Window.closeAll;
a=~timeline; a.ini.ini2; a.time_(2);
a.win.parent.alwaysOnTop_(true);

)
a.routine.play
a.esp.stop
a.tmpPattern.toggle

a.newTime(20)c

b=TempoClock()
b.sched(10, {a.stop})
b.queue

a=Pbind().trace.play

Quarks.gui