(

~specs=(
	seed:[0,1000, nil, 1],
	seedDur:[0,1000, nil, 1],
	setDur:[1, 4, nil, 1], setDeg:[-3,3,nil,1],
);
~filtre=(basse:Pchords);
~base=(fin:`2);
~p=(
	pat:{arg s; Pbind(\degree, Plazy{s}).trace},
	g:{arg s; var n=FlowView();
		s.proxy=EPP(s.pat); var action;
		s.gui(1, n);
		.viewForParam(\seed).action=addAction_()
		Button(n).action_{s.proxy.toggle}
	}),
	fin:`2,
	pat:{arg s; s.use{
		(~fin.value==inf).if{Pbind().fin(1).repeat}
		{
			~fin.value.isFloat.if
			{Pbind().finDur(~fin)}
			{Pbind().fin(~fin)}
		}
	}},
	list:[], listDo:{arg s; s.use{ 
		~list.keysValuesDo{arg k,v; [k,v.value] }
	}},
	papat:{arg s; s.use{
		var keys=s.keys.as(Array);
		var io=(keys+++(keys.collect({|k|
			k.switch(*s.listDo.asPairs ++
				{s[k].class.switch(
					//	String, {Pseed(s[k].collectAs(_.digit,Array))}
					Array, {s[k].pseq},
					Ref, { Pfunc{s[k].value}},
					{Pfunc{s[k]}}
				)}
			);
		}))).flatten;
		(s.pat <> Pbind(*io))
	}},
	//	play:{Pn(p{arg in;Pbind().embedInStream(in)}).trace.play},
	embedInStream:{arg s, in;  s.papat.embedInStream(in)},
	specs:~specs
);
~pats=(
	val:(rand:{arg s; var h; 
		 h=s[\w]?((1!s[\set].size).normalizeSum);
		Pseed(Pfunc{s[\seed]}, Pwrand(s[\set],h,inf))
	}).parent_((set:[1,2],seed:0)),
	event:(
		phrase:{arg s;
			var reste=s.time*(s.fin.reciprocal);
			var phrase=(s.pat?Pbind()).asStream;
			Pseq([ phrase, Pbind(\dur, reste)<>phrase.next])
		},
		harmo:{arg s;
			Pbind(\degree,Pfunc{~harmo[\basse]})
		},
		arp:{arg s;
			Pbind(\degree, )
		}
	)
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

