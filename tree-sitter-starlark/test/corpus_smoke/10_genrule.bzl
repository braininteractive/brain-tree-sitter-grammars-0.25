genrule(
    name = "gen",
    outs = ["gen.txt"],
    cmd = "echo hi > $@",
    tags = ["no-cache", "local"],
)
