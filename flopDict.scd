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
					// if(y.[x.label].class==Ref){
					// 	(y.[x.label].value = y.[x.label]+(val));
					// }
					//{
						(y.[x.label] = y.[x.label]+(val))
						//};
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
		var label=self.label; var value=self.value;
		var tmp;
		t.completeChange; tmp=t.flop;
		f.value;
	}};

	parent.decorator.nextLine;
	
	// flopped
	
	tabbedV=TabbedView2(parent);
	f=
	{
		tabbedV.clearAll;
		floppedDict=a.flop;
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

