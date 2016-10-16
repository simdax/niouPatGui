(
var bob=
(basse:0)
.parent_(
	(
		specs:(basse:[0,6,nil,1]),
		pat:Pbind(\type, \rest,\scale,Pchords(Pfunc{~basse})),
		embedInStream:{arg s,in=(); s.use{~pat.embedInStream(in)}}
	)
);



Event.addEventType(\harmo,{
	bob.basse=~degree;
});

bob
// Pdef(\harmo,
// 	Pbind( \)
// 	);

// 	bob

)