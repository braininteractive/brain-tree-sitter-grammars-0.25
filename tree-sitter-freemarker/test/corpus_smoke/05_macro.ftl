<#macro badge label>
  <span class="badge">${label}</span>
</#macro>
<#macro panel title>
  <div class="panel">
    <h2>${title}</h2>
    <#nested>
  </div>
</#macro>
<@badge label="New"/>
<@panel title="Details">
  <p>Panel body text.</p>
</@panel>
