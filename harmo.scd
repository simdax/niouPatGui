(
var bob;
Event.addEventType(\harmo,{
	bob.parent.transpose=~index;
});

bob=
(basse:0)
.parent_(
	(
		transpose:0,
		specs:(basse:[-3,3,nil,1]),
		pat:Pbind(\type, \rest,\scale,
			Pchords(Pfunc{~basse+~transpose})
		),
		embedInStream:{arg s,in=(); s.use{~pat.embedInStream(in)}},
		gui:{ arg s, p=FlowView();
			var f=Pchange.live%= (list:[0,0,4,0,0,3,4,0]);
			Pdef(\basse,
				Ppar([
					(Pbind(\type,\harmo)<>f),
					Plazy{s},
				]).trace
			);
			MyEnvirGui(s,s.size,p);
			Button(p).string_("play basse")
			.action_{
				Pdef(\basse).toggle
			};
			Button(p).string_("set basse")
			.action_{
				f.gui; 
			}
		}
	)
);


)



