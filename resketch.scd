(
// Window.closeAll;
// s.boot;
// a=nil;

//// LES GENERATEURS

var a, //pattern def
t,// main view
b,c, // mini Dicts
d, // controller for mini Dicts
z // result
;

a=(
	//vals
	seed:0, set:[1,4], reso:1,
	// methods
	pat:{arg s; s.use{Pseed(~seed,Pwhite(*~set)).round(~reso)}},
	embedInStream:{arg s,in; s.pat.embedInStream(in)},
	asStream:{arg s; s.parent.put(\proxy,PatternProxy(s.pat));
		s.proxy},
	gui:{arg s, p, b, nIt=s.size; var gui;
		gui=EnvirGui(s, nIt, p,b);
		s.keys.do { |k| 
			gui.viewForParam(k).action=
			gui.viewForParam(k).action.addFunc{
				s.proxy.source_(s.pat)
			}
		};
	},
	specs:(seed:[0,120,nil,1],set:[0.1,4], reso:[0.25,1,nil,0.25])
);
t=FlowView();
#b,c=["dur","degree"].collect((name:_)).do(_.putAll((seed:0, set:[1,4], reso:1))).do(_.parent_(a.copy));
[c,b].do(_.gui(t));


///// LES RETOUCHES

Spec.add(\seed, [0, 4,nil,1]);

d=(
	times: [4,4],
	init:{arg s, p,b;
		s.dicts=(seedR:0, seedH:0).proto_((specs:(seedR:\seed,seedH:\seed)))!s.times.size;
		s.dicts.do(_.gui(2,p,b))
	},
	pat:PlazyEnvir{arg seedR, seedH; 
		Pbind(\dur, Plazy{b}, \degree, Plazy{c},
			\mtranspose, Pseed(seedH,Prand([0,1,-1],inf)),
			\stretch, Pseed(seedR, Prand([0.5, 0.25],inf) )
		)
	},
	pat:PlazyEnvir{Pbind()},
	embedInStream:{arg s,in=();
		in.postln;
		s.dicts.collect({|x,i|
			(s.pat <> s.dicts[i])
			.finDur(Pfunc{s.times[i]}.asStream)
		}).postln.pseq.embedInStream(in)
	} 
);

d.init(t);


///// LINE
t.decorator.nextLine;
z=PlayLine(t);
z.timeline.pattern_(Pn(d));
// z.timeline.time_(8);

(line:z,fen:t)

)

// (Pn(d)<>Pbind(\instrument, \acid_oto309, \amp, 2)).trace.play
// (Pn(d) <> (instrument: \acid_oto309,      amp: 0.3)).trace.play
// SDP.gui

// (Pbind().finDur(4).pseq <> (io:7)).trace.play

