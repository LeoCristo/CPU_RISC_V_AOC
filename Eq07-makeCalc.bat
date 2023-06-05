ghdl --clean
ghdl --remove

ghdl -a Eq07-rom.vhd

ghdl -a Eq07-reg16bits.vhd

ghdl -a Eq07-program_counter.vhd

ghdl -a Eq07-maq_estados.vhd

ghdl -a Eq07-unity_control.vhd

ghdl -a Eq07-ROM_PC_UC.vhd

ghdl -a Eq07-ULA.vhd

ghdl -a Eq07-ULARegs.vhd

ghdl -a Eq07-RegFile.vhd

ghdl -a Eq07-ROM_PC_UC_tb.vhd

ghdl -r ROM_PC_UC_tb --stop-time=10000ns --wave=Eq07-Calc.ghw