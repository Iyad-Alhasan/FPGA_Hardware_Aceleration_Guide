`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2024 05:21:55 PM
// Design Name: 
// Module Name: aadder_AXIS_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module aadder_AXIS_wrapper #(
		
		// Parameters of Axi Master Bus Interface M_AXIS
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Parameters of Axi Slave Bus Interface S_AXIS
		parameter integer C_S_AXIS_TDATA_WIDTH	= 2*C_M_AXIS_TDATA_WIDTH
	)
	
	(
		// Ports of Axi Slave Bus Interface S_AXIS
		input wire  aclk,
		input wire  aresetn,
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] s_axis_tdata,
		input wire  s_axis_tlast,
		input wire  s_axis_tvalid,

		// Ports of Axi Master Bus Interface M_AXIS
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire  m_axis_tlast
		
	);
    
    reg tvalid_reg_m, tlast_reg_m;
    
    assign m_axis_tvalid = tvalid_reg_m;
    assign m_axis_tlast = tlast_reg_m;
always @ (posedge aclk) begin
   if (!aresetn) begin
        tvalid_reg_m <=0;
        tlast_reg_m <=0;
   end
   else begin
       if (s_axis_tvalid) begin
        tlast_reg_m <=1'b0;
        tvalid_reg_m <=s_axis_tvalid; 
        if (s_axis_tlast)
             tlast_reg_m <=1'b1;
       end
       if (!s_axis_tvalid) begin
        tvalid_reg_m <=0;
        tlast_reg_m <=0;
       end      
   end
end
    
    
    adder #(.WIDTH(C_M_AXIS_TDATA_WIDTH)) my_axi_adder  ( 
    .a(s_axis_tdata[C_S_AXIS_TDATA_WIDTH-1:C_S_AXIS_TDATA_WIDTH/2]) , 
    .b((s_axis_tdata[(C_S_AXIS_TDATA_WIDTH/2)-1:0])) , 
    .reset(aresetn), 
    .clk(aclk), 
    .sum(m_axis_tdata) );
endmodule
