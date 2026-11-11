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
	output [11:0]BD,
	output reg MISO_receive_pos,
	output reg MISO_receive_neg,
	output reg MOSI_send_pos,
	output reg MOSI_send_neg
);
	//internal signal 
	wire S_clock;
	//wire [11:0]BD;
	reg [11:0] count;
	
	//parameters for the modes of SPI
	
	parameter RUN = 2'b00,
	          WAIT = 2'b01,
			  STOP = 2'b10;
	
	//assign internal variable 
	assign S_clock = (cpol) ? 1'b1 : 1'b0;
	//assign BD = (baudrate_divisor/2) - 1;
	//calculating baudrate_divisor
	assign BD = ((sppr + 1) * (2 ** (spr + 1)));
	
	
	//s_clk genration logic 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(PRESETn == 0) begin 
			count <= 12'b0;
			s_clk <= S_clock;
		end 
		else begin 
			if ((spi_mod == RUN || (spi_mod == WAIT && SPISWAI == 0)) && spi_ss == 0) begin 
				if (count == (BD/2) - 1) begin 
					s_clk <= ~s_clk;
					count <= 12'b0;
				end 
				else begin 
					s_clk <= s_clk;
					count <= count + 1;
				end 
			end
			else begin 
				count <= 12'b0;
				s_clk <= S_clock;
			end 
		end 
	end 
	

	//flage genration send flag
	always @(posedge p_clk or negedge PRESETn) begin 
		if(PRESETn == 0) begin 
			MOSI_send_pos <= 1'b0;
			MOSI_send_neg <= 1'b0;
		end 
		else begin 
			if(cpol ^ cphase)begin
				if(s_clk) begin 
					if(count == (BD/2) - 2) begin 
						MOSI_send_pos <= 1'b1;
						MOSI_send_neg <= 1'b0;
					end
					else begin
						MOSI_send_pos <= 1'b0;
						MOSI_send_neg <= 1'b0;
					end 
				end
				else begin 
					MOSI_send_pos <= 1'b0;
					MOSI_send_neg <= 1'b0;
				end 
			end 
			else begin 
				if (s_clk == 0) begin 
					if(count == (BD/2) - 2) begin 
						MOSI_send_pos <= 1'b0;
						MOSI_send_neg <= 1'b1;
					end
					else begin
						MOSI_send_pos <= 1'b0;
						MOSI_send_neg <= 1'b0;
					end 
				end
				else begin 
					MOSI_send_pos <= 1'b0;
					MOSI_send_neg <= 1'b0;
				end  
			end 
		end 
	end

	//flage genration rec flag 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(PRESETn == 0) begin 
			MISO_receive_pos <= 1'b0;
			MISO_receive_neg <= 1'b0;
		end 
		else begin 
			if(cpol ^ cphase)begin
				if(s_clk) begin 
					if(count == (BD/2) - 1) begin 
						MISO_receive_pos <= 1'b0;
						MISO_receive_neg <= 1'b1;
					end
					else begin
						MISO_receive_pos <= 1'b0;
						MISO_receive_neg <= 1'b0;
					end 
				end
				else begin 
					MISO_receive_pos <= 1'b0;
					MISO_receive_neg <= 1'b0;
				end 
			end 
			else begin 
				if (s_clk == 0) begin 
					if(count == (BD/2) - 1) begin 
						MISO_receive_pos <= 1'b1;
						MISO_receive_neg <= 1'b0;
					end
					else begin
						MISO_receive_pos <= 1'b0;
						MISO_receive_neg <= 1'b0;
					end 
				end
				else begin 
					MISO_receive_pos <= 1'b0;
					MISO_receive_neg <= 1'b0;
				end  
			end 
		end 
	end

endmodule 