# comment at top
foo: bar # trailing
	# recipe comment
	touch $@

bar:
	touch $@
