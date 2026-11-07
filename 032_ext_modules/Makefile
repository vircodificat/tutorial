test:
	mkdir -p build
	vir run --fps-no-cap --cycles 7000 </dev/null > build/tour.txt
	diff build/tour.txt expected.txt

.PHONY: test
