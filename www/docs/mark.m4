<html>
  <head>
    <title>Protovis - Marks</title>
    <link type="text/css" rel="stylesheet" href="../style.css?3.2"/>
    <link type="text/css" rel="stylesheet" href="../ex/syntax.css?3.2"/>
    <script type="text/javascript" src="../protovis-r3.2.js"></script>
  </head>
  <body>

    <div class="title">
      <div class="subtitle">
        A graphical toolkit for visualization
      </div>
      <a href="../">Protovis</a>
    </div>

    <div class="head">
      <div class="section">
        <a href="../">Overview</a>
      </div>
      <div class="section">
        <a href="../ex/">Examples</a>
      </div>
      <div class="section selected">
        <a href="../docs/">Documentation</a>
      </div>
      <div class="section">
        <a href="http://protovis-js.googlecode.com/files/protovis-3.2.zip">Download</a>
      </div>
    </div>
    <div class="subhead">
      <div class="section">
        <a href="./">Index</a>
      </div>
    </div>

    <div class="body">
      <h1>Marks</h1>

      <p>All graphical elements in Protovis are called <b>marks</b>. The
      <tt>pv.Mark</tt> class itself does not provide any specific rendering
      functionality, and is rarely used directly (unless you're defining a new
      mark type), but together with <a href="panel.html">panels</a> establishes
      the core framework.

      <blockquote>
        See also:
        <a href="../jsdoc/symbols/pv.Mark.html">pv.Mark API reference</a>
      </blockquote>

      <h2>Properties</h2>

      <p>All marks have at least the following properties:

      <ul>
      <li><tt>data</tt> - an array of objects.</li>
      <li><tt>visible</tt> - a boolean controlling visibility.</li>
      <li><tt>left</tt>, <tt>right</tt>, <tt>top</tt> and <tt>bottom</tt> - the margins; see <a href="bar.html">Bar</a> for semantics.</li>
      <li><tt>cursor</tt> - an optional <a href="http://www.w3.org/TR/CSS2/ui.html#propdef-cursor">CSS2 cursor</a>.</li>
      <li><tt>title</tt> - an optional tooltip; a string.</li>
      </ul>

      <p>Concrete mark types include familiar visual elements such
      as <a href="bar.html">bars</a>, <a href="line.html">lines</a>
      and <a href="label.html">labels</a>. Although a bar <i>mark</i> may be
      used to construct a bar <i>chart</i>, marks know nothing about charts; it
      is only through their specification and composition that charts are
      produced. These building blocks permit many combinatorial possibilities.

      <p>Marks are associated with <b>data</b>: a mark is rendered once per
      associated datum, mapping the datum to visual <b>properties</b> such as
      position and color. Thus, a single mark specification represents a set of
      visual elements that share the same data and visual encoding. In the case
      of a bar, each datum corresponds to a solid rectangle, while with an area,
      each datum corresponds to a vertical or horizontal span.

      <p>Unlike other visualization systems, Protovis does not place any
      constraints on the input data, other than each mark has some associated
      array of data objects. In the simplest case, the data is just an array of
      numbers; but by defining suitable property functions, any the elements can
      be structured objects or even nested arrays.

      <p>The type of mark defines the names of properties and their meaning. A
      property may be static, ignoring the associated datum and returning a
      constant (e.g., <tt>20</tt>); or, it may be dynamic, derived from the
      associated datum or index (e.g., <tt>d * 80</tt>). Such dynamic encodings
      can be specified succinctly using anonymous functions. Special properties
      called event handlers can be registered to add interactivity.

      <p>Some mark types, such as lines and areas, may generate a single visual
      element rather than a distinct visual element per datum. With these marks,
      some properties may be <i>fixed</i>. Fixed properties can vary per mark,
      but not per datum. These properties are evaluated solely for the first
      (0-index) datum. The handful of properties that have this constraint are
      clearly flagged as such (and in fact, usually there's a workaround to make
      them dynamic again).

      <p>Marks may also inherit properties from type-specific defaults. For
      example, bars and wedges define default fill colors.
    </div>

    <div class="foot">
      Copyright 2010 <a href="http://vis.stanford.edu">Stanford Visualization Group</a>
    </div>

    <script type="text/javascript" src="http://www.google-analytics.com/ga.js"></script>
    <script type="text/javascript">_gat._getTracker("UA-10741907-2")._trackPageview();</script>
  </body>
</html>
