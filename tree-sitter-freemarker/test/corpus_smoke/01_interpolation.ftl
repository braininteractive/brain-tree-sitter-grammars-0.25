<h1>Hello ${name}!</h1>
<p>Your account: ${user.account.id}</p>
<p>Total: ${price * quantity + shipping}</p>
<p>Fallback: ${nickname!"anonymous"}</p>
<p>Nested access: ${order.items[0].label}</p>
