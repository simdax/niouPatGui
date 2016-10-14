(

// TODO = tabbedV all + adapt nb
~envir={
	arg a=(degree:[0,0,0], dur:[1,1], stretch:4);
	var parent=a.win??{FlowView()};
	var b, // incremental add
	t, g, // completed dict + gui
	floppedDict, z; // flopped dict + gui

	var size=a.size;

	var f;
	var tabbedV;
	var refresh={
		t.completeChange; floppedDict=nil;
		f.value
	};
	
	Button(parent).action_{
		t.degree=t.degree.add(t.degree.last);
		refresh.value;
		//t[\gui].refresh;
	};
	Button(parent).action_{
		tabbedV.clearAll
	};
	parent.decorator.nextLine;
	// retouches GUI
	b=a.copy.collect(0);
	b.gui(size,parent).paramViews.do { |x, ii|
		x.action=r{
			var incr=0;
			loop
			{
				var pres=(x.value.value.asStringPrec(2).asFloat);
				var val=pres-incr;
				[t,floppedDict].flat.do { |y,i|
					//if(true)
					// if(y[x.label][i].class.postln==Ref)
					// {(i==0).if{y[x.label][ii].value=1}}
					(y[x.label] = y[x.label]+(val))
				};
				incr=pres;
				0.yield;
			}
		}.asStream
	};

	//main
	t=a;
	t.completeChange; g=a[\gui];//.gui(size, parent);
	g.paramViews.do { |x| x.action=x.action.addFunc{arg self;
		refresh.value;
	}};

	parent.decorator.nextLine;
	
	// flopped
	
	tabbedV=TabbedView2(parent);
	f=
	{
		tabbedV.clearAll;
		tabbedV.tabViews.postln;
		floppedDict=t.flop;
		z=floppedDict.collect({|x,i|
			var t=tabbedV.add(i); t.addFlowLayout;
			x.gui(size, t); 
		}); 
		z.do { |envG,i|
			envG.paramViews.do { |param|
				param.action=param.action.addFunc({
					t[param.label]=
					t[param.label].copy
					.put(i,param.value.asStringPrec(2).asFloat)
				})
			}
		};
	};
	f.value;
	(dicts:floppedDict, complet:t, parent:parent);
	//d=floppedDict; d.collect(_.gui(size, nil));
}//("pattGui.scd".loadRelative[0].params)


)

