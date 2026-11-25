remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog {../rtl/baud_genrator.v ../rtl/slave_select.v ../rtl/shift_reg_block.v ../rtl/APB_slave.v ../rtl/SPI_master.v} 

elaborate SPI_master

link 

check_design

current_design  SPI_master 

compile_ultra

write_file -f verilog -hier -output SPI_master__netlist.v


 

