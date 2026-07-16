; JSP comments
(comment) @comment

; JSP delimiters
[
  "<%--"
  "--%>"
  "<%@"
  "<%!"
  "<%="
  "<%"
  "%>"
] @keyword

; EL expression delimiters
(el_expression
  ["${" "#{" "}"] @keyword)
