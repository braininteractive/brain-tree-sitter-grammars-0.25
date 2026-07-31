$single = 'no $interp here'
$double = "interp: $(1 + 2) and $env:PATH"
$here = @"
multi line
with "quotes" and $double
"@
$hereSingle = @'
literal $stuff
'@
$formatted = "{0:N2}" -f 3.14159
$single; $here; $hereSingle; $formatted
