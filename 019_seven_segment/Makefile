test:
	mkdir -p build
	vir run --fps-no-cap --cycles 100000 </dev/null > build/gallery.txt
	diff build/gallery.txt expected.txt

.PHONY: test
