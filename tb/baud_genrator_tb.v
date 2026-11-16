module baud_genrator_tb();
	// input signal
	reg  p_clk;
	reg  PRESETn;
	reg  spi_ss;
	reg  cpol;
	reg  cphase;
	reg  [1:0]spi_mod;
	reg  [2:0] spr, sppr;
	reg  SPISWAI;
	
	//output signal
	wire  s_clk;
	wire [11:0]BD;
	wire MISO_receive_pos;
	wire MISO_receive_neg;
	wire MOSI_send_pos;
	wire MOSI_send_neg;
	
	//parameter 
	parameter cycle = 10;
	parameter delay = 200;
	
	baud_genrator dut(
		.p_clk(p_clk),
		.PRESETn(PRESETn),
		.spi_ss(spi_ss),
		.cpol(cpol),
		.cphase(cphase),
		.spi_mod(spi_mod),
		.spr(spr), 
		.sppr(sppr),
		.SPISWAI(SPISWAI),
		
		.s_clk(s_clk),
		.BD(BD),
		.MISO_receive_pos(MISO_receive_pos),
		.MISO_receive_neg(MISO_receive_neg),
		.MOSI_send_pos(MOSI_send_pos),
		.MOSI_send_neg(MOSI_send_neg)
	);
	
	initial begin 
		p_clk = 1'b0;
		forever 
			#(cycle/2) p_clk = ~p_clk;
	end 
	
	task RESET();
		begin
			@(negedge p_clk)
			PRESETn = 1'b0;
			@(negedge p_clk)
			PRESETn = 1'b1;
		end 
	endtask 
	
	task start();
		begin
			p_clk = 1'b0;
			//@(negedge p_clk)
			PRESETn = 1'b0;
			spi_mod = 2'b00;
			spr = 3'b000;
			sppr = 3'b000;
			SPISWAI = 1'b0;
			spi_ss = 1'b1;
			cpol = 1'b0;
			cphase = 1'b0;
		end 
	endtask 
	
	task inputs(input [2:0]i, input[2:0]j, input x, input y);
		begin 
			//@(negedge p_clk)
			spi_mod =2'b01;
			spr = i;
			sppr = j;
			cpol = x;
			cphase = y;
			spi_ss = 1'b0;
			SPISWAI = 1'b0;
		end 
	endtask
	
	initial begin 
		start();
		RESET();
		inputs (3'd1, 3'd3, 1'b1, 1'b1);
		#(delay);
		//inputs (3'd1, 3'd2, 1'b0, 1'b1);
		//#(2 * delay) $finish;
	end 
	
endmodule 