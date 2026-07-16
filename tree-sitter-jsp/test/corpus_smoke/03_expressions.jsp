<h1>Welcome, <%= request.getParameter("user") %></h1>
<p>Today is <%= new java.util.Date() %></p>
<p>2 + 2 = <%= 2 + 2 %></p>
<p>Session id: <%= session.getId() %></p>
