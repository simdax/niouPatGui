(

Window.closeAll;

s.boot;
a="pattGui.scd".loadRelative[0];
b="flopDict.scd".loadRelative[0];

// c=a.copy;
z=b.(); // moui...



{arg i;
	{defer{m[i].focus}
	}
};

c=z.dicts.collect({|x| a.copy.proto_(x) });

Pdef(\c, Pseq(c.collect(_.pat)).repeat);

PdefAllGui()
)



