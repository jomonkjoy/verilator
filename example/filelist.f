# Filelist for Verilator Simulation
# Comments start with #
# One file per line

# Include directories (for `include statements)
#+incdir+./rtl/include

# Define macros
+define+SIMULATION

# Package files (should come first if other files depend on them)

# Submodule files

# RTL source files
./rtl/counter.sv

# Testbench files (if needed)
./tb/tb_counter.sv