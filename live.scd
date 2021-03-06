(

Event.addEventType(\appo,{ arg self;
	var dur;
	~degree=(~degree+~mtranspose).degreeToKey(~scale?[0,2,4],7);
	~scale=~mode ? [0,2,4,5,7,9,11];
	~mtranspose=Array.rand(~appo?0, -1,1);
	dur=(~dur!(1+~appo)).normalizeSum * ~dur;
	~type=\note;
	Pbind(\dur, dur.pseq).play(protoEvent:currentEnvironment);
	//	~type=\note; currentEnvironment.play
});

"flopDict.scd".loadRelative;
~g={arg s; var n=FlowView();
	var gui=s.gui(8, n, options:\proto);
	s.proto??{s.proto=()};
	s.proto.putPairs([\gui, gui, \win,n,\proxy, EPP(s.papat.trace)]);
	Button(n).string_("go").action_{s.proxy.toggle};
	Button(n).string_("source").action_{s.proxy.source_(s.papat.trace)};
	Button(n).string_("add").action_{ arg sss;
		TextField(nil,sss.absoluteBounds)
		.front.keyDownAction_{arg ss,c,mod,u; 
			u.switch(13,{s.put(ss.string.asSymbol, 2);
				ss.remove})
		}
	};
	Button(n).string_("remove").action_{ arg self;
		FlowView(nil,self.absoluteBounds.extent_(20@20))
	};
};
~specs=(
	degree:[-35, 35, nil, 1],
	seed:[0,1000, nil, 1],
	seedDur:[0,1000, nil, 1],
	setDur:[1, 4, nil, 1], setDeg:[-3,3,nil,1],
);
~filtre=(basse:Pchords);
~base=(fin:`inf);
~p=(
	spl:~envir,
	g:~g,
	fin:`inf,
	postPat:{arg s; s.use{
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
		(s.postPat <> Pbind(*io))
	}},
	//	play:{Pn(p{arg in;Pbind().embedInStream(in)}).trace.play},
	embedInStream:{arg s, in;  s.papat.collect{|x|s.value=x}.embedInStream(in)},
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
).parent_(~p);

//define type
~patGui={arg ...args;
	args.as(Event).parent_(~p);
}
)



