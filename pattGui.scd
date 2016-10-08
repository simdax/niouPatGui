(

(
instrument:\default,
specs:(amp:\amp, octave:[2, 8,\lin,1],
	[\seedDeg,\seedDur]:[0,100,\lin,1],
	[\time,\stretch]:[0.25,16,\exp,0.25],
),
params:( amp: 0.3, octave:5, seedDeg:100.rand, seedDur:100.rand, stretch:4, time:4),
pat: {arg s;
	s.patPro=EventPatternProxy(
		Pbind(
			\instrument, Pfunc{s.instrument},
			\amp, Pfunc{s.params.amp},
			\octave, Pfunc{s.params.octave},
			\degree, Pseed(Pfunc{s.params.seedDeg},Prand([0,5],inf)),
			\dur,    Pseed(Pfunc{s.params.seedDur},Prand([1,2,3,4],inf)),
			\octave, Pfunc{s.params.octave},
			\stretch, Pfunc{s.params.stretch.reciprocal},
		).finDur(Pfunc{s.params.time}.asStream)
	);
}, init:{arg s, pa;
	var gui;
	try{pa.decorator}??{pa.addFlowLayout};
	s.postln;
	s.pat; s.patPro.postln;
	gui=EnvirGui(s.params,6,pa);
	s.specs.keysValuesDo{arg k,v;
		k.asArray.do{ arg y;
			gui.putSpec(y, v)
		}
	}
}
)


)