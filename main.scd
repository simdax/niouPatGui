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

a=Ouf.acc;

a.parent.put(\embedInStream,
	{arg s,in=();
		s.use{(~pat.fin(~nb)<>Pn(harmo)).embedInStream(in)}
	}
);

// ACC DEF
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

