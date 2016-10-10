(

#a,b,c,z,w,m=nil!3;

w=FlowView();
e=View(w, 200@60).background_(Color.rand);
h=View(w, 260@120).background_(Color.rand);
b=TabbedView2(w);
w.parent.alwaysOnTop_(true);

c="timeline3.scd".loadRelative[0].value(e);

a="pattGui.scd".loadRelative;

4.do{arg x;
	var i; i=b.add(x);
	m=m.add(i);
	z.postln;
	z=z.add(a[0].deepCopy);
 	z[x].init(i);
};

h.addFlowLayout;
y="flopDict.scd".loadRelative[0];
j=y.value(z).asArray.asDict.as(Event);
EnvirGui(j,6,h);

"setDict.scd".loadRelative[0].value(m,j);

f={arg  i;
	{defer{m[i].focus}
	}
};
~pattern=EventPatternProxy
(
(z.collect(_.patPro).collect({|item, index|
Pfset(f.value(index),item)
})
.pseq
)
);



c.time_(
	[\params,\time].inject(z, {arg a,b; a.collect(_.perform(b)) }).sum
).setPattern(~pattern);




)



