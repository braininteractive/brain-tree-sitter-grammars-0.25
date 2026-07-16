<#if user??>
  <p>Welcome back, ${user.name}!</p>
<#elseif guestAllowed>
  <p>Welcome, guest.</p>
<#else>
  <p>Please log in.</p>
</#if>
<#if score gte 90>
  <span>Excellent</span>
</#if>
