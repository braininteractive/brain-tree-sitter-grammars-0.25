def greet(name, *args, **kwargs):
    if not name:
        fail("name required")
    parts = [name] + list(args)
    return ", ".join(parts)

[greet(n) for n in ("a", "b") if n]
