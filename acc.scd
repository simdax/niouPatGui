(
Event.addEventType(\appo,{ arg self;
	var dur, mtranspose;
	~degree=(~degree+~mtranspose).degreeToKey(~scale?[0,2,4],7);
	~scale=~mode ? #[0,2,4,5,7,9,11];
	~appo !? {
		if(~appo==0){dur=0}
		{
			mtranspose=Pseq(({[-1,1].choose}!~appo?1));
			dur=(~dur!(~appo)).normalizeSum * ~dur;
		}
	} ??
	{	dur=~dur.value			};
	~type=\note;
	Pbind(\dur, dur.pseq, \mtranspose, mtranspose?0)
	.play(protoEvent:currentEnvironment);
	//	~type=\note; currentEnvironment.play
});

(degree:1,nb:4, amp:0.2,
stretch:0.5, ambitus:[-2,2],
patternR:1000.rand)
.parent_((
	specs:(
		ambitus:[-7,7,nil,1],
		nb:[1,10,nil,0.5],
		stretch:[1,4,\exp,1],
		dur:[0.5,2,nil,0.5],
		degree:[-7,7,nil,1],
		patternR:[0,10000,nil,1],
		amp:\amp,
	),
	pat:Pbind(\type, \appo,
		\amp, Pfunc{~amp},
		\degree, Pfunc{~degree},
		\mtranspose, Plazy{
			Pseed(~patternR,Pwhite(*~ambitus).round(1))},
		\stretch, Pfunc{~stretch/2},
	)
));
)