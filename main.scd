
(

Window.closeAll;

s.boot;
a="pattGui.scd".loadRelative[0];
b="flopDict.scd".loadRelative[0];

// c=a.copy;
z=b.(a.copy.params); // moui...

y=z.dicts.collect(a.copy.params_(_));

f
{arg i;
	{defer{m[i].focus}
	}
};

Pdef(\c, Pbind(*z.complet.collect(_.pseq).asPairs).pat.repeat);

PdefAllGui()
)

z



