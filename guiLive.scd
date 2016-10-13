(
a=(seed:8).parent_((embedInStream:{arg s,in;
		Pseed(Pfunc{s.seed}.trace,Pwhite(0,10)).embedInStream(in)},
	pat:{arg s; Pbind(\degree, Plazy{s}).trace},
	g:{arg s; var n=FlowView();
		var gui=s.gui(8, n);
		var pv;s.proto=(proxy:EPP(s.pat));
		pv=gui.viewForParam(\seed);
		pv.action=pv.action.addFunc
		({"recom".postln;s.proxy.source_(s.pat)});
		Button(n).string_("go").action_{s.proxy.toggle};
		Button(n).string_("add").action_{ arg sss;
			TextField(nil,sss.absoluteBounds).front.keyDownAction_{arg ss,c,mod,u; 
				u.switch(13,{a.put(ss.string.asSymbol, 2)})
			}
		}
	})
);


a.g
)
