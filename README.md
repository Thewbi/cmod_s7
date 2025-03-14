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
Project Manager > IP Catalog > Vivado Repository > FPGA Features and Design > Clocking > Clocking Wizard > Double Click to start the wizard

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

Here is the code for the divider:

```
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
```

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

Here is a top-level module that assigns the divided clock to LED 1.

```
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
```

# State Machines with Verilog

The strategy outlined in the following was taken from  https://www.fpga4student.com/2017/09/verilog-code-for-moore-fsm-sequence-detector.html

This example creates a Moore state machine which is characterized by the fact that the output dependes on the current state (Not on the input).

A Moore state machine needs to check the input and transition to the next state.
It needs to produce output based on the current state.

In Verilog the state machine consists of:

* The identification of the next state - what is the next state going to be?
* The reset or application of the next state - perform reset and the transition into the next state!
* The output logic of the current state - output of signals based on the current state!

*In Verilog, a variable can only be written by one sequential logic block and never by more than one.*

This is the central constraint the dictates the architecture for state machines in Verilog. The architecture for Verilog makes no immediate sense to programmers of high-level programming languages (Höhere Programmiersprachen) in which a variable can be updated from several places in the code.

In Verilog the constraint above means that a logic block that determines and assigns the next state to the current state is conflicting with a logic that performs the reset because both blocks need to update the 'current_state' variable because the reset logic has to assign the initial state to the 'current_state' variable.

To get rid of this conflict, the reset and application of the next state is combined into a single logic block (reset or application of the next state). This reset/apply block will set a new value into the variable 'current_state'. It is the only block that writes to the 'current_state' variable and that way the Verilog constraint is met.

There will be a separate logic block (identification of the next state) that determines the next state but assigns that next state into the 'next_state' variable instead of into the 'current_state' variable directly. The reset/apply block will update 'current_state' from the 'next_state' variable as stated above.

A third block reads the 'current_state' variable and contains a large switch-case statement containing a case for each state of the statemachine. The case-statements perform the actions that the state machine has to execute during each individual state.

Next follows example code that shows how to implement a state machine according to the strategy outlined above.

## Define the states

First, define the states of the state machine as parameters.

```
//
// All states of the Moore state machine (= output only depends on the current state)
//
// Strategy: https://www.fpga4student.com/2017/09/verilog-code-for-moore-fsm-sequence-detector.html
//

parameter
    ResetState          = 4'b0000,      // S0 "Reset" State
    FetchState_1        = 4'b0001,      // S1 "FetchState_1" State
    FetchState_2        = 4'b0010,      // S2 "FetchState_2" State
    DecodeState         = 4'b0011,      // S3 "Decode" State
    MemAddrState        = 4'b0100,      // S4 "MemAddr" State
    MemReadState        = 4'b0101,      // S5 "MemRead" State
    MemWBState          = 4'b0110,      // S6 "MemWB" State
    MemWriteState       = 4'b0111,      // S7 "MemWrite" State
    ExecuteRState       = 4'b1000,      // S8 "ExecuteR" State
    ALUWriteBackState   = 4'b1001,      // S9 "ALUWriteBack"
    ExecuteIState       = 4'b1010,      // S10 "ExecuteI" State // execute I-Type instruction
    JALState            = 4'b1011,      // S11 "JAL" State
    BEQState            = 4'b1100,      // S12 "BEQ" State
    BRANCH_TAKEN_CHECK  = 4'b1101,      // S13 "BRANCH_TAKEN_CHECK" State
                                        // S14
    ErrorState          = 4'b1111       // S15 "ERROR" State
    ;
```

## Local Variables for State and Next State

Define current and next state variables:

```
// current state and next state
reg [3:0] current_state;
reg [3:0] next_state;
```

# Reset and Apply Next State Logic

Define the logic that applies the next state by updating the 'current_state' variable with the 'next_state' variable or the initial state constant. The state machine either resets or assigns current_state to next_state. When current_state equals next_state, then the state machine just remains in the current state

```
// sequential memory of the Moore FSM
always @(posedge clk, posedge reset)
begin
    if (reset == 1)
    begin

        $display("[XYZ] reset");

        // when reset=1, reset the state of the FSM to "FetchState_1" State
        current_state = FetchState_1;

        // further reset logic here

    end
    else
    begin
        $display("[XYZ] next state");

        // otherwise, next state
        current_state = next_state;
    end
end
```

## Define the logic for the current state

This block assigns no value to 'next_state' or 'current_state'.
It performs the actions of the current state.

