module SPI_master(
	input p_clk,
	input PRESETn,
	input [2:0]PADDR,
	input PWRITE,
	input PENABLE,
	input PSEL,
	input [7:0]PWDATA,
	input MISO,
	
	output SS,
	output [7:0]PRDATA,
	output s_clk,
	output MOSI,
	output SPI_intrrupt_req,
	output PREADY,
	output PSLVERR
);
	
	wire [11:0]BD;
	wire MISO_receive_pos;
	wire MISO_receive_neg;
	wire MOSI_send_pos;
	wire MOSI_send_neg;

	//wire spi_ss;
	wire cpol , cphase;
	wire [1:0]spi_mod;
	wire [2:0] spr ,sppr;
	wire SPISWAI;
	
	baud_genrator UNIT1(
		.p_clk(p_clk),
		.PRESETn(PRESETn),
		.spi_ss(SS), //write name from slave select
		.cpol(cpol),//apb slave 
		.cphase(cphase),//apb slave 
		.spi_mod(spi_mod),//apb slave 
		.spr(spr), //apb slave
		.sppr(sppr), //apb slave
		.SPISWAI(SPISWAI), //apb slave
		
		.s_clk(s_clk),//final output 
		.BD(BD),
		.MISO_receive_pos(MISO_receive_pos),
		.MISO_receive_neg(MISO_receive_neg),
		.MOSI_send_pos(MOSI_send_pos),
		.MOSI_send_neg(MOSI_send_neg)
	);
	
	wire send_data;
	wire mstr;
	wire receive_data;
	wire tip_out;
	
	slave_select UNIT2(
		.p_clk(p_clk),
		.send_data(send_data), //apb block
		.mstr(mstr),//apb block
		.PRESETn(PRESETn),//input
		.SPISWAI(SPISWAI),
		.spi_mod(spi_mod),
		.BD(BD),
		
		.receive_data(receive_data),
		.ss_out(SS),
		.tip_out(tip_out)
	);
	
	wire lsbfe;
	wire [7:0]data_MOSI;
	wire [7:0]MISO_data;
	
	shift_reg_block UNIT3(
		.PRESETn(PRESETn),
		.p_clk(p_clk),
		.cpol(cpol),
		.cphas(cphase),
		.MOSI_send_pos(MOSI_send_pos),
		.MOSI_send_neg(MOSI_send_neg),
		.MISO_rec_pos(MISO_receive_pos),
		.MISO_rec_neg(MISO_receive_neg),
		.send_data(send_data),
		.lsbfe(lsbfe),
		.data_MOSI(data_MOSI),
		.receive_data(receive_data),
		.spi_ss(SS),
		.MISO(MISO),
		.MOSI(MOSI),
		.MISO_data(MISO_data)
	);
	
	APB_slave UNIT4(
		.p_clk(p_clk),
		.PRESETn(PRESETn),
		.PADDR(PADDR),
		.PWRITE(PWRITE),
		.PSEL(PSEL),
		.PENABLE(PENABLE),
		.PWDATA(PWDATA),
		.spi_ss(SS),
		.MISO_data(MISO_data),
		.tip(tip_out),
		.receive_data(receive_data),
		
		.PRDATA(PRDATA),
		.MSTR(mstr),
		.cpol(cpol),
		.cphase(cphase),
		.LSBFE(lsbfe),
		.SPISWAI(SPISWAI),
		.SPR(spr),
		.SPPR(sppr),
		.SPI_intrrupt_req(SPI_intrrupt_req),
		.PREADY(PREADY),
		.PSLVERR(PSLVERR),
		.send_data(send_data),
		.MOSI_data(data_MOSI),
		.spi_mod(spi_mod)
	);
	
endmodule 