(
// Window.closeAll;
// s.boot;
// a=nil;

//// LES GENERATEURS

var a, //pattern def
t,// main view
b,c, // mini Dicts
d, // controller for mini Dicts
g, //function for time control
z // result
;

a=(seed:0, set:[1,4], reso:1).parent_(
(	// methods
	pat:{arg s; s.use{Pseed(~seed,Pwhite(*~set)).round(~reso)}},
	embedInStream:{arg s,in; s.pat.embedInStream(in)},
	asStream:{arg s; s.parent.put(\proxy,PatternProxy(s.pat));
		s.proxy},
	gui:{arg s, p, b, nIt=s.size+1, options; var gui;
		gui=MyEnvirGui(s, nIt, p,b,options:options);
		s.keys.do { |k| 
			gui.viewForParam(k).action=
			gui.viewForParam(k).action.addFunc{
				s.proxy.source_(s.pat)
			}
		};
		gui
	},
	specs:(seed:[0,120,nil,1],set:[0.1,4,nil], reso:[0.25,1,nil,0.25])));



t=FlowView();
#b,c={a.copy}!2;
[c,b].do{arg x, i; x.postln.gui(t,options:\name).name_(["dur","degree"][i])
};



///// LES RETOUCHES

Spec.add(\seedio, [0, 4,nil,1]);

d=(
	init:{arg s, p,b;
		s.dicts=(
			(seedR:0, seedH:0,time:2)
			.proto_((specs:(seedR:\seedio,seedH:\seedio)))
		)
		!2;
		s.dicts.do{arg x; x.gui(3,p,b)
			.addAction(\time,{g.value})
		}
	},
	pat:PlazyEnvir{arg seedR, seedH;
		//[seedR,seedH].ostln;
		Pbind(\dur, Plazy{b}.trace, \degree, Plazy{c}.trace,
			\mtranspose, Pseed(seedH,Prand([0,1,-1],inf)),
			\stretch, Pseed(seedR, Prand([0.5, 0.25],inf) )
		)
	},
	//	pat:PlazyEnvir{Pbind()},
	embedInStream:{arg s,in=();
		s.dicts.collect({|x,i|
			(s.pat.trace <> s.dicts[i])
			.finDur(Pfunc{s.dicts[i].time}.asStream)
		}).pseq.embedInStream(in)
	} 
);

d.init(t);


///// LINE
t.decorator.nextLine;
z=PlayLine(t);
// TODO add 
// z.timeBox.addAction(
// {	arg self=z.timeBox; var now=self.value;
// 	r{ arg self;
// 	loop{
// 		var new, diff;
// 		"youyou".postln;
// 		new=self[0].value;
// 		diff=self[0].value-now;
// 		d.dicts.do { |x|
// 			x.time=x.time+(diff/2);
// 		};
// 		now=new;
// 		self=0.yield;
// 	}
// }.asStream
// }.value);
z.timeline.pattern_(Pn(d));
g={z.timeline.time_(d.dicts.collect(_.time).sum.postln)};


(line:z,fen:t)

)

// (Pn(d)<>Pbind(\instrument, \acid_oto309, \amp, 2)).trace.play
// (Pn(d) <> (instrument: \acid_oto309,      amp: 0.3)).trace.play
// SDP.gui

// (Pbind().finDur(4).pseq <> (io:7)).trace.play

