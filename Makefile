install:
	install -D xdg-open $(DESTDIR)/usr/bin/xdg-open

uninstall:
	rm -f $(DESTDIR)/usr/bin/xdg-open
	@echo "I hope mimi was useful! Consider reinstalling xdg-utils to get hold of the original xdg-open."
