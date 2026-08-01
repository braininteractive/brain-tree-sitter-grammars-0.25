let user = {name: "jane", roles: ["admin", "dev"], active: true}
let items = [[name, qty]; [apple, 3] [pear, 7]]
print $user.name ($items | get qty | math sum)
