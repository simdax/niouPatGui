(

a=(env:Env([0,1,0,8,2].normalizeSum, [2,1,5]),
embedInStream:{arg s, in=();
	if(s.env.class==Array)
	{Env(s.env[0],s.env[1].differentiate)}
	{s.env}
	.asPseg.trace.embedInStream(in)},
play:{arg s; s.asStream.trace.play}
);

b=(~protoGui %% (gui:EnvelopeView, model:a, msg:\env,
	constructGui:{
		s.view=s.gui.new(p,b)
		s.value_(s.model.perform(s.msg.asGetter))
		.action_{arg self; var res=self.value;
			s[\model].perform(s[\msg].asSetter,
				if(s.spec.notNil){s.spec.map(res)}{res}
			)}
	},

	
	init:{arg self; self.view.setEnv(self.model.env)}));
b.go;

Pbind(
	\dur, 0.25,//Prand([2,1], inf),
	\freq, Pn(a),
	\freq, 400+(50*Pkey(\freq))
).trace.play

)

//// MSV

a=MultiSliderView().front
.value_(Array.rand(480,0,0.9))
.drawLines_(true)
// .drawRects_(false)
.isFilled_(true)
.thumbSize_(1)
.gap_(0)
.colors_(Color.rand, Color.rand)
.showIndex_(true)

a.reference
