XML=CompSci497-Spring-2007-Syllabus.xml $(wildcard CompSci497_Notes_*.xml)
NOTES=$(shell for i in Notes_*; do find "$$i" -type f -not -path \*.svn\*; done)
HTML=$(XML:.xml=.html)
DEST=../http/CompSci497/


all: $(HTML)
	if [ ! -e "$(DEST)" ]; then mkdir "$(DEST)"; fi
	install -D print.css webdoc.xpl $(XML) $(HTML) $(DEST)
	for i in $(NOTES); do install -D "$$i" ../http/CompSci497/"$$i"; done

webdoc: webdoc.xpl
	xmlplcc $<

%.html: %.xml webdoc
	./webdoc <$< >$@

tidy:
	rm -f *~ \#*

clean: tidy
	rm -f $(HTML) webdoc
