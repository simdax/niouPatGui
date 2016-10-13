// parent : le type => les fonctions qui vont déterminer des comportements
//proto : ce sont les sets et les seeds => des arrays
// le time

//instances => 


(
a=(
specs:(amp:\amp, octave:[2, 8,\lin,1],
	[\seedDeg,\seedDur]:[0,100,\lin,1],
	[\time,\stretch]:[0.25,16,\exp,0.25],
),
pat:{arg s;
	var rand={arg set, key; Pseed(Pfunc{s[key]}, Prand(set, inf))};
	var k=s.proto.keys.as(Array);
	var p=k+++k.collect({|x|
		if(x.isCollection){Pseq(x)}
		{x.switch(
			\degree, rand.value((0..5),\degree),
			\dur, rand.value([1,2,3,4],\dur),
			\stretch, Pfunc{s[x].reciprocal},
			{Pfunc{s[x]}}
		)}
	}); p.postln;
	Pbind(*p.flatten.postln).finDur(Pfunc{s.time}.asStream)		
}, guigui:{arg s, pa;
	var gui;
	try{pa.decorator}??{pa.addFlowLayout};
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