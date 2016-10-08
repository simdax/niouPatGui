(
{
	arg dicts;
	var x=dicts.collect(_.params);
	var k=x[0].keys;
	k.collect({|y| y->x.collect(_.perform(y)) })

}
)