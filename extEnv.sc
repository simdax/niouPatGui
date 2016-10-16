+Env{
	*newFrom{ arg array;
		^if(array.class==this, {
			^array
		},{
			if(array.size<2){
				^Error("manque un truc bro").throw
			}{this.new(*array)}
		});
	}
}

