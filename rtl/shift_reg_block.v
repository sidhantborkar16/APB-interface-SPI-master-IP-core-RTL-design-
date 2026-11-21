module shift_reg_block(
	//input signal
	input PRESETn,
	input p_clk,
	input cpol,
	input cphas,
	input MOSI_send_pos,
	input MOSI_send_neg,
	input MISO_rec_pos,
	input MISO_rec_neg,
	input send_data,
	input lsbfe,
	input [7:0] data_MOSI,
	input receive_data,
	input spi_ss,
	input MISO,
	
	//output signal
	output reg MOSI,
	output [7:0] MISO_data
);
	//internal reg 
	reg [7:0]shift_reg; // this is for MOSI
	reg [7:0]temp_reg; // this is for MISO 
	
	//internal counter 
	reg [2:0]count_shift0, count_shift1, count_temp0, count_temp1 ; //count 0 and 1 for MOSI(0 for up and 1 for down) 
	
	//shift_reg || data load logic 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			shift_reg <= 8'b0;
		end 
		else begin 
			if(send_data) begin 
				shift_reg <= data_MOSI;
			end 
			else begin 
				shift_reg <= shift_reg;
			end
		end 
	end
	
	//MOSI 1 bit out (serial data out) logic and counter logic for shift registor counter 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			MOSI <= 1'b0;
			count_shift0 <= 3'b0;
			count_shift1 <= 3'd7;
		end
		else begin 
			if(!ss) begin 
				if(cpol ^ cphas) begin 
					if(lsbfe) begin 
						if(count_shift0 <= 3'd7) begin 
							if(MOSI_send_neg) begin 
								count_shift0 <= count + 1;
								MOSI <=shift_reg[count_shift0];
							end
							else begin 
								count_shift0 <= count_shift0;
								//MOSI <= 1'b0;
							end
						end 
						else begin 
							count_shift0 <= 3'b0;
							//MOSI <= 1'b0;
						end 
					end
					else begin 
						if(count_shift1 >= 3'b0) begin 
							if(MOSI_send_neg) begin
								count_shift1 <= count - 1;
								MOSI <= shift_reg[count_shift1];
							end 
							else begin 
								count_shift1 <= count_shift1; 
								//MOSI <= 1'b0;
							end 
						end
						else begin 
							count_shift1 <= 3'd7;
							//MOSI <= 1'b0;
						end 
					end 
				end 
				else begin 
					if(lsbfe) begin 
						if(count_shift0 <= 3'd7) begin 
							if(MOSI_send_pos) begin
								count_shift0 <= count + 1;
								MOSI <= shift_reg[count_shift0];
							end 
							else begin 
								count_shift0 <= count_shift0;
								//MOSI <= 1'b0;
							end 
						end 
						else begin 
							count_shift0 <= 3'b0
							//MOSI <= 1'b0;
						end 
					end 
					else begin 
						if(count_shift1 >= 3'b0)begin
							if(MOSI_send_pos) begin 
								count_shift1 <= count - 1;
								MOSI <= shift_reg[count_shift1];
							end
							else begin 
								count_shift1 <= count_shift1;
								//MOSI <= 1'b0;
							end 
						end 
						else begin 
							count_shift1 <= 3'd7;
							//MOSI <= 1'b0;
						end
					end 
				end 
			end
			else begin 
				MOSI <= 1'b0;
				count_shift0 <= 3'b0;
				count_shift1 <= 3'd7;
			end 
		end 
	end

	//data loading into the MISO_data
	assign MISO_data = (receive_data) ? temp_reg : 1'bz;
	
	//MISO 1 bit loading into temp_reg
	always @(posedge p_clk or negedge PRESETn) begin 
		if (!PRESETn) begin 
			temp_reg <= 8'b0;
			count_temp0 <= 3'b0;
			count_temp1 <= 3'd7;
		end 
		else begin
			if(!ss) begin 
				if(cpol ^ cphas) begin 
					if(lsbfe) begin
						if(count_temp0 <= 3'd7) begin
							if(MISO_rec_neg) begin 
								temp_reg[count_temp0] <= MISO;
								count_temp0 <= count_temp0 + 1;
							end 
							else begin 
								count_temp0 <= count_temp0;
							end 
						end 
						else begin 
							count_temp0 <= 3'b0;
						end 
					end 
					else begin 
						if(count_temp1 >= 3'b0) begin 
							if(MISO_rec_neg) begin 
								temp_reg[count_temp1] <= MISO;
								count_temp1 <= count_temp1 - 1;
							end 
							else begin 
								count_temp1 <= count_temp1;
							end 
						end
						else begin 
							count_temp1 <= 3'd7;
						end 
					end 
				end 
				else begin 
					if(lsbfe) begin
						if(count_temp0 <= 3'd7) begin
							if(MISO_rec_pos) begin 
								temp_reg[count_temp0] <= MISO;
								count_temp0 <= count_temp0 + 1;
							end 
							else begin 
								count_temp0 <= count_temp0;
							end 
						end 
						else begin 
							count_temp0 <= 3'b0;
						end 
					end 
					else begin 
						if(count_temp1 >= 3'b0) begin 
							if(MISO_rec_pos) begin 
								temp_reg[count_temp1] <= MISO;
								count_temp1 <= count_temp1 - 1;
							end 
							else begin 
								count_temp1 <= count_temp1;
							end 
						end
						else begin 
							count_temp1 <= 3'd7;
						end 
					end 

				end 
			end 
			else begin 
				temp_reg <= 8'b0;
				count_temp0 <= 3'b0;
				count_temp1 <= 3'd7;
			end 
		end 
	end 
endmodule