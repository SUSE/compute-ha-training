<!-- .slide: data-state="section-break" id="template-slides" -->
# Template slides
## `<h2>` works here too


<!-- .slide: data-state="normal" id="nested-lists" -->
## Title of No-Logo Slide Here

*   First-level bullet
    *   Second-level bullet
        *   Third-level bullet
            *   Fourth-level bullet


<!-- .slide: data-state="normal" id="graphics-and-typeface" -->
## Graphics and Typeface

<div class="slide-section">
    <h3> Primary Icon Color </h3>
    <img src="images/SUSE/bars.png" style="width: 150px;" />
    <img src="images/SUSE/disk.png" style="width:  80px;" />
    <div class="icons-typeface">
        <p>
            <b>Icons:</b> Icon libraries are available for download in
            bubble and 3-D designs. The primary color for SUSE is
            green.
        </p>
        <p>
            <b>Typeface:</b> Arial is the typeface for all SUSE
            presentations.
        </p>
    </div>
</div>
<div class="slide-section">
    <h3> Bubble </h3>
    <img src="images/SUSE/folder.png" style="width:  100px;" />
    <img src="images/SUSE/computer.png" style="width:  100px;" />
    <img src="images/SUSE/right-arrow.png" style="width:  100px;" />
    <img src="images/SUSE/squeeze-arrows.png" style="width:  100px;" />
    <img src="images/SUSE/USB.png" style="width:  100px;" />
    <img src="images/SUSE/bug.png" style="width:  100px;" />
    <img src="images/SUSE/cylinder.png" style="width:  100px;" />
    <img src="images/SUSE/brain.png" style="width:  100px;" />
</div>
<div class="slide-section">
    <h3> 3D </h3>
    <img src="images/SUSE/desktop-computer.png" style="width:  80px;" />
    <img src="images/SUSE/pie.png" style="width:  80px;" />
    <img src="images/SUSE/meters.png" style="width:  80px;" />
    <img src="images/SUSE/office.png" style="width:  80px;" />
    <img src="images/SUSE/printer.png" style="width:  80px;" />
    <img src="images/SUSE/box.png" style="width:  80px;" />
    <img src="images/SUSE/app-window.png" style="width:  80px;" />
    <img src="images/SUSE/darts.png" style="width:  80px;" />
</div>


<!-- .slide: data-state="normal" id="syntax-highlighting" -->
## Code syntax highlighting

Works out of the box using [`highlight.js`](https://highlightjs.org/)
and a custom color theme with official SUSE colors:

```js
Reveal.addEventListener('somestate', function() {
    // TODO: Sprinkle magic
}, false );
```

in different languages:

```ruby
# Ping with 5 seconds timeout and a single attempt
def ping! node
  command = ["ping", "-q -c 5 -w 5 #{node.ip}"]
  result = exec!(*command)
  if result.exit_code.nonzero?
    raise PingError.new(command, result.output)
  end
  result, :foo
end
```


<!-- .slide: data-state="normal" id="call-to-action" data-menu-title="Call to action" -->
<div class="call-to-action">
    <h2 class="inside">
        Call to action line one <br />
        and call to action line two <br />
        <a href="http://www.calltoaction.com">www.calltoaction.com</a>
    </h2>

    <h2 class="outside">
        Thank you.
    </h2>
</div>
