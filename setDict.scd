(
{arg m, j;// set dicts.
m.collect({|f,dicts| f // premier partie des dicts  
.children[0] // useless ?
	.children.drop(-1) // y a un slider caché pour bouger le dict
	.collect({|s,params| s // tous les enfants du dict
		.children[0] // les trois types de val ??
		.children[0] // useless ?
		.children[..1]
		// finalement le EZ (sans interface, donc 1= slider)
		// on prend aussi le label pour setter
		.pairsDo{arg a, b;
			j.at(a.string.asSymbol);
			b.addAction{ arg self;
				var tmp=j.at(a.string.asSymbol).copy;
				tmp[dicts]=self.value; // TODO : after specs !
				j.perform((a.string.asSymbol++'_').asSymbol,tmp)
			}
		}
	})
});
};
)

(

//meme func pour l'autre sens

{arg m, ev;// set dicts.
m.collect({|f,dicts| f // premier partie des dicts  
.children[0] // useless ?
	.children.drop(-1) // y a un slider caché pour bouger le dict
	.collect({|s,params| s // tous les enfants du dict
		.children[2] // du coup c'est du texte
		.children[0] // useless ?
		.children[..1]
		// finalement le EZ (sans interface, donc 1= slider)
		// on prend aussi le label pour setter
		.pairsDo{arg label, widg;
			ev.at(label.string.asSymbol);
			widg.addAction{ arg self;
				var tmp=ev.at(a.string.asSymbol).copy;
				tmp[dicts]=self.value; // TODO : after specs !
				ev.perform((a.string.asSymbol).asSymbol)[]=tmp
			}
		}
	})
});
};

)