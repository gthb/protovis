new pv.Panel()
    .width(660)
    .height(32)
  .add(pv.Panel)
    .data(pv.Colors.category20().range())
    .left(function() this.index * 34)
    .width(32)
    .fillStyle(function(d) d)
    .title(function(d) d.color)
  .root.render();
