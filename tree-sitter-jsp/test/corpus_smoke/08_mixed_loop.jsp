<%@ page import="java.util.List" %>
<table>
<%
    List<String> rows = (List<String>) request.getAttribute("rows");
    for (int i = 0; i < rows.size(); i++) {
%>
  <tr><td><%= i %></td><td><%= rows.get(i) %></td></tr>
<%
    }
%>
</table>
