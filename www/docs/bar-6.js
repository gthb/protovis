new pv.Panel()
    .width(150)
    .height(150)
  .add(pv.Bar)
    .data([1, 1.2, 1.7, 1.5, .7])
    .bottom(2)
    .width(20)
    .height(function(d) d * 80)
    .left(function() this.index * 25 + 2)
    .strokeStyle(function(d) (d > 1) ? "red" : "black")
  .root.render();
