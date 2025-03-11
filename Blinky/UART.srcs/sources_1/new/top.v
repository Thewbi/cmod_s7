`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2025 06:57:30 PM
// Design Name: 
// Module Name: top
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


module top(
    input wire clk,
    output wire[3:0] led
    );
    
    wire clk_out1;
    wire reset;
    wire locked;
    
    clk_wiz_0 clock(
        // Clock in ports
        // Clock out ports
        clk_out1,
        // Status and control signals
        reset,
        locked,
        clk
    );
    
    wire slow_clk;
    
    clock_divider cd(clk_out1, slow_clk);
    
    assign led[0] = slow_clk;
    assign led[1] = 0;
    assign led[2] = 0;
    assign led[3] = 0;    
 
endmodule
