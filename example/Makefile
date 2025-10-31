# ====================================================
# Makefile for Verilator simulation of counter.sv
# ====================================================

TOP     = tb_counter
FILELIST = filelist.f
OUTDIR  = build
EXE     = $(OUTDIR)/$(TOP)
WAVES   = $(TOP).vcd

# Verilator flags
#VERILATOR_FLAGS = -Wall -Wno-fatal --cc --exe --build --trace
VERILATOR_FLAGS = -Wall -Wno-fatal --binary --trace \
                  -O3 -CFLAGS "-std=c++17" \
				  --timing \
                  --top-module $(TOP) -f $(FILELIST)

# Default target
all: run

# Build simulation
$(EXE): $(FILELIST)
	@mkdir -p $(OUTDIR)
	verilator $(VERILATOR_FLAGS) -o $(TOP)
	mv obj_dir/$(TOP) $(EXE)

# Run simulation
run: $(EXE)
	@echo "=== Running $(TOP) Simulation ==="
	$(EXE)
	@echo "=== Simulation Complete ==="

# View waveform
wave: 
	@echo "Opening GTKWave..."
	gtkwave $(WAVES) &

# Clean generated files
clean:
	rm -rf $(OUTDIR) obj_dir logs *.vcd

.PHONY: all run wave clean
