module slave_select(
	input p_clk, send_data, mstr, PRESETn, SPISWAI,
	input [1:0]spi_mod,
	input [11:0] BD,
	
	output reg receive_data, 
	output reg ss_out, 
	output tip_out
);

	//internal veriables 
	wire [15:0]target;
	reg RD;
	reg [15:0] count;
	
	//parameter for mode of spi_mod
	parameter RUN  = 2'b00,
			  WAIT = 2'b01,
			  STOP = 2'b10;
	
	//wire assignment 
	assign target = 8 * BD;
	assign tip_out = ~ss_out;
	
	//counter logic  and slave select logic 
	always @(posedge p_clk or negedge PRESETn) begin
		if(!PRESETn) begin
			count <= 16'hffff;
			ss_out <= 1'b1;
		end 
		else begin 
			if((spi_mod == RUN || (spi_mod == WAIT && SPISWAI == 0)) && mstr) begin 
				if(!send_data) begin
					if(count < (target - 1)) begin 
						count <= count + 1;
						ss_out <= 1'b0;
					end 
					else begin 
						count <= 16'hffff;
						ss_out <= 1'b1;
					end 
				end
				else begin 
					count <= 16'b0;
					ss_out <= 1'b0;
				end
			end 
			else begin 
				count <= 16'hffff;
				ss_out <= 1'b1;
			end
		end 
	end 
	
	//receive_data logic  
	always @(posedge p_clk or negedge PRESETn) begin
		if(!PRESETn) begin
			RD <= 1'b0;
		end 
		else begin 
			if((spi_mod == RUN || (spi_mod == WAIT && SPISWAI == 0)) && mstr) begin 
				if(!send_data) begin 
					if(count == target - 2) begin 
						RD <= 1'b1;
					end 
					else begin 
						RD <= 1'b0;
					end 
				end
				else begin 
					RD <= 1'b0;
				end
			end 
			else begin 
				RD <= 1'b0;
			end
		end 
	end
	
	//delaying by one cycle 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin
			receive_data <= 1'b0;
		end 
		else begin 
			receive_data <= RD;
		end 
	end 
	
	/*ss_out logic
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
				ss_out <= 1'b1;
		end 
		else begin 
			if((spi_mod == RUN || (spi_mod == WAIT && SPISWAI == 0)) && mstr) begin
				if(send_data) begin 
					ss_out <= 1'b0;
				end 
				else begin
					if(count <= target - 1) begin
						ss_out <= 1'b0;
					end 
					else 
						ss_out <= 1'b1;
				end 
			else begin 
				ss_out <= 1'b1;
			end
			end 
		end 
	end*/ 

endmodule 