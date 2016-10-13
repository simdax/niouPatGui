(
~specs=(
	seed:[0,1000, nil, 1],
	seedDur:[0,1000, nil, 1],
	setDur:[1, 4, nil, 1], setDeg:[-3,3,nil,1],
);
~p=(
	pat:Pbind().fin(1),
	papat:{arg s;
		var keys=s.keys.as(Array);
		var io=(keys+++(keys.collect({|k| s[k].class.switch(
			Array, {s[k].pseq}, {Pfunc{s[k]}}
		) }))).flatten;
		(s.pat <> Pbind(*io))
	},
	embedInStream:{arg s, in;  s.papat.embedInStream(in)},
	specs:~specs
);
~pats=(
	val:(rand:{arg s; var h; 
		 h=s[\w]?((1!s[\set].size).normalizeSum);
		Pseed(s[\seed], Pwrand(s[\set],h,inf))
	}).proto_((set:[1,2],seed:0)),
	event:(phrase:{arg s;
		var reste=s.time*(s.fin.reciprocal);
		var phrase=(s.pat?Pbind()).asStream;
		Pseq([ phrase, Pbind(\dur, reste)<>phrase.next])
	})
);
)


(

)
(seedDeg:2).specs_(~specs).gui(4)

(n=FlowView();
a=(seed:9, set:[0,4], specs:(set:[0,4,nil,1])).parent_(~p).proto_(~mel);
b=(dur:[1, 1, 2]).parent_(~p);
a.gui(3,n);
b.gui(3,n);
e=EventPatternProxy((Pn(a)<>Pn(b)).trace);
Button(n).action_{ e.toggle}
)

