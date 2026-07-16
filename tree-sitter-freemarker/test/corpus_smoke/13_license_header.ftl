<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information.
The ASF licenses this file under the Apache License, Version 2.0
(the "License"); you may obtain a copy at:
    http://www.apache.org/licenses/LICENSE-2.0
Multi-hyphen content: e-mail, x - y, foo--bar, 2024-01-01.
-->
<#if user??>
    <p>Hello ${user.name?html}</p>
</#if>
