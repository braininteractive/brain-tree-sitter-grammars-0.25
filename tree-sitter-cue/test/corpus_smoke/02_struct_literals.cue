package hello

server: {
	host: "localhost"
	port: 8080
	tls: {
		enabled: true
		cert:    "/etc/ssl/cert.pem"
	}
}

inline: {a: 1, b: 2, c: {d: 3}}
