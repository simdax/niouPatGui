(

currentEnvironment

z=(basse:[0,4, 0],
).proto_((
	pat:Pbind().collect(~harmo=_),
	list:(basse:{Pchords(~basse.pseq)})
)).parent_(~p);
z.gui(1);
Pn(z).trace.play

)

Pbind(\degree, Pfunc{`[0,2].value}, \dur,[0.5,1].pseq(inf)).trace.play