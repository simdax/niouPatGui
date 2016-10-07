+ PatternProxy{
	toggle{
		if(this.isPlaying){this.stop}{this.play}
	}
}

+ PopUpMenu{

	// why not ???
	valueAction_ { |val|
		this.value_(val);
		this.doAction;
	}

}