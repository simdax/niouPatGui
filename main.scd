
(

s.boot;
a="pattGui.scd".loadRelative[0];
b="flopDict.scd".loadRelative[0];

// c=a.copy;
z=b.(a.copy.params);
y=z.dicts.collect(a.copy.params_(_));

f={arg  i;
	{defer{m[i].focus}
	}
};
~pattern=EventPatternProxy
((y.collect(_.pat).collect({|item, index|
Pfset({}// f.value(index)
	,item)
}).pseq(inf)));

)

~pattern.play


z.complete.size