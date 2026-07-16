<%@ page isErrorPage="true" import="java.io.PrintWriter" %>
<html>
<body>
<h1>Something went wrong</h1>
<%-- show the exception implicit object --%>
<p>Message: <%= exception.getMessage() %></p>
<%
    exception.printStackTrace(new PrintWriter(out));
%>
</body>
</html>
