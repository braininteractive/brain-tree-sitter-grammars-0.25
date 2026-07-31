ifeq ($(OS),Windows_NT)
  EXT = .exe
else
  EXT =
endif

out: main$(EXT)
	echo done
