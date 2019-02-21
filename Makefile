.PHONY: build-image
build-image:
	docker build -t python3.7-build .

.PHONY: package
package: build-image
	mkdir -p dist_stretch
	docker run -e "DIST_UID=$(shell id -u)" -e "DIST_GID=$(shell id -g)" -v $(CURDIR)/dist_stretch:/mnt:rw python3.7-build

.PHONY: clean
clean:
	rm -rf debian/*.debhelper debian/*.log dist dist_*

.PHONY: test
test: ;
