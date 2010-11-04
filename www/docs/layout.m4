<html>
  <head>
    <title>Protovis - Layouts</title>
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
      <h1>Layouts</h1>

      <blockquote>[When] you see excellent graphics, find out how they were
      done. Borrow strength from demonstrated excellence. The idea for
      information design is: Don&rsquo;t get it original, get it right. <a
      href="http://www.edwardtufte.com/bboard/q-and-a-fetch-msg?msg_id=00000p"
      >&mdash;Edward Tufte</a></blockquote>

      <h2>Introduction</h2>

      <p>At its core, Protovis is intended as a concise, declarative
      representation of <i>custom</i> data graphics. Implicit in the label
      &ldquo;custom&rdquo; is that visualization specifications are largely
      unique: the code is simple enough to not require reuse across charts,
      beyond basic copy-and-paste. Yet despite the inherent value in
      expressiveness and flexibility necessary to support custom graphics, it is
      obvious that most visualization designs are <i>not</i> unique. Thus, we
      introduce a mechanism to encapsulate useful techniques for reuse across
      visualizations, called <b>layouts</b>.

      <p>Layouts (in various forms) are common to many visualization and user
      interface toolkits&mdash;they reduce the code required to implement common
      visualizations types, while offering more consistent behavior by
      eliminating implementation-specific idiosyncrasies. Most importantly, they
      make available an extensible set of visualization designs for much lower
      cost, allowing these designs to see wider adoption.

      <p>Despite the prevalence of this approach, the exact form of abstraction
      matters. Competing with the desire to reuse layouts are two serious
      usability concerns: first, that the new abstraction will be difficult to
      learn; second, that the user must sacrifice expressiveness (i.e.,
      customization and control) to facilitate reuse. To avoid these pitfalls,
      Protovis layouts are implemented as a set of related <b>mark
      prototypes</b>. Unlike previous approaches, layouts in Protovis do not
      introduce new fundamental abstractions, instead repurposing prototypal
      inheritance; prototype marks provide default properties to instantiate the
      layout design, while allowing a great deal of customization through
      property overrides and construction.

      <h2>Design</h2>

      Layouts in Protovis are a minor specialization of <a
      href="panel.html">panels</a>, which contain and replicate child
      marks. Indeed, the only difference between a <i>panel</i> and a
      <i>layout</i> is that the latter can support custom properties. These
      custom properties allow top-level configuration of the layout; for
      example, a treemap layout might support multiple algorithms (e.g.,
      &ldquo;slide-and-dice&rdquo;, &ldquo;squarify&rdquo;,
      &ldquo;voronoi&rdquo;), while a force-directed network layout might allow
      tweaking of spring tension or drag coefficients. Whereas standard
      properties, such as <tt>fillStyle</tt> and <tt>visible</tt>, share a
      single namespace, layout properties tend to be special-purpose and are
      thus defined locally.

      <p>By reusing panels and properties, the design is familiar to existing
      users; the mental model required to understand layouts is simpler. In
      addition, this leverages the expressiveness of the core language: layouts
      can be replicated and embedded in the mark hierarchy as any other mark or
      panel, and, any layout properties can be specified using data-driven
      functions. This simplifies the creation of small multiples of layouts with
      varying parameters, and allows layouts to be nested hierarchically,
      similar to <a href="http://gicentre.org/hierarchical_layouts/" >HiVE</a>.
      We will explore example shortly.

      <h3>Limitations</h3>

      <p>Before we dive more deeply into the design, it is important to keep in
      mind two potential complications of our approach:

      <p>Layout implementations typically require an additional pre-processing
      step per instance, where the bulk of the layout work is performed; this is
      typically accomplished by overriding the internal <tt>buildImplied</tt>
      method. Although this detail can be overlooked by <i>users</i> of layouts,
      it must be understood to implement a new layout, and represents a
      divergence from standard mark and panel specification. This is discussed
      in more detail later in relation to <i>psuedo-properties</i>.

      <p>The minimalism of the layout interface means there is no guarantee of
      consistency across layout implementation: users must understand the
      semantics of the mark prototypes for each implementation in order to
      instantiate and customize the layout. A practical solution to this problem
      is the establishment of sensible practices across layout designs, and to
      reuse code whenever possible (e.g., across hierarchical and network
      layouts).

      <h3>Mark Prototypes</h3>

      The core idea behind Protovis layouts is that a set of related mark
      prototypes can instantiate reusable visualization designs. To better
      illustrate how mark prototypes are used, we now go through a series of
      example layout implementations. For each example, a diagram shows panel
      enclosure (using nested rectangles) and property inheritance (using
      directed arrows). Off-screen mark prototypes that are not directly visible
      are shown with a dashed outline.

      <p>The <b>grid</b> layout is arguably the simplest non-trivial layout
      implementation: given a two-dimensional array of data, it divides the
      layout panel into a series of equally-spaced rows and columns. It exports
      a single mark prototype, <tt>cell</tt>, with positional properties
      computed from the mark index. For instance, the left margin is <i>(width /
      cols) * (index % cols)</i>, where <i>cols</i> is the number of columns
      derived from the data. If our two-dimensional array contains numbers that
      represent elevation, we can make a simple topographic map using a grid of
      colored bars:

