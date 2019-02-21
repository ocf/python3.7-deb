.PHONY: build-image
build-image:
	docker build -t python3.7-build .

.PHONY: package
package: build-image
	mkdir -p "dist_stretch"
	docker run -e \
		--user $(shell id -u ${USER}):$(shell id -g ${USER}) \
		-v $(CURDIR)/dist_stretch:/mnt:rw \
		python3.7-build

.PHONY: clean
clean:
	rm -rf debian/*.debhelper debian/*.log dist dist_*

.PHONY: test
test: ;