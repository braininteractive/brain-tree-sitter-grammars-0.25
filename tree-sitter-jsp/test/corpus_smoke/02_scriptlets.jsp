<html>
<body>
<%
    String name = request.getParameter("name");
    if (name == null || name.isEmpty()) {
        name = "World";
    }
%>
<p>Hello!</p>
<% out.println("Done at " + new java.util.Date()); %>
</body>
</html>
