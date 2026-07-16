package hello

#Spec: {
	name:      string
	nickname?: string
	age?:      int & >=0
	tags?: [...string]
	meta?: {
		created?: string
		owner!:   string
	}
}

val: #Spec & {
	name: "thing"
	meta: owner: "root"
}
