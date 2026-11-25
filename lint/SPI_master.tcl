#Liberty files are needed for logical and physical netlist designs
set search_path "./"
set link_library " "

set_app_var enable_lint true

configure_lint_setup -goal lint_rtl

analyze -verbose -format verilog "../rtl/baud_genrator.v ../rtl/slave_select.v ../rtl/shift_reg_block.v ../rtl/APB_slave.v ../rtl/SPI_master.v"

elaborate SPI_master 

check_lint

report_lint -verbose -file report_SPI_master.txt

