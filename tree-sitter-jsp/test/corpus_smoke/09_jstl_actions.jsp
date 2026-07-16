<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty sessionScope.user}">
  <p>Welcome back, ${sessionScope.user.name}!</p>
</c:if>
<c:forEach var="item" items="${cart.items}">
  <li>${item.title} - ${item.price}</li>
</c:forEach>
<jsp:include page="footer.jsp">
  <jsp:param name="year" value="2026" />
</jsp:include>
