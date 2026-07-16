<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- A small but complete page mixing every construct. --%>
<%! private String appName = "Demo"; %>
<html>
<head><title><%= appName %></title></head>
<body>
  <h1>${pageTitle}</h1>
  <%
      int visits = 1;
      String who = request.getRemoteUser();
  %>
  <p>Visits: <%= visits %>, user: <%= who == null ? "anonymous" : who %></p>
  <p>Deferred greeting: #{greeter.message}</p>
  <c:out value="${param.q}" />
</body>
</html>
