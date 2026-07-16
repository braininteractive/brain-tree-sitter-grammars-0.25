# line comment with hash
// line comment with slashes

/* a block
   comment */

service "http" "web_proxy" {
  listen_addr = "127.0.0.1:8080"

  process "main" {
    command = ["/usr/local/bin/awesome-app", "server"]
  }

  tuple_attr  = [1, "two", true, null]
  object_attr = {
    nested = {
      deep = "value"
    }
  }
}
