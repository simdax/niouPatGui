+ Event{
	// asStream{
	// 	if(this.at(\embedInStream).notNil, {
	// 		^(this.at(\asStream) !?
	// 			{var res=this.at(\asStream).value(this);
	// 				res.asStream
	// 			} ??
	// 			{Plazy{this}.asStream}
	// 		)
	// 	}, {^this.asStream});
	// }
	gui{ arg ... args;
		if(this.at(\gui).notNil, {
			^this.at(\gui).value(this, *args)
		}, {^super.gui(*args)});
	}
}
