module SPI_master_tb();
	reg p_clk;
	reg PRESETn;
	reg [2:0]PADDR;
	reg PWRITE;
	reg PENABLE;
	reg PSEL;
	reg [7:0]PWDATA;
	reg MISO;
	
	wire  SS;
	wire  [7:0]PRDATA;
	wire  s_clk;
	wire  MOSI;
	wire  SPI_intrrupt_req;
	wire  PREADY;
	wire  PSLVERR;
	
	SPI_master dut(
		.p_clk(p_clk),
		.PRESETn(PRESETn),
		.PADDR(PADDR),
		.PWRITE(PWRITE),
		.PENABLE(PENABLE),
		.PSEL(PSEL),
		.PWDATA(PWDATA),
		.MISO(MISO),
		
		.SS(SS),
		.PRDATA(PRDATA),
		.s_clk(s_clk),
		.MOSI(MOSI),
		.SPI_intrrupt_req(SPI_intrrupt_req),
		.PREADY(PREADY),
		.PSLVERR(PSLVERR)
	);
	
	//parameter declaration 
	parameter CR1 = 3'b000,
			  CR2 = 3'b001,
			  BR  = 3'b010,
			  SR  = 3'b011,
			  DR  = 3'b101;
			  
	initial begin 
		p_clk = 1'b0;
		forever #5 p_clk = ~ p_clk;
	end 
	
	task START();
		begin 
			PRESETn = 1'b1;
			PADDR = 3'b000;
			PWRITE = 1'b0;
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask 
	
	task RESET();
		begin 
			@(negedge p_clk)
			PRESETn = 1'b0;
			@(negedge p_clk)
			PRESETn = 1'b1;
		end 
	endtask 
	
	task WRITE(input[7:0]DATA, input [2:0]addr);
		begin 
			@(negedge p_clk) //setup 
			PADDR = addr;
			PWDATA = DATA;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b1;
			
			@(negedge p_clk) //enable
			PADDR = addr;
			PWDATA = DATA;
			PWRITE = 1'b1;
			PSEL = 1'b1;
			PENABLE = 1'b1; 
			
			@(negedge p_clk) //ideal
			wait(PREADY)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask 
	
	task miso();
		begin 
			MISO = 1'b0;
			wait(~SS) begin 
				@(negedge s_clk);
	        	MISO=1'b1;
				@(negedge s_clk);
				MISO=1'b0;
				@(negedge s_clk);
				MISO=1'b1;
				@(negedge s_clk);
				MISO=1'b0;
				@(negedge s_clk);
				MISO=1'b1;
				@(negedge s_clk);
				MISO=1'b0;
				@(negedge s_clk);
				MISO=1'b1;
				@(negedge s_clk);
				MISO=1'b0;
			end 
		end 
	endtask 
	
	task READ(input [2:0]add);
		begin 
			@(negedge p_clk) //setup 
			PADDR = add;
			PSEL = 1'b1;
			PENABLE = 1'b0;
			PWRITE = 1'b0;
			
			@(negedge p_clk) //enable
			PADDR = add;
			PWRITE = 1'b0;
			PSEL = 1'b1;
			PENABLE = 1'b1; 
			
			@(negedge p_clk) //ideal
			wait(PREADY)
			PENABLE = 1'b0;
			PSEL = 1'b0;
		end 
	endtask 
	
	initial begin 
		
		START();
		RESET();
		
		WRITE(8'b00011101 , CR1);
		WRITE(8'b11001000 , CR2);
		WRITE(8'b00000001 , BR);
		WRITE(8'b11001101 , DR);

		miso();
		
		READ(CR1);
		READ(CR2);
		READ(BR);
		READ(SR);
		READ(DR);	
		#500 $finish;
	end 
endmodule 