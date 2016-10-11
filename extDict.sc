+ Dictionary{
	// send a pack of other dictionary with values flopped
	flop{
		var k=this.keys.asArray;
		var vals=this.values.collect({|x,i| this.at(k[i]) });
		vals=vals.flop;
		^vals.collect( k+++_ ).collect(_.flatten).collect(_.as(this.species))
	}
	complete{
		var size=this.values.collect(_.size).replace(0,1).maxItem;
		^this.collect({|x| size.collect(x.asArray @@ _) });
	}
}


// a.species
// a=(b:[3,5], c:4, joe:4898);
// a.flop
// k=a.keys.asArray;
// v=a.values.collect({|x,i| a.at(k[i]) });
// v=v.flop;
// v.collect( k+++_ ).collect(_.flatten).collect(_.as(Dictionary))

// k[0]


+ Dictionary {
	/*
	*/
	gui { arg  numItems, parent, bounds, options;
		var n = numItems ?? { max(12, this.size) } ;
		^EnvirGui(this, n, parent, bounds, options:options);
	}
}