.PHONY: clean install

clean:
	rm -rf build/

install: app
	install -m755 app /usr/local/bin/
