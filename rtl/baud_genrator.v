module baud_genrator(
	// input signal
	input p_clk,
	input PRESETn,
	input spi_ss,
	input cpol,
	input cphase,
	input [1:0]spi_mod,
	input [2:0] spr, sppr,
	input SPISWAI,
	
	//output signal
	output reg s_clk,
	output [11:0]baudrate_divisor,
	output MISO_receive_sclk,
	output MISO_receive_sclk0,
	output MISO_send_sclk,
	output MISO_send_sclk0
);
	//internal signal 
	wire S_clock, BD,
	reg [11:0]count;
	count = 12'b1;
	
	//parameters for the modes of SPI
	
	parameter RUN = 2'b00,
	          WAIT = 2'b01,
			  STOP = 2'b10;
	
	//assign internal variable 
	assign S_clock = (cpol) ? 1'b1 : 1'b0;
	assign BD = (baudrate_divisor/2);
	//calculating baudrate_divisor
	assign baudrate_divisor = ((sppr + 1) * (2 ** (spr + 1)));
	
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			s_clk <= S_clock;
			count <= 12'b1;
		end 
		else begin 
			if ((spi_mod == RUN || spi_mod == WAIT) && spi_ss == 0 && SPISWAI == 0) begin 
				if (BD == count) begin 
					count <= 1'b1;
					s_clk = ~s_clk;
				end 
				
				else begin 
					count <= count + 1;
					s_clk <= s_clk;
				end 
			end 
			else begin 
				s_clk <= s_clk;
				count <= 12'b1;
			end 
		end 
	end 
endmodule 