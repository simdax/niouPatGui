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
		var pause={	arg r;
			r.isPaused.if{r.resume};
			r.pause
		};
		var toggle={arg rout; if((rout.isPlaying xor: continue.not))
			{"restart".postln; rout.stop.play} //restart
			{"pause".postln; pause.(rout)} // stop
		};
		[s.tmpPattern,s.routine].do{arg x; toggle.(x)}
	},
	pause:{ arg s;
		var routines=[s.routine,s.tmpPattern];
		routines.do{arg r;
			r.isPaused.if{r.resume};
			r.pause
		}
	},
	routine:TaskProxy({ arg s;
			var b=0;
			var time={(s.time/s.fps).reciprocal}.value;
			while{b<1}{ 
				{
					b=s.win.value;
					s.win.value_(b+time);
				}.defer;
				s.fps.wait;
			};
	}).quant_(0),
	//	setEsp:{arg s; s.espPlazy{arg s;PFF(s.offset,s.pattern)}}
	esp:EventPatternProxy(Plazy{arg s;PFF(s.offset,s.pattern)}).quant_(0),
	paused:false, playing:false,
	routines:{arg s; [s.routine, s.esp]},
	ini:{ arg s, parent=Window("timeline", 200@40).front;
			s.routine.envir_(s); s.esp.envir_(s);
		s.win=Slider(parent, 200@30)
		.onClose_{s.routine.clear; s.esp.clear}
		// stop always
		.keyDownAction_{
			arg self, c;
			switch(c, $ , { "01234".scramble.postln;
				if(s.playing){
					"pause".postln;
					s.routines.do(_.pause);
					s.playing=false; s.paused=true
				}
				{
					if( s.paused)
					{"resume".postln; s.routines.do(_.resume); s.playing=true; }
					{"play".postln;s.routines.do(_.play); s.playing=true};
				}
			})
		}
		//retriggers
		.mouseUpAction_{
			arg self;
			if(s.time==inf){} // do nothing
			{
				s[\offset]=self.value*s.time;
				if(paused.not){s.esp.stop.play};
				s.keyDownAction.value
			}
		};
	};

)
)

Pdef(\c, Pbind()).play.pause.resume

a

( 
s.waitForBoot{
Window.closeAll; 0.1.wait;
	a=nil;
	a=~timeline.copy;
	a.postln;
	a.ini.value;
	//a.ini2.value;
	a.time_(4);
a.win.parent.alwaysOnTop_(true);
})

a.routines.do(_.resume)
a.esp.source
a.esp.envir_((a:9))
a.esp.play
a.esp.pause
a.esp.resume
a.routines.do(_.resume)

a.newTime(20)c

b=TempoClock()
b.sched(10, {a.stop})
b.queue

a=Pbind().trace.play

Quarks.gui