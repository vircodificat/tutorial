# `$(wildcard */)` is guaranteed to expand in alphabetical order: GNU make
# implements `wildcard` via glob(3), and glob(3) sorts its results
# lexicographically (unlike plain readdir(3), which returns filesystem order).
# Sorting is collation-wise per the current locale (LC_COLLATE).
SUBDIRS := $(wildcard */)

.PHONY: test
test:
	@for dir in $(SUBDIRS); do \
		echo "== $$dir =="; \
		$(MAKE) -C $$dir test || exit 1; \
	done
