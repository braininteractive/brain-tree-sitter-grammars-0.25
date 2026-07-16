package hello

who:      "world"
greeting: "hello \(who)"
count:    3
message:  "there are \(count) items and \(count+1) slots"
path:     "/srv/\(who)/data"

multiline: """
	Dear \(who),
	goodbye.
	"""

bytes_interp: 'raw \(who) bytes'
