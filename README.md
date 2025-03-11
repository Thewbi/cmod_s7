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


D:\Xilinx\Vivado\2024.2\

## Installing the board files

First, create the folder:
D:\Xilinx\Vivado\2024.2\data\boards\board_files 

Then download the board files: https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-sdk?redirect=1
Extract the downloaded archive and navigate to vivado-boards-master\new\board_files.
Copy all contained folders to D:\Xilinx\Vivado\2024.2\data\boards\board_files

## Retrieveing a constraints File

https://github.com/Digilent/Cmod-S7-25-OOB/blob/master/src/constraints/Cmod-S7-25-Master.xdc