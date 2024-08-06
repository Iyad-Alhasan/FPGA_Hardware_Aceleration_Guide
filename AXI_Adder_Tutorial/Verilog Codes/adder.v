`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2024 05:06:29 PM
// Design Name: 
// Module Name: adder
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


module adder #(parameter WIDTH=32) ( a , b , reset, clk, sum);
    
   
    
  input wire [WIDTH-1:0] a,b;
  input wire clk,reset;
  output reg [WIDTH-1:0] sum;

   
   always @(posedge clk) begin
       if (!reset)begin
        sum <= 0;
       end 
       else begin
        sum <= a+b;      
       end
   end
endmodule
