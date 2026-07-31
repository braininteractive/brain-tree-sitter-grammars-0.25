def _to_upper(s):
    result = ""
    for ch in s.elems():
        result += ch.upper()
    return result

value = _to_upper("bazel") if True else "skip"
