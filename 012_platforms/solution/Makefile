test:
	mkdir -p build
	vir run --fps-no-cap --cycles 2000 </dev/null > build/greeting.txt
	grep "Hi!" build/greeting.txt

.PHONY: test
