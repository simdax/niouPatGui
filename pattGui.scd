(

(
specs:(amp:\amp, octave:[2, 8,\lin,1],
	[\seedDeg,\seedDur]:[0,100,\lin,1],
	[\time,\stretch]:[0.25,16,\exp,0.25],
),
pat:{arg s; Pbind(
	\instrument, Pfunc{s.instrument},
	\amp,    Pfunc{s.amp},
	\octave, Pfunc{s.octave},
	\degree, Pseed(Pfunc{s.seedDeg},Prand([0,5],inf)),
	\dur,    Pseed(Pfunc{s.seedDur},Prand([1,2,3,4],inf)),
	\octave, Pfunc{s.octave},
	\stretch, Pfunc{ s.parent.postln; s.stretch.reciprocal},
).finDur(Pfunc{s.time}.asStream)		
}, guigui:{arg s, pa;
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
.parent_((instrument:\default, amp: 0.3, octave:5, seedDeg:100.rand, seedDur:100.rand, stretch:4, time:4))



)