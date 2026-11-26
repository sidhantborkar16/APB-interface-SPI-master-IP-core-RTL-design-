module APB_slave(
	input p_clk,
	input PRESETn,
	input [2:0]PADDR,
	input PWRITE,
	input PSEL,
	input PENABLE,
	input [7:0] PWDATA,
	input spi_ss,
	input [7:0] MISO_data,
	input tip,
	input receive_data,
	
	//output signal 
	output reg [7:0] PRDATA, //done 
	output MSTR, //done 
	output cpol, //done 
	output cphase, //done 
	output LSBFE, //done 
	output SPISWAI, //done 
	output [2:0] SPR , SPPR, //done 
	output reg SPI_intrrupt_req, //done 
	output PREADY, //done 
	output PSLVERR, //done 
	output reg send_data, //done 
	output reg [7:0]MOSI_data,// done 
	output reg [1:0]spi_mod //done 
);

	//internal veriable
	wire w_en , r_en;
	
	//internal registers 
	reg [7:0] CR1;
	reg [7:0] CR2;
	reg [7:0] BR;
	reg [7:0] SR;
	reg [7:0] DR;
	
	//bits or register which we are not using at the output of this block but we will use internally 
	wire spie, spe, sptie, ssoe; //CR1
	wire modfen; //CR2
	wire spif, sptef, modf; // SR
	
	//state register for FSM logic 
	reg [1:0] APB_PS, APB_NS; // for APB
	reg [1:0] SPI_NS; //for SPI
	
	//mask parameter 
	parameter CR2_mask = 8'b00011011,
			  BR_mask  = 8'b01110111;
			  
	//parameter defination for the APB FSM logic 
	parameter IDEAL = 2'b00,
			  SETUP = 2'b01,
			  ENABLE = 2'b10;
			  
	//parameter defination for the APB FSM logic 
	parameter RUN = 2'b00,
			  WAIT = 2'b01,
			  STOP = 2'b10;
	
	//APB_PS FSM logic 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			APB_PS <= IDEAL;
		end 
		else begin 
			APB_PS <= APB_NS;
		end 
	end 
	//APB_NS logic 
	always @(*) begin 
		case(APB_PS)
			IDEAL : begin 
				if(PSEL && !PENABLE)begin 
					APB_NS = SETUP;
				end 
				else begin 
					APB_NS = IDEAL;
				end 
			end
			
			SETUP : begin 
				if(PSEL && PENABLE)begin 
					APB_NS = ENABLE;
				end 
				else if (PSEL && !PENABLE) begin 
					APB_NS = SETUP;
				end 
				else begin 
					APB_NS = IDEAL;
				end 
			end
			
			ENABLE : begin 
				if(PSEL)begin 
					APB_NS = SETUP;
				end 
				else begin 
					APB_NS = IDEAL;
				end 
			end
			
			default : APB_NS = IDEAL;
		endcase 
	end 
	
	//spi_mod logic
	always @(posedge p_clk or negedge PRESETn) begin
		if(!PRESETn) begin 
			spi_mod <= RUN;
		end 
		else begin 
			spi_mod <= SPI_NS;
		end 
	end 
	
	//SPI_NS logic 
	always @(*) begin
		case(spi_mod)
			RUN : begin 
				if(!spe) begin 
					SPI_NS = WAIT;
				end 
				else begin 
					SPI_NS = RUN;
				end 
			end 
			
			WAIT : begin 
				if(spe) begin 
					SPI_NS = RUN;
				end 
				else if( SPISWAI) begin
					SPI_NS = STOP;
				end 
				else begin 
					SPI_NS = WAIT;
				end 
			end 
			
			STOP : begin 
				if(spe) begin 
					SPI_NS = RUN;
				end 
				else if(!SPISWAI) begin 
					SPI_NS = WAIT;
				end 
				else begin 
					SPI_NS = STOP;
				end 
			end 
	
			default : SPI_NS = RUN;
			
		endcase 
	end 
	
	//Logic for write enable and read enable 
	assign w_en = (PWRITE && APB_PS == ENABLE)? 1'b1 : 1'b0;
	assign r_en = (!PWRITE && APB_PS == ENABLE)? 1'b1 : 1'b0;
	
	//Logic for PSLVERR and PREADY
	assign PSLVERR = (APB_PS == ENABLE)? ~tip : 1'b0;
	assign PREADY  = (APB_PS == ENABLE)? 1'b1 : 1'b0;
	
	// All 5 register logics 
	//CR1
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			CR1 <= 8'b00000100;
		end 
		else begin 
			if(w_en) begin
				if (PADDR == 3'b000) begin 
					CR1 <= PWDATA;
				end 
				else begin 
					CR1 <= CR1;
				end 
			end 
			else begin 
				CR1 <= CR1;
			end 
		end 
	end 
	
	//CR2 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			CR2 <= 8'b00000000;
		end 
		else begin 
			if(w_en) begin
				if (PADDR == 3'b001) begin 
					CR2 <= (PWDATA & CR2_mask);
				end 
				else begin 
					CR2 <= CR2;
				end 
			end 
			else begin 
				CR2 <= CR2;
			end 
		end 
	end 
	
	//BR
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			BR <= 8'b00000000;
		end 
		else begin 
			if(w_en) begin
				if (PADDR == 3'b010) begin 
					BR <= (PWDATA & BR_mask);
				end 
				else begin 
					BR <= BR;
				end 
			end 
			else begin 
				BR <= BR;
			end 
		end 
	end 
	
	//SR
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			SR <= 8'b00100000;
		end 
		else begin 
			SR <= {spif,1'b0,sptef,modf,4'b0};
		end 
	end 
	
	//DR 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			DR <= 8'b0;
		end 
		else begin 
			if(w_en) begin 
				if(PADDR == 3'b101) begin 
					DR <= PWDATA;
				end 
				else begin 
					DR <= DR;
				end 
			end 
			else begin 
				if((spi_mod == WAIT || spi_mod == RUN) && DR != MISO_data && DR == PWDATA) begin 
					DR <= 8'b0;
				end 
				else begin 
					if((spi_mod == WAIT || spi_mod == RUN) && receive_data) begin 
						DR <= MISO_data;
					end
					else begin 
						DR <= DR;
					end 
				end 
			end 
		end 
	end 

	assign modf = (!spi_ss && MSTR && modfen && ssoe)? 1'b1 : 1'b0;
	assign sptef = (DR == 8'b0)? 1'b1 : 1'b0;
	assign spif = (DR != 8'b0)? 1'b1 : 1'b0;
	assign ssoe = CR1[1];
	assign SPR = BR[2:0];
	assign SPPR = BR[6:4];
	assign SPISWAI = CR2[1];
	assign MSTR = CR1[4];
	assign cpol = CR1[3];
	assign cphase = CR1[2];
	assign LSBFE = CR1[0];
	assign spie = CR1[7];
	assign spe = CR1[6];
	assign sptie = CR1[5];
	assign modfen = CR2[4];
	
	//PRDATA logic 
	always @(*) begin 
		if(!r_en) begin 
			PRDATA = 8'b0;
		end
		else begin 
			case(PADDR)
				3'b000 : PRDATA = CR1;
				3'b001 : PRDATA = CR2;
				3'b010 : PRDATA = BR;
				3'b011 : PRDATA = SR;
				3'b101 : PRDATA = DR;
				3'b100 , 3'b110 , 3'b111 : PRDATA = 8'b00000000;
				//default : PRDATA = 8'b0;
			endcase 
		end 
	end 
	
	// send_data logic 
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			send_data <= 1'b0;
		end 
		else begin 
			if(!w_en) begin 
				if((spi_mod == RUN || spi_mod == WAIT) && (DR != MISO_data) && (DR == PWDATA)) begin 
					send_data <= 1'b1;
				end 
				else begin 
					send_data <= 1'b0;
				end 
			end 
			else begin 
				send_data <= 1'b0;
			end 
		end 
	end 
	
	//MOSI_data Logic  
	always @(posedge p_clk or negedge PRESETn) begin 
		if(!PRESETn) begin 
			MOSI_data <= 8'b0;
		end 
		else begin 
			if((spi_mod == RUN || spi_mod == WAIT) && (DR != MISO_data) && (DR == PWDATA)) begin 
				MOSI_data <= DR;
			end 
			else begin
				MOSI_data <= MOSI_data;
			end 
		end 
	end 
	
	//SPI_intrrupt_req Logic 
	always @(*) begin 
		if(!spie && !sptie) begin 
			SPI_intrrupt_req = 1'b0;
		end 
		else begin 
			if(!sptie && spie) begin 
				SPI_intrrupt_req = (spif | modf);
			end 
			else begin 
				if(!spie && sptie) begin 
					SPI_intrrupt_req = sptef;
				end 
				else begin 
					SPI_intrrupt_req = (spif | modf | sptef);
				end 
			end 
		end 
	end 
	
endmodule 