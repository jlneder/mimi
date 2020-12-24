install:
	install -D xdg-open $(DESTDIR)/usr/bin/xdg-open
	install -D xdg-email $(DESTDIR)/usr/bin/xdg-email

uninstall:
	rm -f $(DESTDIR)/usr/bin/xdg-open
	rm -f $(DESTDIR)/usr/bin/xdg-email
	@echo "I hope mimi was useful! Consider reinstalling xdg-utils to get hold of the original xdg-open and xdg-email."
