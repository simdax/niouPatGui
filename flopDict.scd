
(

var x;

Window.closeAll;
n=FlowView();

z=(a:[0,2,1,3], b:[0,3,2], c:4);
z=z.complete;

//Main
y=z.gui(3, n);
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
x=z.flop;
z=x.collect(_.gui(3,n));
z.do { |envG,i|
	envG.paramViews.do { |param|
		param.action={
			("je suis "++i).postln
			param.label
		}
	}
}
;


)

