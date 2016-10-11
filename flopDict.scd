(

// TODO = tabbedV all + adapt nb
{
arg a=(degree:[0,0,0], dur:[1,1], stretch:4), // main dic (for test)
parent=FlowView();
var b, // incremental add
t, g, // completed dict + gui
floppedDict, z; // flopped dict + gui

var size=a.size;

//	Window.closeAll;

// retouches GUI
b=a.copy.collect(0);
b.gui(size,parent).paramViews.do { |x|
	//	x.currview.sliderView.mouseUpAction_{x.valueAction_(0.0)};
	x.action=r{
		//		var initVal=t[x.label];
		var incr=0;
		loop
		{
			var pres=(x.value.asStringPrec(2).asFloat);
			var val=pres-incr;
			t[x.label]= t[x.label]+val//(initVal+pres)
			;
			floppedDict.do { |y,i|
				(y.[x.label] = y.[x.label]+(val));
			};
			incr=pres;
			0.yield;
		}
	}.asStream
};

//main
t=a.complete; g=t.gui(size, parent);
g.paramViews.do(_.action={arg self;
	var label=self.label; var value=self.value;
	floppedDict.do { |x,i|
		if(value[i]!=x.at(label))
		{x.perform((label++"_").asSymbol,value[i])}
	};
});

// flopped
floppedDict=a.flop;
//d=floppedDict;
z=floppedDict. collect(_.gui(size, parent));
z.do { |envG,i|
	envG.paramViews.do { |param|
		param.action=param.action.addFunc({
			t[param.label]=
			t[param.label].copy
			.put(i,param.value.asStringPrec(2).asFloat)
		})
	}
};

(dicts:floppedDict, complet:t);
//d=floppedDict; d.collect(_.gui(size, nil));
}//.value//("pattGui.scd".loadRelative[0].params)


)

