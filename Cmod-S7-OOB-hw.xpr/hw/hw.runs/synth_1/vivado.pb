
>
Refreshing IP repositories
234*coregenZ19-234h px� 
�
�Failed to load user IP repository '%s'; %s
If this directory should no longer be in your list of user repositories, go to the IP Settings dialog and remove it.
1318*coregen2	
c:/repo2 
Can't find the specified path.Z19-2248h px� 
j
"Loaded Vivado IP repository '%s'.
1332*coregen2!
D:/Xilinx/Vivado/2024.2/data/ipZ19-2313h px� 
�
Command: %s
53*	vivadotcl2u
ssynth_design -top top -part xc7s25csga225-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction offZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
y
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2
xc7s25Z17-347h px� 
i
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2
xc7s25Z17-349h px� 
D
Loading part %s157*device2
xc7s25csga225-1Z21-403h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
M
#Helper process launched with PID %s4824*oasys2
5284Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 1001.613 ; gain = 465.754
h px� 
�
synthesizing module '%s'%s4497*oasys2
top2
 2Q
MC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/top.v2
198@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
pwm2
 2Q
MC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/pwm.v2
248@Z8-6157h px� 
P
%s
*synth28
6	Parameter COUNTER_WIDTH bound to: 8 - type: integer 
h p
x
� 
N
%s
*synth26
4	Parameter MAX_COUNT bound to: 255 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pwm2
 2
02
12Q
MC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/pwm.v2
248@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	debouncer2
 2W
SC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/debouncer.v2
48@Z8-6157h px� 
H
%s
*synth20
.	Parameter WIDTH bound to: 2 - type: integer 
h p
x
� 
L
%s
*synth24
2	Parameter CLOCKS bound to: 1024 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter CLOCKS_CLOG2 bound to: 10 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	debouncer2
 2
02
12W
SC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/debouncer.v2
48@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2	
uart_tx2
 2U
QC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/uart_tx.v2
178@Z8-6157h px� 
X
%s
*synth2@
>	Parameter BAUD_2_CLOCK_RATIO bound to: 1250 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter UART_DATA_BITS bound to: 8 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter UART_STOP_BITS bound to: 2 - type: integer 
h p
x
� 
M
%s
*synth25
3	Parameter BUTTON_POLARITY_VECTOR bound to: 2'b11 
h p
x
� 
O
%s
*synth27
5	Parameter BUTTON_WIDTH bound to: 2 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
uart_tx2
 2
02
12U
QC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/uart_tx.v2
178@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
busy2	
uart_tx2
	m_uart_tx2Q
MC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/top.v2
748@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
	m_uart_tx2	
uart_tx2
42
32Q
MC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/top.v2
748@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top2
 2
02
12Q
MC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/sources_1/imports/hdl/top.v2
198@Z8-6155h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1107.883 ; gain = 572.023
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1107.883 ; gain = 572.023
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1107.883 ; gain = 572.023
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0032

1107.8832
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2i
eC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/constrs_1/imports/constraints/Cmod-S7-25-Master.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2i
eC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/constrs_1/imports/constraints/Cmod-S7-25-Master.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2g
eC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.srcs/constrs_1/imports/constraints/Cmod-S7-25-Master.xdc2
.Xil/top_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1191.9262
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0252

1191.9262
0.000Z17-268h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:21 ; elapsed = 00:00:26 . Memory (MB): peak = 1191.926 ; gain = 656.066
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7s25csga225-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:21 ; elapsed = 00:00:26 . Memory (MB): peak = 1191.926 ; gain = 656.066
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:21 ; elapsed = 00:00:26 . Memory (MB): peak = 1191.926 ; gain = 656.066
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:22 ; elapsed = 00:00:26 . Memory (MB): peak = 1191.926 ; gain = 656.066
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 1     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               11 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                2 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 7     
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 1     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
o
%s
*synth2W
UPart Resources:
DSPs: 80 (col length:40)
BRAMs: 90 (col length: RAMB18 40 RAMB36 20)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:25 ; elapsed = 00:00:30 . Memory (MB): peak = 1191.926 ; gain = 656.066
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:33 ; elapsed = 00:00:38 . Memory (MB): peak = 1309.941 ; gain = 774.082
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:33 ; elapsed = 00:00:38 . Memory (MB): peak = 1329.188 ; gain = 793.328
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2y
wFinished IO Insertion : Time (s): cpu = 00:00:39 ; elapsed = 00:00:44 . Memory (MB): peak = 1535.922 ; gain = 1000.062
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:39 ; elapsed = 00:00:44 . Memory (MB): peak = 1535.922 ; gain = 1000.062
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:39 ; elapsed = 00:00:44 . Memory (MB): peak = 1535.922 ; gain = 1000.062
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|      |Cell   |Count |
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|1     |BUFG   |     1|
h px� 
2
%s*synth2
|2     |CARRY4 |     7|
h px� 
2
%s*synth2
|3     |LUT1   |     7|
h px� 
2
%s*synth2
|4     |LUT2   |    16|
h px� 
2
%s*synth2
|5     |LUT3   |    22|
h px� 
2
%s*synth2
|6     |LUT4   |    16|
h px� 
2
%s*synth2
|7     |LUT5   |    22|
h px� 
2
%s*synth2
|8     |LUT6   |    26|
h px� 
2
%s*synth2
|9     |FDRE   |    81|
h px� 
2
%s*synth2
|10    |FDSE   |     4|
h px� 
2
%s*synth2
|11    |IBUF   |     3|
h px� 
2
%s*synth2
|12    |OBUF   |     8|
h px� 
2
%s*synth2
+------+-------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:39 ; elapsed = 00:00:44 . Memory (MB): peak = 1535.922 ; gain = 1000.062
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:26 ; elapsed = 00:00:39 . Memory (MB): peak = 1535.922 ; gain = 916.020
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:39 ; elapsed = 00:00:44 . Memory (MB): peak = 1535.922 ; gain = 1000.062
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0022

1535.9222
0.000Z17-268h px� 
S
-Analyzing %s Unisim elements for replacement
17*netlist2
7Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1535.9222
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

e889ef1fZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
~
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
252
42
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:442

00:00:532

1535.9222

1167.547Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0032

1535.9222
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2C
AC:/dev/fpga/cmod_s7/Cmod-S7-OOB-hw.xpr/hw/hw.runs/synth_1/top.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2Q
Oreport_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Tue Mar 11 17:07:07 2025Z17-206h px� 


End Record