m4_include(`layout/grid.js.html')

      <p>Adding a layout to a visualization looks similar to adding a panel,
      with two differences: we use custom properties such as <tt>rows</tt> to
      configure the layout, and we add to a mark prototype such as <tt>cell</tt>
      rather than adding directly to the panel. By adding to the <tt>cell</tt>
      prototype in this example, we are creating a new <a
      href="bar.html">bar</a> that inherits properties from <tt>cell</tt>, while
      simultaneously adding it to the layout panel. As a diagram:

      <p><table width="100%"><tr><td>
        <img src="layout/grid.png">
      </td><td width="350" align="right" valign="middle">
        <a href="../ex/heatmap.html">
          <img src="layout/grid-ex.png" style="border: solid 3px #ccc;">
        </a>
      </td></tr></table>

      <p>Thus, the root panel <tt>vis</tt> contains the <tt>grid</tt> layout
      (line 1). The layout in turn contains the added bar (line 3); this bar
      extends from the <tt>cell</tt> prototype. We can override properties on
      the added bar (lines 4-6), which trump any default logic inherited from
      the prototype.

      <p>Note that the <tt>cell</tt> prototype is not contained inside the
      layout: this is what is meant by an &ldquo;off-screen&rdquo; prototype.
      The prototype is not rendered directly, being used only for extending
      properties to added marks (such as the bar, here). This gives the user
      control over and visibility into how marks are added to the scene graph:
      the user can choose the order in which marks are added, affecting
      <i>z-order</i>; the user can choose the <i>implementation</i> of the added
      mark (for example, using a panel or another layout rather than a bar); the
      user can <i>pick and choose</i> which prototype to add, if multiple
      prototypes are available.

      <h3>Data and Replication</h3>

      <p>All marks in Protovis have a <tt>data</tt> property that controls
      replication: a mark instance is created for each element in the data
      array. The <tt>cell</tt> prototype exported by the grid layout has
      a <tt>data</tt> property derived from the layout&rsquo;s
      <tt>rows</tt> property: the two-dimensional array is flattened (blended)
      into a one-dimensional array. The data on the added bar are thus the
      numbers in the heatmap array, which is then used to derive the fill style.

      <p>More powerful, and yet conceptually similar, is the <b>treemap</b>
      layout. Like the grid layout, treemaps can be instantiated by adding a bar
      to the layout&rsquo;s mark prototype; the treemap&rsquo;s prototype is
      called <tt>node</tt>&mdash;rather than <tt>cell</tt>&mdash;but serves a
      similar function in exporting positional properties based on the results
      of running the squarified treemap layout algorithm. (The choice of treemap
      algorithm can be specified using the <tt>mode</tt> custom property.) In
      addition, the treemap layout provides a <tt>label</tt> prototype that is
      slightly smarter than anchoring a label to the center of the bar:

      <p><table width="100%"><tr><td>
        <img src="layout/treemap.png">
      </td><td width="350" align="right" valign="middle">
        <a href="../ex/treemap.html">
          <img src="layout/treemap-ex.png" style="border: solid 3px #ccc;">
        </a>
      </td></tr></table>

      <p>The <tt>label</tt> prototype extends from the <tt>node</tt> prototype,
      although this is purely for the sake of convenience. We can instantiate a
      treemap by first adding it to a panel, then adding the node bar, and
      finally adding the label:

m4_include(`layout/treemap.js.html')

      <p>The layout can also be used as the root panel directly, if desired.

      <p>We have customized the treemap layout slightly by redefining the fill
      style: we use translucent blue for internal nodes, and opaque orange for
      leaf nodes. This in conjunction with the six-pixel padding makes it easy
      to see the tree structure through nested containment. We also override the
      label visibility so as to hide label on internal nodes; an alternative
      strategy would be to position the labels at the top-left corner, which can
      be done by adding a label to the bar:

m4_include(`layout/treemap-alt.js.html')

      <p>As with all properties in Protovis, properties are defined in terms of
      data. With layouts, this means that we can access the underlying data
      structure used by the layout when defining properties. For example, the
      treemap layout computes the <i>size</i> and <i>depth</i> of each node as a
      side-effect of running the treemap algorithm; these attributes are then
      exposed through the data and can be used to derive custom properties. Th
      above example uses the <tt>firstChild</tt> attribute to distinguish
      internal from leaf nodes.

      <p>By changing the definition of the inherited <tt>data</tt> properties,
      layouts can change how marks are replicated. For example, the
      <b>matrix</b> layout visualizes the adjacency matrix of a graph. The
      <tt>link</tt> prototype functions similar to the grid layout&rsquo;s
      <tt>cell</tt>, in that it is designed to be used with a bar to render a
      filled rectangle; in this case, the data property of the <tt>link</tt>
      prototype is every pair of nodes in the graph. The fill style is derived
      from the <tt>linkValue</tt> attribute, which is 0 if the nodes are not
      connected, and positive if they are.

      <p><table width="100%"><tr><td>
        <img src="layout/matrix.png">
      </td><td width="350" align="right" valign="middle">
        <a href="../ex/matrix.html">
          <img src="layout/matrix-ex.png" style="border: solid 3px #ccc;">
        </a>
      </td></tr></table>

      <p>Similarly, the <tt>label</tt> prototype&rsquo;s data array contains two
      references to each node in the graph, such that a label can be generated
      across the top of the matrix, and down the left side. Labels can be
      rendered in alternative positions by overriding the <tt>left</tt>
      and <tt>top</tt> properties if desired.

      <h3>Implicit Replication</h3>

      <p>While the <tt>data</tt> property provides one level of replication,
      with some layouts this is insufficient: a second level of replication is
      needed. This is accomplished by inserting a panel between the layout and
      any added marks. For example, the <b>stack</b> layout can be used to
      generate a <i>streamgraph</i>, which contains multiple stacked area marks.
      The data for the area is derived from the <tt>layer</tt> prototype, and
      contains each value for the associated series; the layers are replicated
      in an enclosing panel, with one instance per series.

      <p><table width="100%"><tr><td>
        <img src="layout/stack.png">
      </td><td width="350" align="right" valign="middle">
        <a href="../ex/stream.html">
          <img src="layout/stack-ex.png" style="border: solid 3px #ccc;">
        </a>
      </td></tr></table>

      <p>We call this <i>implicit</i> replication because the interstitial panel
      is not explicitly added by the user. Instead, the panel is inserted by the
      layout when the area is added to the <tt>layer</tt> prototype:

m4_include(`layout/stack.js.html')

      <p>The stack layout also makes use of special properties that are
      evaluated by the layout, rather than using the standard property
      evaluation mechanism: we call these <i>psuedo-properties</i>. For example,
      the <tt>x</tt> and <tt>y</tt> properties are evaluated for each value in
      each layer. In effect, these properties behave as if they were defined on
      the added area rather than the layout, but they are evaluated earlier
      along with the other layout properties (during the stack layout&rsquo;s
      <tt>buildImplied</tt>). The stack layout stores the return values of these
      psuedo-properties internally, and uses this generated data (the layer
      thickness for each value in the dataset) to define the inherited mark
      properties.

      <p>Thus, although psuedo-properties are evaluated through a different
      mechanism than standard properties, users can, in general, blissfully
      ignore the difference. Psuedo-properties can be defined in identical
      fashion to standard properties, as either functions or constants. With the
      stack layout, for example, we might use a linear scale for <tt>x</tt>
      and <tt>y</tt>. The psuedo-properties are evaluated in the same context as
      normal properties, and thus can access the data and index
      (<tt>this.index</tt>) transparently. Psuedo-properties can also be used to
      provide comparator functions to order-dependent layouts (such as the
      previously-discussed matrix layout), in order to sort the data; in this
      case, the evaluation order of the psuedo-property is dependent on the sort
      algorithm.

      <p>Implicit replication offers surprising flexibility in terms of layout
      implementation. The <b>horizon</b> layout, for example, uses a panel to
      replicate an area mark for each band; the band is then cropped by setting
      the the panel&rsquo;s <tt>overflow</tt> property to &ldquo;hidden&rdquo;:

      <p><table width="100%"><tr><td>
        <img src="layout/horizon.png">
      </td><td width="350" align="right" valign="middle">
        <a href="../ex/horizon.html">
          <img src="layout/horizon-ex.png" style="border: solid 3px #ccc;">
        </a>
      </td></tr></table>

      <p>Node-link diagrams, such as the radial <b>tree</b> layout, also use
      implicit replication for the <tt>link</tt> prototype. With this layout,
      the <tt>link</tt> prototype is intended to be used with a <a
      href="line.html">line</a>, and the <tt>data</tt> property is a two-element
      array for the source node and target node of each link. The interstitial
      panel&rsquo;s data is, correspondingly, the array of all links:

      <p><table width="100%"><tr><td>
        <img src="layout/tree.png">
      </td><td width="350" align="right" valign="middle">
        <a href="../ex/tree.html">
          <img src="layout/tree-ex.png" style="border: solid 3px #ccc;">
        </a>
      </td></tr></table>

      <p>The three prototypes provided by the tree layout match those provided
      by the other <b>network</b> and <b>hierarchy</b> layouts&mdash;two
      abstract layouts designed to share code across implementations. After the
      layout is configured, the user can instantiate the link, node and label in
      the desired z-order:

m4_include(`layout/tree.js.html')

      <p>As this example shows, while some amount of duplicate code is necessary
      with this system to instantiate the mark prototypes, the amount of code is
      negligible. Furthermore, almost all visualizations will desire
      customization, even if only to override a single property, or change the
      z-order or added marks. The Protovis layout architecture allows powerful
      visualization techniques to be encapsulated for reuse, while retaining a
      great deal of flexibility through prototypal inheritance.

      <h2>Related Reading</h2>

      Bederson, B. B., J. Grosjean, &amp; J. Meyer. <a
      href="http://www.cs.umd.edu/hcil/jazz/learn/Toolkit_Design_2004.pdf">Toolkit
      Design for Interactive Structured Graphics</a>, <i>IEEE Transactions on
      Software Engineering</i>, 30 (8), pp. 535-546, 2004.

      <p>Heer, J. &amp; Agrawala, M. <a
      href="http://vis.berkeley.edu/papers/infovis_design_patterns/">Software
      Design Patterns for Information Visualization</a>, <i>IEEE Transactions on
      Visualization and Computer Graphics (TVCG)</i>, 12 (5). Sep/Oct 2006.

    </div>

    <div class="foot">
      Copyright 2010 <a href="http://vis.stanford.edu">Stanford Visualization Group</a>
    </div>

    <script type="text/javascript" src="http://www.google-analytics.com/ga.js"></script>
    <script type="text/javascript">_gat._getTracker("UA-10741907-2")._trackPageview();</script>
  </body>
</html>
