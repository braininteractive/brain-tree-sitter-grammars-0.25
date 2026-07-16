package hello

#Person: {
	name: string
	age:  int & >=0
}

#Config: {
	replicas: int | *1
	labels: [string]: string
}

alice: #Person & {
	name: "Alice"
	age:  30
}

_hidden: 42
#Empty: {}
