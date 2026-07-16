// Comments, attributes, dynamic fields, aliases, guards.
package hello

@if(prod)

config: {
	@protobuf(1, name)
	key:      "k"
	("dyn_" + key): true
	if config.key != "" {
		present: true
	}
}

X = self: {inner: 1}
ref: X.inner

top_val:    _
bottom_val: _|_
