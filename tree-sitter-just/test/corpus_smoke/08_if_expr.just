choice := if env("CI", "") == "true" { "ci" } else { "local" }

show:
    echo {{choice}}
