(

(
params:(octave:5, seedDeg:0, seedDur:2, stretch:4, time:4),
pat: {arg s;
	Pbind(
		\octave, Pfunc{s.params.octave},
		\degree, Pseed(Pfunc{s.params.seedDeg},Prand([0,5],inf)),
		\dur,    Pseed(Pfunc{s.params.seedDur},Prand([1,2,3,4],inf)),
		\octave, Pfunc{s.params.octave},
		\stretch, Pfunc{s.params.stretch.reciprocal},
	).finDur(Pfunc{s.params.time}.asStream).repeat
}, gi:{arg s, pa; s.pat.play; s.params.gui(3)}
);


)