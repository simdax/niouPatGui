+EZListView{
	findItem{arg item;
		^items.detectIndex{arg assoc;
			assoc.key == item
		}
	}
	select{ arg item;
		this.value_(this.findItem(item))
	}
}

