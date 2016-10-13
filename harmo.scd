(
z=(basse:[0,0,4,0],
).proto_((
	pat:Pbind(\type, \rest).collect(~harmo=_),
	list:(basse:{Pchords(~basse.pseq)})
)).parent_(~p);
z.gui(1);
Pn(z).trace.play

)
