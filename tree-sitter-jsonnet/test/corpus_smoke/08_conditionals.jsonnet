// if/then/else expressions, with and without else.
local env = "prod";
local replicas = if env == "prod" then 5 else 1;

{
  replicas: replicas,
  tier: if replicas > 3 then "large" else if replicas > 1 then "medium" else "small",
  [if env == "prod" then "alerting"]: true,
  debug: if env != "prod" then { verbose: true },
}
