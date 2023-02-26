PREFIX = /usr/local

biblija: biblija.sh biblija.awk biblija.tsv
	cat biblija.sh > $@
	echo 'exit 0' >> $@
	echo '#EOF' >> $@
	tar czf - biblija.awk biblija.tsv >> $@
	chmod +x $@

test: biblija.sh
	shellcheck -s sh biblija.sh

clean:
	rm -f biblija

install: biblija
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f biblija $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/biblija

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/biblija

.PHONY: test clean install uninstall
