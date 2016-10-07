
(

#a,b,c,z,w=nil!3;
Window.closeAll;
s.boot;
c="timeline2.scd".loadRelative[0];
w=FlowView();
a="pattGui.scd".loadRelative;

c.ini(w);
b=TabbedView2(w);
w.parent.alwaysOnTop_(true);

5.do{arg x;
	var i; i=b.add(x);
	z=z.add(a[0].deepCopy);
	z[x].init(i);
};

~pattern=EventPatternProxy
(z.collect(_.patPro).pseq(inf));

c.time_(
	[\params,\time].inject(z, {arg a,b; a.collect(_.perform(b)) }).sum
).pattern_(~pattern);



)

