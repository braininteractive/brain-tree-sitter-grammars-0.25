; Inject Java into code blocks (<% %>, <%= %>, <%! %>)
((scriptlet (code) @injection.content)
 (#set! injection.language "java"))

((expression (code) @injection.content)
 (#set! injection.language "java"))

((declaration (code) @injection.content)
 (#set! injection.language "java"))

; Inject HTML into content between JSP tags
((content) @injection.content
 (#set! injection.language "html"))
