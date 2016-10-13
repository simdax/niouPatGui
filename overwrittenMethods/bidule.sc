+ EnvirGui
{
	*new { |object, numItems = 8, parent, bounds, makeSkip = true, options = #[]|
		^super.new(object, numItems, parent, bounds, makeSkip = true, options).initDeux;
	}
	initDeux{
		try{
			specs=specs ++ object[\specs].collect(_.asSpec);
			this.hideFields(\specs)
		}
	}
	
	hideFields{arg ...fields;
		var ind=paramViews.collect { |x, i|
			//side effect
			if(fields.includes(x.label)){
				x.visible_(false)
			};
			i
		};
		//// FEINTE LIKE ITS NOT USED
		useRanger=fields.postln;
	}
	showFields { |num = 0|
		paramViews.do { |pv, i|
			var isInUse = (i < num) ;
			pv.visible_(isInUse);
		};
		try{this.hideFields(*useRanger)};
	}

}