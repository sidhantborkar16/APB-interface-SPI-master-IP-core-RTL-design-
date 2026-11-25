module APB_slave_tb();
	reg p_clk;
	reg PRESETn;
	reg [2:0]PADDR;
	reg PWRITE;
	reg PSEL;
	reg PENABLE;
	reg [7:0] PWDATA;
	reg spi_ss;
	reg [7:0] MISO_data;
	reg tip;
	reg receive_data;
	
	//output of the APB slave module 
	wire [7:0]PRDATA;   
	wire MSTR;   
	wire cpol;   
	wire cphase;   
	wire LSBFE;   
	wire SPISWAI;   
	wire [2:0] SPR, SPPR;   
	wire SPI_intrrupt_req;   
	wire PREADY;   
	wire PSLVERR;   
	wire send_data;   
	wire [7:0]MOSI_data;
	wire [1:0]spi_mod;

	APB_slave dut(
		.p_clk(p_clk),
		.PRESETn(PRESETn),
		.PADDR(PADDR),
		.PWRITE(PWRITE),
		.PSEL(PSEL),
		.PENABLE(PENABLE),
		.PWDATA(PWDATA),
		.spi_ss(spi_ss),
		.MISO_data(MISO_data),
		.tip(tip),
		.receive_data(receive_data),
		
		.PRDATA(PRDATA),
		.MSTR(MSTR),
		.cpol(cpol),
		.cphase(cphase),
		.LSBFE(LSBFE),
		.SPISWAI(SPISWAI),
		.SPR(SPR),
		.SPPR(SPPR),
		.SPI_intrrupt_req(SPI_intrrupt_req),
		.PREADY(PREADY),
		.PSLVERR(PSLVERR),
		.send_data(send_data),
		.MOSI_data(MOSI_data),
		.spi_mod(spi_mod)
	);
	
	initial begin 
		p_clk = 1'b0;
		forever 
		#5 p_clk = ~ p_clk;
	end 
	
	task RESET();
		begin 
			@(negedge p_clk)
			PRESETn = 1'b0;
			@(negedge p_clk)
			PRESETn =1'b1;
		end 
	endtask 
	
	task start();
		begin 
			PRESETn = 1'b1;
			PADDR = 3'b000;
			PSEL = 1'b0;
			PENABLE = 1'b0;
			spi_ss = 1'b1;
			tip = 1'b0;
			receive_data = 1'b0;
		end 
	endtask 
	
	task write_CR1();
		begin 
			@(negedge p_clk) // setup state 
			PADDR = 3'b000;
			PSEL = 1'b1;
			PWDATA = 8'b01011101;
			PWRITE = 1'b1;
			PENABLE = 1'b0;
			@(negedge p_clk) //enable state 
			PENABLE = 1'b1;
			@(negedge p_clk) //ideal state 
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask

	task write_CR2();
		begin 
			@(negedge p_clk) // setup state 
			PADDR = 3'b001;
			PSEL = 1'b1;
			PWDATA = 8'b01010101;
			PWRITE = 1'b1;
			PENABLE = 1'b0;
			@(negedge p_clk) //enable state 
			PENABLE = 1'b1;
			@(negedge p_clk) //ideal state 
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	task write_BR();
		begin 
			@(negedge p_clk) // setup state 
			PADDR = 3'b010;
			PSEL = 1'b1;
			PWDATA = 8'b01000100;
			PWRITE = 1'b1;
			PENABLE = 1'b0;
			@(negedge p_clk) //enable state 
			PENABLE = 1'b1;
			@(negedge p_clk) //ideal state 
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	task write_DR();
		begin 
			@(negedge p_clk) // setup state 
			PADDR = 3'b101;
			PSEL = 1'b1;
			PWDATA = 8'b10110110;
			PWRITE = 1'b1;
			PENABLE = 1'b0;
			@(negedge p_clk) //enable state 
			PENABLE = 1'b1;
			@(posedge p_clk);
			@(negedge p_clk) //ideal state 
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	/*task write_SR();
		begin 
			@(negedge p_clk) // setup state 
			PADDR = 3'b011;
			PSEL = 1'b1;
			PWRITE = 1'b1;
			PENABLE = 1'b0;
			@(negedge p_clk) //enable state 
			PENABLE = 1'b1;
			@(negedge p_clk) //ideal state 
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask*/
	task read_SR();
		begin 
			@(negedge p_clk) //setup state 
			PADDR = 3'b011;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b0;
			@(negedge p_clk)
			PENABLE =1'b1;
			@(negedge p_clk)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask 
	
	task read_CR1();
		begin 
			@(negedge p_clk) //setup state 
			PADDR = 3'b000;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b0;
			@(negedge p_clk)
			PENABLE =1'b1;
			@(negedge p_clk)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	task read_CR2();
		begin 
			@(negedge p_clk) //setup state 
			PADDR = 3'b001;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b0;
			@(negedge p_clk)
			PENABLE =1'b1;
			@(negedge p_clk)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	task read_BR();
		begin 
			@(negedge p_clk) //setup state 
			PADDR = 3'b010;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b0;
			@(negedge p_clk)
			PENABLE =1'b1;
			@(negedge p_clk)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	task read_DR();
		begin 
			@(negedge p_clk) //setup state 
			PADDR = 3'b101;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b0;
			@(negedge p_clk)
			PENABLE =1'b1;
			@(negedge p_clk)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask
	
	initial begin 
		start();
		RESET();
		spi_ss = 1'b0;
		receive_data = 1'b1;
		tip = 1'b1;
		MISO_data = 8'b11110000;
		@(negedge p_clk);
		receive_data = 1'b0;
		write_CR1();
		write_CR2();
		write_BR();
		write_DR();
		read_CR1();
		read_CR2();
		read_BR();
		read_SR();
		read_DR();
		//read_SR();
		#500 $finish;
	end 
	
endmodule 