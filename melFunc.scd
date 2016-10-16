(
var b, // the mel Pattern (in resketch)
a, //list for instr
x//dict instr + amp
;

b=Ouf.resketch;
b.line.win.bounds_(Rect(0,230,400,200));
a=SDP.listGui(b.line.win)
.globalAction_{arg y; x.instrument=y.item};
x=(amp:0.2,instrument:\harpsichord1);
b.line.timeline.pattern_( (b.line.timeline.pattern<>x));
)