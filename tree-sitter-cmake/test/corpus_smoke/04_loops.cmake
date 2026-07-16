foreach(item apple banana cherry)
  message(STATUS "fruit: ${item}")
endforeach()

foreach(i RANGE 1 10 2)
  math(EXPR sq "${i} * ${i}")
endforeach()

foreach(pair IN ZIP_LISTS LIST_A LIST_B)
  message(STATUS "${pair_0} -> ${pair_1}")
endforeach()

set(counter 0)
while(counter LESS 5)
  math(EXPR counter "${counter} + 1")
endwhile()
