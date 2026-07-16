[#if premium]
  <p>Premium member</p>
[#else]
  <p>Standard member</p>
[/#if]
[#list plans as plan]
  <li>${plan.name}</li>
[/#list]
[#assign region = "EU"]
[@banner text="Sale"/]
