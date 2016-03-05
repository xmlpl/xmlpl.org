PAGE=xmlpl.org
TOP=$(HOME)/projects/website/
SUBDIRS=BoiseCodeCamp2007 BSU

include $(TOP)/Makefile.common
BUILT_FILES=hello.xml hello_web.xml query.xml links.xml lang-spec.xml\
  install.xml type_cast_table.xml
PROGRAMS=example2XML links2XML sections2XML typeCastTable tokenExtract

all: $(PROGRAMS) $(BUILT_FILES) static-data

static-data:
	cd static; for i in $$(find . -type f -a -not -regex .\*/.svn/.\*); do install -Dp "$$i" "../http/$$i"; done

%.xml: %.example example2XML
	./example2XML <$< >$@

links.xml: links-input.xml links2XML
	./links2XML <$< >$@

%.xml: %-input.xml sections2XML
	./sections2XML <$< >$@

type_cast_table.xml: xmlpl_type_casts.xml typeCastTable
	./typeCastTable <$< >$@

images: images.xml $(shell $(TOP)/bin/xinclude -d images.xml)
	xinclude $< | website

%: %.xpl
	xmlplcc $<

clean: clean-local

clean-local:
	rm -f $(PROGRAMS) $(BUILT_FILES)
