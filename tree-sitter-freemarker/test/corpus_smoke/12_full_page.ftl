<#-- full page template exercising several constructs -->
<#include "head.ftl">
<#assign pageTitle = "Order Summary">
<html>
<head><title>${pageTitle}</title></head>
<body>
<#if orders?size gt 0>
  <table>
  <#list orders as order>
    <tr>
      <td>${order?counter}</td>
      <td>${order.customer?cap_first}</td>
      <td>${order.total?string(",##0.00")}</td>
    </tr>
  </#list>
  </table>
<#else>
  <p>No orders yet.</p>
</#if>
<@footer year=2026 company="Acme"/>
</body>
</html>
