BUILD_DIR := build
PUBLISH_DIR := hosting:~/webapps/boothale_net/
PAGES := ${BUILD_DIR}/index.html \
         ${BUILD_DIR}/ref/index.html \
         ${BUILD_DIR}/css/index.css

.PHONY: clean publish

all: site

clean:
	@rm -rf ${BUILD_DIR}

${BUILD_DIR}: 
	@mkdir -p $@

${BUILD_DIR}/%/index.html: source/%.md ${BUILD_DIR}
	@printf "%20s => %s\n" $< $@
	@mkdir -p ${@D}
	@pandoc -so $@ $<

${BUILD_DIR}/%: source/% ${BUILD_DIR} 
	@printf "%20s => %s\n" $< $@
	@mkdir -p ${@D}
	@cp $< $@

site: ${PAGES}

publish: ${SITE}
	@scp -r ${BUILD_DIR}/* ${PUBLISH_DIR}
