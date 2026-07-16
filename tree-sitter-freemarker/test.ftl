<#-- This is a comment -->
<h1>Hello ${name}!</h1>

<#if user??>
  <p>Welcome, ${user.name}!</p>
<#else>
  <p>Please log in.</p>
</#if>

<#list items as item>
  <li>${item}</li>
</#list>

<@myMacro param="value" />
