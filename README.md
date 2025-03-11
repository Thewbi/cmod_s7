# cmod_s7
CMOD S7 Digilent Breakout Board Source Code

## Links

https://community.element14.com/technologies/fpga-group/b/blog/posts/little-tutorial-of-fpga-with-cmods7

## New Project

File > Project > New
Check Create Project Subdirectory
Name: UART
Project Type: RTL Project
Do not add any sources
Target Language: Verilog
Simulator Language: Mixed
Add Constraints: https://github.com/Digilent/Cmod-S7-25-OOB/blob/master/src/constraints/Cmod-S7-25-Master.xdc

As a part, change to the "Boards" tab > Press the refresh button so that Vivado downloads the latest board files.
Then search for CMOD S7 and use the small download button to actually install the board files for that board.

## Installing the board files

First, create the folder:
D:\Xilinx\Vivado\2024.2\data\boards\board_files 

Then download the board files: https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-sdk?redirect=1
Extract the downloaded archive and navigate to vivado-boards-master\new\board_files.
Copy all contained folders to D:\Xilinx\Vivado\2024.2\data\boards\board_files

## Retrieveing a constraints File

https://github.com/Digilent/Cmod-S7-25-OOB/blob/master/src/constraints/Cmod-S7-25-Master.xdc

## Clock Generation

Mixed-mode clock manager (MMCM) to generate a 100 Mhz clock.
Project Manager > IP Catalog > Vivado Repository > FPGA Features and Design > Clocking > Clocking Wizard 
> Double Clock to start the wizard

Switch to the "Clocking Options" Tab and change Primary clk_in1 to 12.000 Mhz since the CMOD S7 has a 12 Mhz clock source onboard.
Switch to the "Output Clocks" Tab and make sure clk_out1 is set to 100.000 Mhz.
Click OK.
A dialog called "Generate Output Products" opens up. 
Select "Out of context per IP".
Click "Generate"
In the very top right corner, the system displays a green laoding circle as long as it is generating the code for the Clocking IP.
Once generation is ready, there will be an entry in the Design Sources folder which is displayed in the Sources tile in the center of Vivado.

## Add a top-level module

File > Add Sources > Add or create design sources > Next > Create File > 
File type > Verilog
File name: top
File location: Local to project

## Instantiate the Clock

In the Design Sources unfold until you see clk_wiz_0 this is the module that you can instantiate inside the top module.

An example top module might be:

```
module top(

    );
    
    wire clk_out1;
    wire reset;
    wire locked;
    wire clk_in1;
    
    clk_wiz_0 clock(
        // Clock in ports
        // Clock out ports
        clk_out1,
        // Status and control signals
        reset,
        locked,
        clk_in1
    );
 
endmodule
```

## Connect the 12 Mhz Onboard Clock to the Clocking Wizard IP

The MMCM needs a input reference clock in order to generate the 100 Mhz output clock.
The input reference clock is the 12 Mhz onboard clock. 
The constraint file defines a name for the reference clock.
Open the file Constraints > constrs_1 > Cmod-S7-25-Master.xdc and search for:

```
# 12 MHz System Clock
```

below this comment, a port called clk is defined. 

```
set_property -dict { PACKAGE_PIN M9    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L13P_T2_MRCC_14 Sch=gclk
```

Using this name in the top module will give you access to the reference clock.
Forward the reference clock to the MMCM instance:

```
module top(
    input wire clk
    );
    
    wire clk_out1;
    wire reset;
    wire locked;
    //wire clk_in1;
    
    clk_wiz_0 clock(
        // Clock in ports
        // Clock out ports
        clk_out1,
        // Status and control signals
        reset,
        locked,
        clk
    );
 
endmodule
```

## Building a 0.5 Seconds clock divider to blink a LED

Follwing this tutorial: https://www.youtube.com/watch?v=iei1EugtQvQ&t=563s

Create another source file for a clock divider.

File > Add Sources > Add or create design sources > Next > Create File > 
File type > Verilog
File name: clock_divider
File location: Local to project

## Using the LEDS

ERROR: [DRC NSTD-1] Unspecified I/O Standard: 4 out of 5 logical ports use I/O standard (IOSTANDARD) value 'DEFAULT', 
instead of a user assigned specific value. This may cause I/O contention or incompatibility with the board power or 
connectivity affecting performance, signal integrity or in extreme cases cause damage to the device or the components 
to which it is connected. To correct this violation, specify all I/O standards. This design will fail to generate a 
bitstream unless all logical ports have a user specified I/O standard value defined. To allow bitstream creation with 
unspecified I/O standard values (not recommended), use this command: set_property SEVERITY {Warning} [get_drc_checks NSTD-1].
NOTE: When using the Vivado Runs infrastructure (e.g. launch_runs Tcl command), add this command to a .tcl file and add that 
file as a pre-hook for write_bitstream step for the implementation run. Problem ports: leds[3:0].

Solution: Double check the signal names defined in the constraint files and make sure you use them exactly in your design as stated in the constraint file!

ERROR: [DRC UCIO-1] Unconstrained Logical Port: 4 out of 5 logical ports have no user assigned specific location constraint (LOC). 
This may cause I/O contention or incompatibility with the board power or connectivity affecting performance, signal integrity or 
in extreme cases cause damage to the device or the components to which it is connected. To correct this violation, specify all 
pin locations. This design will fail to generate a bitstream unless all logical ports have a user specified site LOC constraint defined. 
To allow bitstream creation with unspecified pin locations (not recommended), use this command: set_property SEVERITY {Warning} [get_drc_checks UCIO-1].  
NOTE: When using the Vivado Runs infrastructure (e.g. launch_runs Tcl command), add this command to a .tcl file and add that file as a pre-hook for 
write_bitstream step for the implementation run.  Problem ports: leds[3:0].


One prerequisit to using LEDS is that I/O standards have to be defined explicitly.

## UART

https://forum.digikey.com/t/uart-vhdl/12670