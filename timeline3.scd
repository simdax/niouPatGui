(
var w, z, f;
var a="timeline2.scd".loadRelative[0];
w=Window("io", 200@60).front;
a.setEsp; // init equivalent
a.guigui(w);

z=NumberBox(a.win.parent, Rect(0, 40, 100, 20 ))
.action_{arg s;var c=s.value;
	a.newTime(1.max(c))
};
f=StaticText(a.win.parent, Rect(100, 40, 100, 20 ));
TaskProxy({
	while{a.routines.notNil}{
		defer{
			var tt=a.time;
			var t=a.win.value*a.time;
			f.string_(t); z.value_(tt)
		};
		0.2.wait}
}).play;

a

)