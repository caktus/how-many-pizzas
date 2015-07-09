SRCDIR =  $(CURDIR)/src
STATICDIR = $(SRCDIR)/static
STATICLIBSDIR = $(STATICDIR)/libs
OUTPUTDIR = $(CURDIR)/output

MODERNIZR_VERSION = 2.8.3
JQUERY_VERSION = 2.1.4
NORMALIZE_VERSION = 3.0.3

REPO = github.com/caktus/how-many-pizzas.git

default: serve

lint: lint-js

lint-js:
	# Check JS for any problems
	# Requires jshint
	find -name "*.js" -not -path "${STATIC_LIBS_DIR}*" -print0 | xargs -0 jshint

$(STATICLIBSDIR)/modernizr.js:
	@mkdir -p $(STATICLIBSDIR)
	@wget https://cdnjs.cloudflare.com/ajax/libs/modernizr/$(MODERNIZR_VERSION)/modernizr.js -O $@

$(STATICLIBSDIR)/jquery.js:
	@mkdir -p $(STATICLIBSDIR)
	@wget https://cdnjs.cloudflare.com/ajax/libs/jquery/$(JQUERY_VERSION)/jquery.js -O $@

$(STATICLIBSDIR)/normalize.css:
	@mkdir -p $(STATICLIBSDIR)
	@wget https://cdnjs.cloudflare.com/ajax/libs/normalize/$(NORMALIZE_VERSION)/normalize.css -O $@

$(STATICDIR)/css/%.css: $(STATICDIR)/less/%.less
	lessc $< $@

TARGETS = $(SRCDIR)/index.html \
	$(STATICLIBSDIR)/jquery.js \
	$(STATICLIBSDIR)/modernizr.js \
	$(STATICLIBSDIR)/normalize.css \
	$(STATICDIR)/css/main.css

$(OUTPUTDIR)/index.html: $(TARGETS) 
	@$(MAKE) clean
	@cp -R $(SRCDIR)/ $(OUTPUTDIR)

html: $(OUTPUTDIR)/index.html

clean:
	@rm -rf $(OUTPUTDIR)/

serve: html
	cd $(OUTPUTDIR)/ && python -m SimpleHTTPServer

publish: html
ifdef GITHUB_TOKEN
	@cd $(OUTPUTDIR) && git init && git config user.name "Travis CI" && \
	git config user.email "deploy@travis-ci.org" && git add . && \
	git commit -m "Deploy to Github Pages" && \
	git push --force --quiet "https://$(GITHUB_TOKEN)@$(REPO)" master:gh-pages > /dev/null 2>&1
endif

.PHONY: default html clean serve publish lint lint-js
