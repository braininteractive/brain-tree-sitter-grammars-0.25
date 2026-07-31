$n = 5
if ($n -lt 0) {
    "negative"
} elseif ($n -eq 0) {
    "zero"
} else {
    "positive"
}

foreach ($i in 1..3) {
    if ($i -eq 2) { continue }
    $i
}

while ($n -gt 0) { $n-- }

do { $n++ } until ($n -ge 3)

switch ($n) {
    3 { "three"; break }
    { $_ -gt 10 } { "big" }
    default { "other" }
}
