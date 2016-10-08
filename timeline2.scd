(
~timeline=(
	// time manip
	recommence:{ arg s;
		s.offset=0;
		s.esp.stop.play;
		defer{s.win.value_(0)};
		s.routine.stop.play;
		"grosse function ! ".postln
	},
	newTime:{arg s, new, post=false;
		var pourcentage;
		var niou;
		var now=s.time*s.win.value;
		s.time=new; s.routine.envir_(s);
		if(new<now){s.recommence}
		{
			pourcentage=s.time/new; pourcentage;
			//action
			s.offset=s.win.value=(s.win.value*pourcentage);
		}
	},
	// var
	time:1, offset:0, fps:1/25,
	//routine
	paused:false, playing:false,
 	pattern:Pbind(\octave, 5, \degree,Pseries(0,1), \dur, 0.5),
	esp:EventPatternProxy(Plazy{arg s;PFF(s.offset,s.pattern)}).quant_(0),
	routine:TaskProxy({ arg s;
		var b=0;
		while{b<1}{
			var time={(s.time/s.fps).reciprocal}.value;
			time.postln;
			{
				b=s.win.value;
				s.win.value_(b+time);
			}.defer;
			s.fps.wait;
		};
		s.recommence
	}).quant_(0),
	routines:{arg s; [s.routine, s.esp]},
	// UI
	ini:{ arg s, parent=Window("timeline", 200@40).front;
		s.routine.envir_(s); s.esp.envir_(s);
		s.win=Slider(parent, 200@30)
		.onClose_{s.routine.clear; s.esp.clear}
		// stop always
		.keyDownAction_{
			arg self, c;
			switch(c, $ , { 
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
				if(s.playing.postln){s.esp.stop.play};
				if(s.paused.postln){s.esp.stop.play.pause};
				//	s.keyDownAction.value
			}
		};
	};

)
)
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
	NumberBox(a.win.parent, Rect(40, 0, 20, 20 ))
}) 

a.time
a.newTime(4)
a.routine.envir_((io:8)
)

a.esp.pause
a.esp.resume
a.routines.do(_.resume)

a.newTime(20)c

b=TempoClock()
b.sched(10, {a.stop})
b.queue

a=Pbind().trace.play

Quarks.gui


