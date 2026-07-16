package hello

age:  int & >=0 & <150
name: string & =~"^[A-Z]"
port: >1024 & <65536

a: {x: 1}
b: {y: 2}
c: a & b

bounds: {
	min: >=1.0
	max: <=100.0
	ne:  !=0
}
