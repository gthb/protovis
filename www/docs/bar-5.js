new pv.Panel()
    .width(150)
    .height(150)
  .add(pv.Bar)
    .data(["red", "orange", "yellow", "green", "blue", "purple"])
    .left(0)
    .right(0)
    .height(25)
    .top(function() this.index * 25)
    .fillStyle(function(d) d)
  .root.render();
