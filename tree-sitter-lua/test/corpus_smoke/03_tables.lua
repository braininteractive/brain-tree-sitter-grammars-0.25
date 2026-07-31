local config = {
  name = "app",
  version = 2,
  tags = { "a", "b", "c" },
  nested = { deep = { value = true } },
  ["quoted key"] = 1,
  [42] = "answer",
}

config.extra = "added"
print(config.nested.deep.value, #config.tags, config["quoted key"])
