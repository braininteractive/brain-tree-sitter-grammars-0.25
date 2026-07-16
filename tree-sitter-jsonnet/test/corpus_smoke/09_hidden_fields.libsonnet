// Hidden fields (::), forced-visible fields (:::), and object locals.
{
  local internal = "not exported",
  hidden_helper:: function(x) x + 1,
  metadata:: {
    generator: "corpus",
  },
  forced::: "always visible",
  visible: internal + " but used",
  computed: self.hidden_helper(41),
}
