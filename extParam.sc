+ ParamView{

	value_ { |val|
		if (val != value) {
			this.viewType_(this.valueType(val));
		};
		value = val;
		currview.value_(value);
		this.changed(\val, (label:label, val:currview.value)) // take specs in count
	}


}


