(

Window.closeAll;
s.boot;

a="pattGui.scd".loadRelative[0];
b="flopDict.scd".loadRelative[0];

// c=a.copy;
z=b.(); // moui...



f={arg i;
	{defer{m[i].focus}
	}
};

c=z.dicts.collect({|x| a.copy.proto_(x) });

Pdef(\c, Pseq(c.collect({|dict| Plazy{f.value; dict.pat}  })).repeat);

PdefAllGui()
)



