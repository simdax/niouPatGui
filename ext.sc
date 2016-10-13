+ PatternProxy{
	toggle{
		if(this.isActive){"stop".postln; this.stop}{"play".postln ;this.play}
	}
}
+ TaskProxy{
	// what the point with first implementation ?
	isPaused{^player !? {player.wasStopped} ?? {false}}
}
+ PopUpMenu{

	// why not ???
	valueAction_ { |val|
		this.value_(val);
		this.doAction;
	}

}