def _impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".out")
    ctx.actions.write(out, "content")
    return [DefaultInfo(files = depset([out]))]

my_rule = rule(implementation = _impl)
