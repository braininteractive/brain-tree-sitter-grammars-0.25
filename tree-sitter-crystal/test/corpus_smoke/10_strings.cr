single = "interpolated #{1 + 2}"
heredoc = <<-TEXT
  multi line
  "quoted" content
  TEXT
percent = %w(one two three)
regex = /\d+[a-z]*/i
char = 'z'
puts single, heredoc, percent.size, regex, char
