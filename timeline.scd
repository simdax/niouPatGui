
(

#a,b,c,z,w=nil!3;
Window.closeAll;
s.boot;
w=FlowView();
a="pattGui.scd".loadRelative;

b=TabbedView2(w);
w.parent.alwaysOnTop_(true);

5.do{arg x;
	var i; i=b.add(x);
	z.postln;
	z=z.add(a[0].deepCopy);
 	z[x].init(i);
};
c="timeline3.scd".loadRelative[0];
~pattern=EventPatternProxy
(
(
(z.collect(_.patPro)
+++(z.size.collect({|x| Plazy{x.postln} })))
.flat
.pseq
)
);

c.time_(
	[\params,\time].inject(z, {arg a,b; a.collect(_.perform(b)) }).sum
).setPattern(~pattern);




)



