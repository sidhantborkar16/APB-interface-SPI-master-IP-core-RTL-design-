module shif_reg_block_tb();
	//input signal (for shift register block)
	reg  PRESETn;
	reg  p_clk;
	reg  cpol;
	reg  cphas;
	wire  MOSI_send_pos;
	wire  MOSI_send_neg;
	wire  MISO_rec_pos;
	wire  MISO_rec_neg;
	reg  send_data;
	reg  lsbfe;
	reg  [7:0] data_MOSI;
	reg  receive_data;
	reg  spi_ss;
	reg  MISO;
	
	wire [7:0] MISO_data;
	wire MOSI;
	
	//signal for baud_genrator block which are not in shif_reg_block
	reg [1:0]spi_mod;
	reg [2:0]spr, sppr;
	reg SPISWAI;
	wire s_clk;
	wire [11:0]BD;
	
	//parameter 
	parameter RUN = 2'b00,
			  WAIT = 2'b01,
			  STOP = 2'b10;
	
	
	//using baud genrator block for getting flags 
	baud_genrator U1(
		.p_clk(p_clk),
		.PRESETn(PRESETn),
		.spi_ss(spi_ss),
		.cpol(cpol),
		.cphase(cphas),
		.spi_mod(spi_mod),// input 
		.spr(spr),// input 
		.sppr(sppr),// input 
		.SPISWAI(SPISWAI),//input 
		.s_clk(s_clk),//output 
		.BD(BD),//outut 
		.MISO_receive_pos(MISO_rec_pos),
		.MISO_receive_neg(MISO_rec_neg),
		.MOSI_send_pos(MOSI_send_pos),
		.MOSI_send_neg(MOSI_send_neg)
	);
	
	shift_reg_block dut(
		PRESETn,
		p_clk,
		cpol,
		cphas,
		MOSI_send_pos,
		MOSI_send_neg,
		MISO_rec_pos,
		MISO_rec_neg,
		send_data,
		lsbfe,
		data_MOSI,
		receive_data,
		spi_ss,
		MISO,
		MOSI,
		MISO_data
	);
	
	initial begin 
		p_clk = 1'b0;
		forever 
		#5 p_clk = ~p_clk;
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
			PRESETn = 1'b1;
			cpol = 1'b0;
			cphas = 1'b0;
			SPISWAI = 1'b1;
			send_data = 1'b0;
			receive_data = 1'b0;
			lsbfe = 1'b0;
			data_MOSI = 8'b0;
			MISO = 1'b0;
			spi_ss = 1'b1;
			sppr = 1'b0;
			spr =1'b0;
			spi_mod = RUN;
		end 
	endtask
	
	task baud_genrator_block(input [2:0]i, input[2:0]j);
		begin 
			spi_mod = WAIT;
			spr = i;
			sppr = j;
			cpol = 1;
			cphas = 0;
			spi_ss = 1'b0;
			SPISWAI = 1'b0;
		end 
	endtask 
	
	task MOSI_input( input[7:0]DATA , input LSB);
		begin 
			@(negedge p_clk)
			send_data =1'b1;
			spi_ss = 1'b0;
			data_MOSI = DATA;
			lsbfe = LSB;
			@(negedge p_clk) 
			send_data = 1'b0;
		end 
	endtask
	
	task MISO_rec_data(input [7:0]miso);
		integer i;
		begin 
			MISO = 1'bz;
			wait(!spi_ss) begin
				for(i=0;i<8;i=i+1) begin 
					@(posedge s_clk) MISO = miso[i];
				end 
			end 
		end 
	endtask
	
	initial begin 
		start();
		RESET();
		baud_genrator_block(3'd1 , 3'd0);
		receive_data = 1'b0;
		MISO_rec_data(8'b10101111);
		@(posedge s_clk) 
		receive_data = 1'b1;
		@(posedge s_clk)
		receive_data = 1'b0;
		#200;
		MOSI_input(8'b00001111 , 1'b1);
	end 
	
	initial begin 
		#5000 $finish;
	end 
	
endmodule 