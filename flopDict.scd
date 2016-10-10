
(

var x;

Window.closeAll;
n=FlowView();

a=(a:[0,2,1,3], b:[0,3,2], c:4);
t=a.complete; t.gui(3);

//Main
y=a.gui(3, n);
y.paramViews.do(_.action={arg self;
	var label=self.label; var value=self.value;
	[value, label].postln;
	x.postln;
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

