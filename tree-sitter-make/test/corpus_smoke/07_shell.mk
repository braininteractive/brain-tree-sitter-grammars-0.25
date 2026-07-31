VERSION = $(shell git describe --tags)
DATE := $(shell date +%Y%m%d)

release:
	@echo "v$(VERSION) on $(DATE)"
