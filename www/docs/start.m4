<html>
  <head>
    <title>Protovis - How-To: Get Started</title>
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
      <div class="section">
        <a href="./">&laquo; Previous</a> /
        <a href="splom.html">Next &raquo;</a>
      </div>
    </div>

    <div class="body">
      <h1>How-To: Get Started</h1>

      <p>Protovis uses <a href="http://en.wikipedia.org/wiki/JavaScript"
      >JavaScript</a>. It helps if you&rsquo;re already familiar with the
      language, but it's not necessary; you can pick it up as you go, and learn
      by example. Here's a minimal but complete visualization that displays
      &ldquo;Hello, world!&rdquo;:

      <p><table><tr><td>

m4_include(`start-1.html.html')

      </td><td align="right"><script type="text/javascript+protovis">

m4_include(`start-2.js.txt')

      </script></td></tr></table>

      <p>You&rsquo;ll find more <a href="../ex/">off-the-shelf examples</a>
      included when you download Protovis.

      <p>(Most of the examples you'll see in the documentation use
      <a href="http://martinfowler.com/dslwip/MethodChaining.html">method
      chaining</a> to make specifications more concise. This means that the
      method to set a property returns a reference to the mark itself, allowing
      you to set multiple properties in a single statement. If you prefer a more
      traditional verbose style, you can use that instead.)

      <p>Breaking it down:

      <p>1. The first <tt>&lt;script&gt;</tt> element loads Protovis. You need
      to <a href="http://protovis-js.googlecode.com/files/protovis-3.2.zip">download
      protovis.js</a> and install it in the same directory as the HTML file you
      are editing, or update the path accordingly. The precise name of this file
      depends on which version you download; if you're just getting started, you
      probably want to use a development version, such as protovis-d3.2.js. You
      can place this <tt>&lt;script&gt;</tt> element anywhere you like, as long
      as it is loaded before you try to visualize anything. Inside
      the <tt>&lt;head&gt;</tt> element is a safe bet.

      <p>2. The second <tt>&lt;script&gt;</tt> element is your visualization!
      Pay close attention to the type attribute: <tt
      >text/javascript+protovis</tt>. This allows you to use expression closures
      in browsers other than Firefox. If you only want to use Firefox, or if you
      prefer to write proper functions, you can use the standard <tt
      >text/javascript</tt> instead.

      <p>3. The example visualization uses a panel that is 150 pixels wide and
      150 pixels tall. The SVG element is inserted into the document at the same
      location as the script. The words &ldquo;Hello, world!&rdquo; appear
      centered in the canvas.

      <p>To see more, browse our examples gallery and use your web browser to
      view the source. Thanks to JavaScript, Protovis visualizations are
      inherently open-source&mdash;you can see how any visualization is
      implemented and even access the underlying data set.

      <blockquote style="font-size:13px;">
        Next: <a href="splom.html">Scatterplot Matrix</a>
      </blockquote>
    </div>

    <div class="foot">
      Copyright 2010 <a href="http://vis.stanford.edu">Stanford Visualization Group</a>
    </div>

    <script type="text/javascript" src="http://www.google-analytics.com/ga.js"></script>
    <script type="text/javascript">_gat._getTracker("UA-10741907-2")._trackPageview();</script>
  </body>
</html>
