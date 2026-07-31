files := $(wildcard src/*.c)
names := $(notdir $(files))
upper := $(patsubst %.c,%.h,$(files))

list:
	@echo $(words $(files))
