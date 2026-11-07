test:
	vir build
	iverilog -g2012 -o build/run tb.sv build/*.sv
	./build/run

.PHONY: test
