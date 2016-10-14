
(
"live.scd".loadRelative;

~io=().proto_(~base).parent_(~p);
~io.putPairs([\degree,1,\dur,1, \fin, `3]).g;
~io.spl
)



