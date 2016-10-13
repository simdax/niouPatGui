(

Window.closeAll;
s.boot;
a="pattGui.scd".loadRelative[0];
b="flopDict.scd".loadRelative[0];
// c=a.copy;
z=b.(
	(
		seedDeg:0, seedDur:0,
		stretch:4, octave:5,
		time:4,
	)
	.collect(_!3),
	FlowView(nil, 800@300)
); // moui...

d=TimeLine(z.parent).pattern_(Pdef(\c));
Pdef(\c, Pseq(c.collect({|dict| Plazy{f.value; dict.pat}  })).repeat);

z.parent.addAction({ arg s, c;
	c.postln;
	c.switch($ ,{"io".postln; d.win.keyDownAction.value})
}, \keyDownAction);
f={arg i;
	{ defer{m[i].focus}	}
};
c=z.dicts.collect({|x|
	a.copy.proto_(x)
	.put(\mtranspose, [0])
});

PdefAllGui()
)

d.win.keyDownAction.postcs


