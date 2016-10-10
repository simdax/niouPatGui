(

{
	arg a=(a:[0,2,1,3], b:[0,3,2], c:4), // main dic (for test)
	parent=FlowView();
	var b, // incremental add
	t, g, // completed dict + gui
	x, z; // flopped dict + gui

	var size=a.size;

	//	Window.closeAll;

	// retouches GUI
	b=a.copy.collect(0);
	b.gui(size,parent).paramViews.do { |x|
		//	x.currview.sliderView.mouseUpAction_{x.valueAction_(0.0)};
		x.action=r{
			var initVal=t[x.label];
			loop
			{
				var pres=(x.value.asStringPrec(2).asFloat);
				t[x.label]= (initVal+pres);
				0.yield;
			}
		}.asStream
	};

	//main
	t=a.complete; g=t.gui(size, parent);
	g.paramViews.do(_.action={arg self;
		var label=self.label; var value=self.value;
		x.do { |x,i|
			if(value[i]!=x.at(label))
			{x.perform((label++"_").asSymbol,value[i])}
		};
	});

	// flopped
	x=a.flop;

	z=x.collect(_.gui(size,parent));
	z.do { |envG,i|
		envG.paramViews.do { |param|
			param.action={
				t[param.label]=
				t[param.label].copy
				.put(i,param.value.asStringPrec(2).asFloat)
			}
		}
	};
}//.value("pattGui.scd".loadRelative[0].params)


)