```
//
// current state combinational logic
//
// combinational logic to determine the output
// of the Moore FSM, output only depends on current state
// Moore == output only depends on the current state
//

always @(current_state)
begin
    case(current_state)

        // S0 "Fetch_1" State
        FetchState_1:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.FETCH_STATE_1] op: %b, oldOp: %b, funct3: %b, funct7: %b", op, oldOp, funct3, funct7);

            // logic for this state goes here

        end

        // S1 "Decode" State
        DecodeState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.DECODE_STATE] op: %b, funct3: %b, funct7: %b", op, funct3, funct7);

            // logic for this state goes here
        end

        // S4 "MemAddr" State
        // sw rs2, offset(rs1) add offset to rs1 and store the value
        // rs2(31:0) → mem[rs1 + imm12]
        // sw x7, 84(x3)
        MemAddrState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.MemAddrState] op: %b, oldOp: %b, funct3: %b, funct7: %b", op, oldOp, funct3, funct7);

            // logic for this state goes here
        end

        // S5 "MemRead" State
        MemReadState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.MemReadState] op: %b, oldOp: %b, funct3: %b, funct7: %b", op, oldOp, funct3, funct7);

            // logic for this state goes here
        end

        // S6 "MemWB" State
        MemWBState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.MemWBState] op: %b, oldOp: %b, funct3: %b, funct7: %b", op, oldOp, funct3, funct7);

            // logic for this state goes here
        end

        // S7 "MemWrite" State
        MemWriteState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.MemWriteState] op: %b, oldOp: %b, funct3: %b, funct7: %b", op, oldOp, funct3, funct7);

            // logic for this state goes here
        end

        // S8 "ExecuteRState" State // execute R-Type instruction
        ExecuteRState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.ExecuteRState] op: %b, funct3: %b, funct7: %b", op, funct3, funct7);

            // logic for this state goes here
        end

        // S9 "ALUWriteBackState" State
        ALUWriteBackState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.ALUWB_STATE]");

            // logic for this state goes here
        end

        // S10 "ExecuteI" State // execute I-Type instruction
        ExecuteIState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.EXECUTEI_STATE]");

            // logic for this state goes here
        end

        // S11 "JAL" State // execute J Type instruction
        JALState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.JALState]");

            // logic for this state goes here
        end

        // S12 "BEQ" State
        BEQState:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.BEQ_STATE]");

            // logic for this state goes here
        end

        // S13 "BRANCH_TAKEN_CHECK" State
        BRANCH_TAKEN_CHECK:
        begin
            $display("");
            $display("");
            $display("[CTRL.OUTPUT.BRANCH_TAKEN_CHECK]");

            // logic for this state goes here
        end

        default:
        begin
            $display("[CTRL.OUTPUT.?] No case in always @(current_state) current_state = %d", current_state);
        end
    endcase
end
```

## Provide the logic that determines the next state

This block assigns values to the 'next_state' variable (not to the 'current_state' variable)

```
//
// next state combinational logic
//
// combinational logic of the Moore FSM to determine next state
//

always @(current_state, reset)
begin

    case(current_state)

        // S0 "Reset" State
        ResetState:
        begin
            $display("reset: %d", reset);
            if (reset == 0)
            begin
                $display("[controller] goto ResetState -> FetchState_1");
                next_state = FetchState_1;
            end
        end

        // S1 "Fetch_1" State
        FetchState_1:
        begin
            $display("[controller] goto FetchState_1 -> DecodeState");
            next_state = DecodeState;
        end

        // S1 "Decode" State
        DecodeState:
        begin
            $display("[controller DecodeState] op: %b", op);
            if ((op == 7'b0000011) || (op == 7'b0100011)) // lw or sw
            begin
                $display("[controller] goto DecodeState -> MemAddrState");
                next_state = MemAddrState;
            end
            else if (op == 7'b0110011) // R-Type
            begin
                $display("[controller] goto DecodeState -> ExecuteRState");
                next_state = ExecuteRState;
            end
            else if (op == 7'b0010011) // I-Type ALU
            begin
                $display("[controller] goto DecodeState -> ExecuteIState");
                next_state = ExecuteIState;
            end
            else if (op == 7'b1101111) // JAL
            begin
                $display("[controller] goto DecodeState -> JALState");
                next_state = JALState;
            end
            else if (op == 7'b1100011) // BEQ
            begin
                $display("[controller] goto DecodeState -> BEQState");
                next_state = BEQState;
            end
            else if (op == 7'b0000000) // nop
            begin
                $display("[controller] goto DecodeState -> FetchState_1 for nop");
                next_state = FetchState_1;
            end
            else
            begin
                $display("[controller] goto DecodeState -> ErrorState");
                next_state = ErrorState;
            end
        end

        // S4 "MemAddr" State
        MemAddrState:
        begin
            $display("[controller] goto MemAddr -> FetchState_1");
            next_state = FetchState_1;
        end

        // S5 "MemRead" State
        MemReadState:
        begin
            $display("[controller] goto MemReadState -> MemWBState");
            next_state = MemWBState;
        end

        // S6 "MemWB" State
        MemWBState:
        begin
            $display("[controller] goto MemWBState -> FetchState_1");
            next_state = FetchState_1;
        end

        // S7 "MemWrite" State
        MemWriteState:
        begin
            $display("[controller] goto MemWriteState -> FetchState_1");
            next_state = FetchState_1;
        end

        // S8 "ExecuteR" State
        ExecuteRState:
        begin
            $display("[controller] goto ExecuteRState -> ALUWriteBackState");
            next_state = ALUWriteBackState;
        end

        // S9 "ALUWB" State
        ALUWriteBackState:
        begin
            $display("[controller] goto ALUWriteBackState -> FetchState_1");
            next_state = FetchState_1;
        end

        // S10 "ExecuteI" State // execute I-Type instruction
        ExecuteIState:
        begin
            $display("[controller] goto ExecuteIState -> ALUWriteBackState");
            next_state = ALUWriteBackState;
        end

        // S11 "JAL" State
        JALState:
        begin
            $display("[controller] goto JALState -> ALUWriteBackState");
            next_state = ALUWriteBackState;
        end

        // S12 "BEQ" State
        BEQState:
        begin
            $display("[controller] goto BEQState -> BRANCH_TAKEN_CHECK.");
            next_state = BRANCH_TAKEN_CHECK;
        end

        // S13 "BRANCH_TAKEN_CHECK" State
        BRANCH_TAKEN_CHECK:
        begin
            $display("[controller] goto BRANCH_TAKEN_CHECK -> FetchState_1.");
            next_state = FetchState_1;
        end

        // S15 "ERROR" State
        ErrorState:
        begin
            $display("[controller] goto ErrorState -> ErrorState");
            next_state = ErrorState;
        end

        default:
        begin
            $display("[controller] default goto default -> ErrorState");
            next_state = ErrorState;
        end

    endcase
end
```

# UART

https://forum.digikey.com/t/uart-vhdl/12670