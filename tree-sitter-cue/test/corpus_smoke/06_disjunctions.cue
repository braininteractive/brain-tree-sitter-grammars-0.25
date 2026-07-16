package hello

severity: "low" | "medium" | "high"
level:    *"info" | "debug" | "warn" | "error"
value:    int | string | null
sized:    (int & >0) | (string & !="")

#Proto: "tcp" | "udp"

conn: {
	proto: #Proto | *"tcp"
	port:  80 | 443 | 8080
}
