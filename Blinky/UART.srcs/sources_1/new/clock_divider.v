`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2025 07:34:35 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input wire clk,
    output reg divided_clk = 0
    );
    
    // (clock_frequency / (2*desired_frequency)) - 1
    // (100 Mhz / (2*1 Hz)) - 1 = (100000000 / 2) - 1 = 50000000 - 1 = 49999999
    localparam div_value = 49999999; 
    integer counter_value = 0;
    
    always @(posedge clk)
    begin
        if (counter_value == div_value)
        begin
            counter_value = 0;
        end
        else
        begin 
            counter_value <= counter_value + 1;
        end
    end
    
    always @(posedge clk)
    begin
        if (counter_value == div_value)
        begin
            divided_clk <= ~divided_clk;
        end
        else
        begin 
            divided_clk <= divided_clk;
        end
    end
    
endmodule
