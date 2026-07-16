-- if/then/else expressions, nested and used inside records.
let env = "prod"

let isProd = env == "prod"

let replicas = if isProd then 5 else 1

let tier =
      if    Natural/isZero replicas
      then  "none"
      else  if replicas == 1 then "small" else "large"

in  { replicas, tier, alerting = if isProd then True else False }
