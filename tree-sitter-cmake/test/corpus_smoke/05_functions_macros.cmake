function(print_all)
  foreach(arg IN LISTS ARGN)
    message(STATUS "arg: ${arg}")
  endforeach()
endfunction()

function(add_prefixed out prefix)
  set(${out} "${prefix}_suffix" PARENT_SCOPE)
endfunction()

macro(set_default var value)
  if(NOT DEFINED ${var})
    set(${var} ${value})
  endif()
endmacro()

print_all(one two three)
set_default(MY_OPTION ON)
