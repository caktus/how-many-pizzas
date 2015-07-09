SRCDIR =  $(CURDIR)/src
STATICDIR = $(SRCDIR)/static
STATICLIBSDIR = $(STATICDIR)/libs
OUTPUTDIR = $(CURDIR)/output

MODERNIZR_VERSION = 2.8.3
JQUERY_VERSION = 2.1.4


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

$(OUTPUTDIR)/index.html: $(SRCDIR)/index.html $(STATICLIBSDIR)/jquery.js $(STATICLIBSDIR)/modernizr.js
	@rm -rf $(OUTPUTDIR)/
	@cp -R $(SRCDIR)/ $(OUTPUTDIR)

html: $(OUTPUTDIR)/index.html

serve: html
	cd $(OUTPUTDIR)/ && python -m SimpleHTTPServer

.PHONY: html lint-js
