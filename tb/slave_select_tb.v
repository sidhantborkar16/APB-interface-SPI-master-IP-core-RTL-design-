module slave_select_tb();
	reg p_clk, send_data, mstr, PRESETn, SPISWAI;
	reg [1:0] spi_mod;
	reg [11:0]BD;
	
	wire receive_data; 
	wire ss_out;
	wire tip_out;
	
	//parameter for mode of spi_mod
	parameter RUN  = 2'b00,
			  WAIT = 2'b01,
			  STOP = 2'b10;
			  
	parameter cycle = 10,
			  delay = 200;
			  
	slave_select dut(
		.p_clk(p_clk),
		.send_data(send_data),
		.mstr(mstr),
		.PRESETn(PRESETn),
		.SPISWAI(SPISWAI),
		.spi_mod(spi_mod),
		.BD(BD),
		.receive_data(receive_data),
		.ss_out(ss_out),
		.tip_out(tip_out)
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
			mstr = 1'b0;
			SPISWAI = 1'b0;
			spi_mod = RUN;
			send_data = 1'b0;
			BD = 12'b0;
		end 
	endtask
	
	task inputs( input [11:0]bd);
		begin
			@(negedge p_clk)
			mstr = 1'b1;
			SPISWAI = 1'b0;
			spi_mod = RUN;
			send_data = 1'b1;
			@(negedge p_clk)
			send_data = 1'b0;
			BD = bd;
		end 
	endtask 
	
	
	initial begin 
		start();
		RESET();
		inputs(12'd2);
		#(delay);
		inputs(12'd4);
		#(2*delay) $finish;
	end 
	
endmodule 