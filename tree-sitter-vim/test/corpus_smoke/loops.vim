" For and while loops.
let s:total = 0
for s:i in range(1, 10)
  let s:total += s:i
endfor

for [s:key, s:val] in items({'a': 1, 'b': 2})
  echo s:key . ' = ' . s:val
endfor

let s:n = 0
while s:n < 5
  let s:n += 1
  if s:n == 3
    continue
  endif
  echo s:n
endwhile
