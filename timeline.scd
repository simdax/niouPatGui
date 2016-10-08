(

#a,b,c,z,w=nil!3;
Window.closeAll;
s.boot;
w=FlowView();
e=View(w, 200@60).background_(Color.rand);
h=View(w, 260@120).background_(Color.rand);
b=TabbedView2(w);
w.parent.alwaysOnTop_(true);

c="timeline3.scd".loadRelative[0].value(e);

a="pattGui.scd".loadRelative;

4.do{arg x;
	var i; i=b.add(x);
	z.postln;
	z=z.add(a[0].deepCopy);
 	z[x].init(i);
};

h.addFlowLayout;
y="flopDict.scd".loadRelative[0];
j=y.value(z).asArray.asDict.as(Event);
EnvirGui(j,6,h);


f={'jkl'.postln};

~pattern=EventPatternProxy
(
(z.collect(_.patPro).collect(Pfset({},_,f))
.pseq
)
);



c.time_(
	[\params,\time].inject(z, {arg a,b; a.collect(_.perform(b)) }).sum
).setPattern(~pattern);




)



