<p>Hello, {{ $name }}!</p>
<p>The current time is {{ now() }}.</p>
<p>Total: {{ $price * $quantity }}</p>
<div>{!! $trustedHtml !!}</div>
<span>{!! nl2br(e($comment)) !!}</span>
<p>Escaped literal: @{{ notBlade }}</p>
