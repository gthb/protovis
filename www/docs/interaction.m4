<html>
  <head>
    <title>Protovis - Interaction</title>
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
      <h1>Interaction</h1>

      <p>Description forthcoming.

      <p>Note: event handlers are inherited by children, but not (currently)
      from the prototype.

      <h2>Example: Mouseover Highlight (V1)</h2>

      <p><table><tr><td>

m4_include(`interaction-1.js.html')

      </td><td align="right"><script type="text/javascript+protovis">

m4_include(`interaction-1.js.txt')

      </script></td></tr></table>

      <p>This example is discussed in more detail in
      the <a href="def.html">local variables documentation</a>.

       <h2>Example: Mouseover Highlight (V2)</h2>

      <p><table><tr><td>

m4_include(`interaction-2.js.html')

      </td><td align="right"><script type="text/javascript+protovis">

m4_include(`interaction-2.js.txt')

      </script></td></tr></table>

       <h2>Example: Mouseover Highlight (V3)</h2>

      <p><table><tr><td>

m4_include(`interaction-3.js.html')

      </td><td align="right"><script type="text/javascript+protovis">

m4_include(`interaction-3.js.txt')

      </script></td></tr></table>

       <h2>Example: Links</h2>

       <p>Hyperlinks can be implemented using the <tt>cursor</tt> property and
       &ldquo;click&rdquo; event. For best usability, you should also set the
       status on &ldquo;mouseover&rdquo; and &ldquo;mouseout&rdquo; events, as
       well as a title property for a tooltip. (Perhaps in the future, we'll
       make an <tt>href</tt> convenience method that sets all these properties
       as once.) For example:

      <p><table><tr><td>

m4_include(`interaction-4.js.html')

      </td><td align="right"><script type="text/javascript+protovis">

m4_include(`interaction-4.js.txt')

      </script></td></tr></table>

       <p>Note that the event handler gets passed the full data stack, like
       other property functions. So you can compute the target URL from data if
       needed:

m4_include(`interaction-5.js.html')

       <p>See <a href="../ex/treemap.html">Treemaps</a> for a live example.

       <h2>Types of Interaction</h2>

       <p><b>External controls.</b> This is the simplest type of interaction to
       support, if everything happens outside of Protovis. User interface
       elements are created externally, and event handlers on those interface
       elements trigger changes to the Protovis specification, which is then
       re-rendered. It may be useful to support additional user interface
       elements that are not part of the HTML standard, such as sliders. As with
       time-based animation, efficient update of the visualization based on
       minimal changes may also be required for fluid interaction (see below).

       <p><i>Example</i>: periodic table of elements, with range sliders to
       highlight elements with the given atomic radii; crimespotting with
       external controls to filter by time of day or type of crime; other
       Schneiderman dynamic query examples.

       <p><b>Tooltips.</b> Another trivial form of interaction, provided that
       tooltips are supported natively by the rendering platform (true of SVG,
       VML and Flash). The tooltip text can be defined staticly. Of course, rich
       tooltips (arbitrary graphics, HTML) may be more difficult to implement.

       <p><i>Example</i>: pie chart showing value on hover.

       <p><b>Scrolling and zooming.</b> While browsers can support native
       scrolling for large visualizations, there may be other cases where we
       want to make scrolling part of the visualization; for example if the data
       set is very large and loaded (or computed) dynamically. Furthermore,
       browsers do not support zooming (with the exception of the iPhone and
       primitive text size adjustments), so having a way to zoom to a particular
       region is needed. Additionally, scrolling and zooming may be data-driven:
       for example, you might have a map of crimes, and want to resize and
       re-center the display to show all crimes that fit the current query.

       <p><i>Example</i>: Google Finance-style focus + context, where you see
       the relative performance of a stock over time in detail for some fixed
       time period, and performance for the entire history along the bottom,
       allowing you to select the date range for the focus; ggobi examples.

       <p><b>Mark-driven events.</b> Some forms of interaction are driven by
       discrete marks. For example, hovering over an individual crime in
       crimespotting will place an aura around related crimes (crimes of the
       same type). In the homicide visualization, clicking on a point in a
       scatterplot allows query relaxation: selecting related crimes by date,
       then week, then month. In the Job Voyager, clicking on an individual area
       brings that occupation to focus, hiding other occupations.

       <p>As with sliders for external controls, Protovis may also benefit from
       integrated user interface widgets, such as pop-up menus, or
       shift-selection.

       <p>Linking?

       <p><i>Example</i>: Job Voyager, clicking on an individual area.

       <p><b>Coordinate-driven events.</b> Other forms of interaction are driven
       by coordinate spaces. For example, in the homicide visualization,
       dragging a box across the scatterplot determines a dynamic query
       (selected range in two dimensions that is used to filter or highlight
       visual elements).

       <p>This will require that we compute the local coordinates of events
       relative to the parent panel of the associated mark. Note that Protovis
       doesn't use traditional Cartesian coordinates, but instead margins, so
       we'll compute left, right, top and bottom for mouse events. Event
       handlers can then translate this back into abstract coordinates using a
       scale.

       <p>Brushing?

       <p><i>Example</i>: Job Voyager, tooltip varies along x-axis by year
       (although technically, this may be better considered a mark-driven event,
       and the implementation of area and line updated accordingly such that
       title is not a fixed property); homicide visualization, selecting a date
       or age range on the scatterplot filters points on a map; some sort of
       linked scatterplot and pie chart, where selecting a range in two
       dimensions with the scatterplot shows a rollup in the pie chart by a
       third dimension (encoded with color).

       <h2>Design</h2>

       <p>Many of these interactive features are dependent on efficient
       rendering: efficient re-evaluation of properties, and efficent
       re-application of evaluated properties to the display (scene). We can
       treat these as partially-separable problems.

       <h3>Efficient Re-evaluation</h3>

       <p>Because properties can be specified as functions rather than
       constants, we can't know a priori which functions need to be
       re-evaluated&mdash;unless we want to get into parsing the code itself and
       looking for data dependencies, which is hard. So how will Protovis know
       which properties need recomputing?  The user might designate some
       properties as &ldquo;volatile&rdquo; so that Protovis knows to recompute them even if
       their definitions haven't changed. (Constants can never be volatile.) Or,
       we could assume functions are volatile, and have a way of marking
       functions as &ldquo;cached&rdquo; so they aren't recomputed.

       <p>Or, we could force users to dirty properties explicitly even if they
       haven't changed, so that Protovis knows to recompute them. Different
       transitions may make different properties dirty, so this may be a more
       precise solution than declaring properties to be volatile.

       <p>Or, we could assume functions are only dependent on data, and
       recompute functions if the associated data has changed. Though, in many
       cases the data itself is computed as a function (e.g., panel recursion)
       so this could trigger unnecessary recomputations if only a small part of
       the data changes.

       <p>A related optimization is tracking with properties are functions and
       which are constants, such that the overhead of function invocation can be
       avoided for constant properties. This has already been implemented.

       <h3>Efficient Re-display</h3>

       <p>Given a new scene graph, the next difficulty is efficiently updating
       the display to match the new scene graph.  First, we must identify the
       parts of the scene graph that have changed and need to be updated. If we
       mark parts of the scene graph as dirty, or issue update requests on parts
       of the scene graph (rather than the entire thing), we can be more
       efficient about updating. The level of specificity might be a mark (all
       of its instances and children), a mark instance, or individual properties
       on a given mark instance.

       <p>However, incremental updates of the scene graph are tricky if the
       changes to the scene graph are structrual: i.e., if new SVG elements need
       to be created, removed, or re-ordered. New SVG elements may even be
       needed with non-structural changes to the scene graph, as in the case of
       a new title attribute (requiring an a element) or fill on a panel
       (requiring a rect element).

       <p>A further difficulty is inserting SVG elements into the DOM at the
       correct location. Determining this location requires careful bookkeeping,
       especially since a panel may reuse the g element from the parent panel if
       no transform is needed. It is also not as simple as looking at the
       previous or next mark in the containing panel: a new mark may have been
       added to the panel, and may not have siblings, or those siblings may be
       invisible. Also consider the reverse property (and potentially a future
       zIndex property), which may require re-ordering SVG elements, even if the
       scene graph changes are not structural.

       <p>Regenerating the entire SVG tree on re-render is not only inefficient,
       but may also interfere with event handling. For example, if a render is
       triggered from a mouseover event, the element that triggered the event
       will be removed from the DOM (potentially replaced with an identical
       element), and may fire a spurious mouseout event (unconfirmed). Similarly
       if an event handler triggers a manipulation of an SVG element, such as
       changing the fill color, a re-render will cause the new fill color to be
       discarded when the SVG tree is recreated.

       <p>Structural changes to scene graphs (and the SVG tree) should be comparatively rare

       <h3>Event-Driven Manipulation</h3>

       <p>The ideal API for manipulating the visualization specification from an
       event handler is as yet unclear. The current (2.6) behavior allows
       evaluated properties to be reassigned from an event handler. This allows
       for concise proof-of-concept demonstrations of interactivity, but suffers
       from a number of drawbacks:

       <p>1. Implied properties are not updated correctly. For example, if the
       endAngle property of a wedge is modified, the angle property will not be
       updated accordingly: the angle property is non-null because it was
       previously computed as an implied property, and we no longer know it's
       implied. (Admittedly, an easy fix to this problem is to track more
       explicitly which properties are implied, and update them accordingly.)

       <p>2. Undoing temporary manipulations is tedious. For example, if I want
       to change the fill color of a bar on mouse over, I have to squirrel away
       the previous fill color so I can restore it on mouse out. The more
       complex my temporary manipulation, the more bookkeeping required to undo
       it, making drift (visual discrepancies) more likely.

       <p>3. It overloads the behavior of property methods (again), while
       limiting the types of changes that can be made from event
       handlers. Inside an event handler, calling <tt>fillStyle("red")</tt>
       doesn't redefine the fillStyle property to the constant "red", as it does
       elsewhere; it simply overrides the evaluated property for the mark
       instance that is associated with the event. This is concise by confusing.

       <p>4. Furthermore, if you wanted to redefine a mark property in an event
       handler, you couldn't&mdash;short of setting the
       internal <tt>$fillStyle</tt>, which is a hack. This is true even if your
       event handler calls another function to redefine the
       visualization. However, it's only true of the mark that generated the
       event; the other marks don't have an index property set, so their
       property method behavior is unchanged. Talk about confusing!

       <p>One alternative may be to allow the specification of property
       overrides from an event handler (e.g., mouseover). These overrides can
       then easily be removed from another event handlers (e.g., mouseout).
    </div>

    <div class="foot">
      Copyright 2010 <a href="http://vis.stanford.edu">Stanford Visualization Group</a>
    </div>

    <script type="text/javascript" src="http://www.google-analytics.com/ga.js"></script>
    <script type="text/javascript">_gat._getTracker("UA-10741907-2")._trackPageview();</script>
  </body>
</html>
