
(

var x;

Window.closeAll;
n=FlowView();

a=(a:[0,2,1,3], b:[0,3,2], c:4);

b=a.copy.collect(0);
b.gui(3,n).paramViews.do { |x|
	//	x.currview.sliderView.mouseUpAction_{x.valueAction_(0.0)};
    x.action=r{
		var p=g.paramViews.detect{arg y; y.label==x.label};
		var initVal=p.value;
		loop
		{
			var pres=(x.value.asStringPrec(2).asFloat);
			p.valueAction_(initVal+pres);
			0.yield;
		}
	}.asStream
};

//main
t=a.complete; g=t.gui(3, n);
g.paramViews.do(_.action={arg self;
	var label=self.label; var value=self.value;
	x.do { |x,i|
		if(value[i]!=x.at(label))
		{x.perform((label++"_").asSymbol,value[i])}
	};
});


// flopped
x=a.flop;

z=x.collect(_.gui(3,n));
z.do { |envG,i|
	envG.paramViews.do { |param|
		param.action={
			t[param.label]=
			t[param.label].copy
			.put(i,param.value.asStringPrec(2).asFloat)
		}
	}
}
;


)

