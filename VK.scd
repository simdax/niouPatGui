(
//Window.closeAll;

//w=Window().front;

(
// depart + nb touches
val:{ arg s, w, nb=6;
	[0]++(((w / nb) ! nb).integrate.drop(-1))
	+ w
},
rect:{arg s,p,b,i;
	View(p,(20@100).asRect.origin_(b))
	.background_(Color.white )
	.mouseEnterAction_{arg self; self.background_(Color.red)}
	.mouseLeaveAction_{arg self; self.background_(Color.white)}
	.mouseDownAction_{arg self;
		(degree:i,instrument:s.instr?\default).play}
},fen:
{arg s,p;
	p ?? {p=View(p, 300@300)};
	s.val(100).do{arg x, i;
		s.rect(p, x@20,i)
	}	
}, instr:{});

//a.fen(w)

)