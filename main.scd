(

var t,// view
harmo, //harmo pat def
a, // pattern def
tabV, //tabbedView
i; // count nb of patterns

Pdef.removeAll;
Window.closeAll;
s.makeGui;


// HARMO

t=FlowView();
harmo=Ouf.harmo;
harmo.gui(t);

t.decorator.nextLine;

// ACC DEF
a=(degree:1,nb:4, amp:0.2, stretch:0.5, ambitus:[-2,2], patternR:1000.rand,)
.parent_((
	specs:(
		ambitus:[-7,7,nil,1],
		nb:[1,10,nil,0.5],
		stretch:[1,4,\exp,1],
		dur:[0.5,2,nil,0.5],
		degree:[-7,7,nil,1],
		patternR:[0,10000,nil,1],
		amp:\amp,
	),
	pat:Pbind(\type, \appo,
		\amp, Pfunc{~amp},
		\degree, Pfunc{~degree},
		\mtranspose, Plazy{
			Pseed(~patternR,Pwhite(*~ambitus).round(1))},
		\stretch, Pfunc{~stretch/2},
	),
	embedInStream:{arg s,in=();
		s.use{(~pat.fin(~nb)<>Pn(harmo)).embedInStream(in)}
	}
));

tabV=TabbedView2(bounds:Rect(900,0, 300,400));
i=0;

f={arg ... type;
	{
		var niou=a.copy;
		var win; var instr;
		var io=(instrument:SynthDefPool.choose(*type));
		var tab=tabV.add(i.asString); tab.addFlowLayout;
		win=niou.gui(8,tab).parent.name_(i.asString).alwaysOnTop_(true);
		win.bounds_(win.bounds.extent_(250@450));
		SynthDefPool.listGui(win)
		.globalAction_{arg x; io.instrument=(x.item.asSymbol);
			io}
		.select(io.instrument);
		Pdef(i.asSymbol,Pn(niou)<>io).play;
		i=i+1;
	}
};

Button(t).action_(f.(\percussion,true)).string_("percussion");
Button(t).action_(f.(\percussion,false));

Button(t).string_("add Mel").action_{Ouf.melFunc};

//Button().front.action_{d.init()};

//a.gui(8,t)

PdefAllGui(8,t);
)

