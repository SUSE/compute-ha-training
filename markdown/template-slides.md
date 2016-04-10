<!-- .slide: data-state="break" id="template-slides" -->
# Template slides
## `<h2>` works here too


<!-- .slide: data-state="normal" id="nested-lists" -->
## Title of No-Logo Slide Here

*   First-level bullet
    *   Second-level bullet
        *   Third-level bullet
            *   Fourth-level bullet


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
