<ul>
<#list users as user>
  <li>${user?index}: ${user.name}</li>
<#else>
  <li>No users found</li>
</#list>
</ul>
<#list 1..5 as n>
  <span>${n}</span><#sep>, </#sep>
</#list>
