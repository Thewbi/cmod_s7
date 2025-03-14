# UART

UART is a character/symbol oriented system.
This means that it defines the transmission of a single character/symbol.

The transmission format of a symbol is defined as 8N1 for example
8 - eight bits of data per symbol (could also be 5, 6, or 7)
N - no parity bit
1 - a single stop bit.

Larger messages that consist of several symbols are not defined in the
UART system. The UART system has no notion of larger messages than individual
symbols. To tranmit larger messages, send several individual symbols in the
correct order.

baud rate
9600 baud means 9600 bits per second.
source: https://nandland.com/uart-rs-232-serial-port-com-port/

At the receiver side, the rx line has to be sampled to detect the transmitted
bit values. Sampling has to be performed at least 8 times faster than the
transmit baud rate.

The receiver is constantly sampling the tx line because it needs to detect
the start of a transmission from the sender.

The tx line is normally high. This means when no transmission takes place,
the line is high. When the line goes low, a transmission is detected.

The first transition from high to low is what starts the transmission of the
so called start bit. The start bit is a bit that is part of the format of
UART messages and not part of the payload of UART messages. Each UART message
starts with the start bit.

One strategy for sampling is to make sure to sample in the middle of a bit.
Sampling in the middle of a bit is safer than sampling close to the edges
because close to an edge the signal might not have stablilized whereas the
signal should have stabilised in the middle of a bit.

To find the middle of a bit, when the start bit is detected, the sampler
waits for half a bit time (baud_rate / 2) to arrive at the center of a bit.
It will then take samples (How many? At least 8 times faster than the baud_rate).
Then it will wait a full bit (= baud_rate ticks) to arrive at the middle
of the next bit and then take samples again until the entire message (all bits
according to the format, e.g. 8N1) has been sampled. The stop bit/bits can
be sampled for validating the message's consistancy.

# Code documentation

## Transmitter

```
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_TX is
  generic (
    g_CLKS_PER_BIT : integer := 115     -- Needs to be set correctly
    );
  port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
end UART_TX;
```

i_Clk 		- clock signal

i_TX_DV 	- send in the information if the data to send is readily provided.
			  Setting this value to 1 starts the transmission. (State machine leaves idle state)

i_TX_Byte 	- the data to send

o_TX_Active	- 0 as long as the transceiver is idle, 1 during transmission, goes back
			  to 0 when the transmission is done

o_TX_Serial - The TX line. Needs to be high when no transition takes place

o_TX_Done	- Goes high for a very short amount of clocks when the symbol is
              transmitted

The implementation

```
architecture RTL of UART_TX is

  type t_SM_Main is (s_Idle, s_TX_Start_Bit, s_TX_Data_Bits,
                     s_TX_Stop_Bit, s_Cleanup);
  signal r_SM_Main : t_SM_Main := s_Idle;

  signal r_Clk_Count : integer range 0 to g_CLKS_PER_BIT-1 := 0;
  signal r_Bit_Index : integer range 0 to 7 := 0;  -- 8 Bits Total
  signal r_TX_Data   : std_logic_vector(7 downto 0) := (others => '0');
  signal r_TX_Done   : std_logic := '0';

begin

  p_UART_TX : process (i_Clk)
  begin
    if rising_edge(i_Clk) then

      case r_SM_Main is

		-- State idle
        when s_Idle =>
          o_TX_Active <= '0';
          o_TX_Serial <= '1';         -- Drive Line High for Idle
          r_TX_Done   <= '0';
          r_Clk_Count <= 0;
          r_Bit_Index <= 0;

          if i_TX_DV = '1' then
            r_TX_Data <= i_TX_Byte;
            r_SM_Main <= s_TX_Start_Bit;
          else
            r_SM_Main <= s_Idle;
          end if;

        -- Send out Start Bit. Start bit = 0
        when s_TX_Start_Bit =>
          o_TX_Active <= '1';
          o_TX_Serial <= '0';

          -- Wait g_CLKS_PER_BIT-1 clock cycles for start bit to finish
          if r_Clk_Count < g_CLKS_PER_BIT-1 then
            r_Clk_Count <= r_Clk_Count + 1;
            r_SM_Main   <= s_TX_Start_Bit;
          else
            r_Clk_Count <= 0;
            r_SM_Main   <= s_TX_Data_Bits;
          end if;

        -- Wait g_CLKS_PER_BIT-1 clock cycles for data bits to finish
        when s_TX_Data_Bits =>
          o_TX_Serial <= r_TX_Data(r_Bit_Index);

          if r_Clk_Count < g_CLKS_PER_BIT-1 then
            r_Clk_Count <= r_Clk_Count + 1;
            r_SM_Main   <= s_TX_Data_Bits;
          else
            r_Clk_Count <= 0;

            -- Check if we have sent out all bits
            if r_Bit_Index < 7 then
              r_Bit_Index <= r_Bit_Index + 1;
              r_SM_Main   <= s_TX_Data_Bits;
            else
              r_Bit_Index <= 0;
              r_SM_Main   <= s_TX_Stop_Bit;
            end if;
          end if;

        -- Send out Stop bit. Stop bit = 1
        when s_TX_Stop_Bit =>
          o_TX_Serial <= '1';

          -- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if r_Clk_Count < g_CLKS_PER_BIT-1 then
            r_Clk_Count <= r_Clk_Count + 1;
            r_SM_Main   <= s_TX_Stop_Bit;
          else
            r_TX_Done   <= '1';
            r_Clk_Count <= 0;
            r_SM_Main   <= s_Cleanup;
          end if;

        -- Stay here 1 clock
        when s_Cleanup =>
          o_TX_Active <= '0';
          r_TX_Done   <= '1';
          r_SM_Main   <= s_Idle;

        when others =>
          r_SM_Main <= s_Idle;

      end case;
    end if;
  end process p_UART_TX;

  o_TX_Done <= r_TX_Done;

end RTL;
```

### Transmitter Documentation

#### s_Idle state

The state machine starts out in s_Idle state where it sets the TX line to high
as defined by the UART definition.

The user will provide the symbol to transmit at the i_TX_Byte input port.
The user will then set the input port i_TX_DV to one, the transmitter copies
i_TX_Byte to r_TX_Byte and transitions to the s_TX_Start_Bit state.

#### s_TX_Start_Bit

The start bit is send. The start bit is a constant low value on the TX line.
When g_CLKS_PER_BIT ticks have passed, the state machine transitions to the
s_TX_Data_Bits state.

#### s_TX_Data_Bits

The r_Bit_Index is used to iterate through all eight data bits. They
are placed on the tx line for g_CLKS_PER_BIT ticks each.
Once all data bits have been transmitted, the state machine transitions
to s_TX_Stop_Bit state.

#### s_TX_Stop_Bit

Sets the tx line to 1 for g_CLKS_PER_BIT ticks, sets r_TX_Done to 1 and
then transitions to the s_Cleanup state.

#### s_Cleanup

The r_TX_Done signal is set to 1 again for a single clock tick and then
the state machine transitions back to the idle state.


## Receiver

First, lets compute how many times the FPGA clock will wrap around until a single
bit has been consumed:

A baud rate of 115200 means that 115200 bits are transmitted per second.
A FPGA clock of 10 MHz means the clock performs 10000000 ticks per second.
This means that the clock performs 87 ticks per bit at a baudrate of 115200.

The constant should be called "clock ticks per bit" but it is called
"clocks per bit". It is storing the clock ticks to wait until an entiry
bit at the target baudrate has been transmitted.

```
-- Set Generic g_CLKS_PER_BIT as follows:
-- g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
-- Example: 10 MHz Clock, 115200 baud UART
-- (10000000)/(115200) = 87
```

This means a 10 MHz clock will count to 10000000 87 times during a single
bit transmission.

### Task of a Receiver module

Remember, UART is a character/symbol oriented system.
This means that it defines the transmission of a single character/symbol.

The transmission format of a symbol is defined as 8N1 for example
8 - eight bits of data per symbol (could also be 5, 6, or 7)
N - no parity bit
1 - a single stop bit.

Larger messages that consist of several symbols are not defined in the
UART system. The UART system has no notion of larger messages than individual
symbols. To tranmit larger messages, send several individual symbols in the
correct order.

Now, that the nature of the UART system is clearly defined (separate individual
symbols are transmitted) the task of the receiver can also be clearly stated.
The task of the receiver is it to receive a single symbol and nothing more
than that.

The receiver module is defined as:

```
entity UART_RX is
  generic (
    g_CLKS_PER_BIT : integer := 115     -- Needs to be set correctly
    );
  port (
    i_Clk       : in  std_logic;
    i_RX_Serial : in  std_logic;
    o_RX_DV     : out std_logic;
    o_RX_Byte   : out std_logic_vector(7 downto 0)
    );
end UART_RX;
```

i_Clk is the input for the FPGA clock (10 MHz in the example above).

i_RX_Serial is the input wire connected to the RX line of the UART.

o_RX_DV is ???. Might be data valid signal for the consumer to know when a symbol
has been received.

o_RX_Byte is the sampled symbol (Here the symbols consists of 8 bits (7 downto 0)
this means that it might be a 8N1 format for example).

### Receiver Implementation

The implementation is:

```
architecture rtl of UART_RX is

  type t_SM_Main is (s_Idle, s_RX_Start_Bit, s_RX_Data_Bits,
                     s_RX_Stop_Bit, s_Cleanup);
  signal r_SM_Main : t_SM_Main := s_Idle;

  signal r_RX_Data_R : std_logic := '0';
  signal r_RX_Data   : std_logic := '0';

  signal r_Clk_Count : integer range 0 to g_CLKS_PER_BIT-1 := 0;
  signal r_Bit_Index : integer range 0 to 7 := 0;  -- 8 Bits Total
  signal r_RX_Byte   : std_logic_vector(7 downto 0) := (others => '0');
  signal r_RX_DV     : std_logic := '0';

begin

  -- Purpose: Double-register the incoming data.
  -- This allows it to be used in the UART RX Clock Domain.
  -- (It removes problems caused by metastabiliy)
  p_SAMPLE : process (i_Clk)
  begin
    if rising_edge(i_Clk) then
      r_RX_Data_R <= i_RX_Serial;
      r_RX_Data   <= r_RX_Data_R;
    end if;
  end process p_SAMPLE;

  -- Purpose: Control RX state machine
  p_UART_RX : process (i_Clk)
  begin
    if rising_edge(i_Clk) then

      case r_SM_Main is

	    -- idle state before start bit
        when s_Idle =>
          r_RX_DV     <= '0';
          r_Clk_Count <= 0;
          r_Bit_Index <= 0;

			-- Start bit detection
          if r_RX_Data = '0' then
            r_SM_Main <= s_RX_Start_Bit;
          else
            r_SM_Main <= s_Idle;
          end if;

        -- Check middle of start bit to make sure it's still low
        when s_RX_Start_Bit =>
          if r_Clk_Count = (g_CLKS_PER_BIT-1)/2 then
            if r_RX_Data = '0' then
              r_Clk_Count <= 0;  -- reset counter since we found the middle
              r_SM_Main   <= s_RX_Data_Bits;
            else
              r_SM_Main   <= s_Idle;
            end if;
          else
            r_Clk_Count <= r_Clk_Count + 1;
            r_SM_Main   <= s_RX_Start_Bit;
          end if;

        -- Wait g_CLKS_PER_BIT-1 clock cycles to sample serial data
        when s_RX_Data_Bits =>
          if r_Clk_Count < g_CLKS_PER_BIT-1 then
            r_Clk_Count <= r_Clk_Count + 1;
            r_SM_Main   <= s_RX_Data_Bits;
          else
            r_Clk_Count            <= 0;
            r_RX_Byte(r_Bit_Index) <= r_RX_Data;

            -- Check if we have received all data bits
            if r_Bit_Index < 7 then
              r_Bit_Index <= r_Bit_Index + 1;
              r_SM_Main   <= s_RX_Data_Bits;
            else
              r_Bit_Index <= 0;
              r_SM_Main   <= s_RX_Stop_Bit;
            end if;
          end if;

        -- Receive Stop bit. Stop bit = 1
        when s_RX_Stop_Bit =>
          -- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if r_Clk_Count < g_CLKS_PER_BIT-1 then
            r_Clk_Count <= r_Clk_Count + 1;
            r_SM_Main   <= s_RX_Stop_Bit;
          else
            r_RX_DV     <= '1';
            r_Clk_Count <= 0;
            r_SM_Main   <= s_Cleanup;
          end if;

        -- Stay here 1 clock
        when s_Cleanup =>
          r_SM_Main <= s_Idle;
          r_RX_DV   <= '0';

		-- catch all default case
		when others =>
          r_SM_Main <= s_Idle;

      end case;
    end if;
  end process p_UART_RX;

  o_RX_DV   <= r_RX_DV;
  o_RX_Byte <= r_RX_Byte;

end rtl;
```

The current state of the state machine is stored inside the variable r_SM_Main.

The states are
- s_Idle         - while no data is transmitted
- s_RX_Start_Bit - the start bit is detected
- s_RX_Data_Bits - the data bits are detected
- s_RX_Stop_Bit  - the stop bit is detected
- s_Cleanup      - data valid signal is reset to 0, state is reset to s_Idle

#### s_Idle

The state machine starts in s_Idle state and remains in that state as long
as the rx line is high.

The variable r_Clk_Count is constantly reset to 0 to correctly start clock
counting from value 0.

When the stop bit starts, the line goes low which
is detected inside the idle state:

```
if r_RX_Data = '0' then       -- Start bit detected
	r_SM_Main <= s_RX_Start_Bit;
else
	r_SM_Main <= s_Idle;
end if;
```

The state is then changed to s_RX_Start_Bit because the start bit started.

#### s_RX_Start_Bit

In the s_RX_Start_Bit state, the receiver waits for half a bit time by
comparing the clock count with g_CLKS_PER_BIT / 2.

```
if r_Clk_Count = (g_CLKS_PER_BIT-1)/2 then
```

In the middle of the start bit, the RX line is sampled. If a 0 value is
sampled, the state machine transitions to the s_RX_Data_Bits state and also
reset the r_Clk_Count variable.

```
if r_RX_Data = '0' then
  r_Clk_Count <= 0;  -- reset counter since we found the middle
  r_SM_Main   <= s_RX_Data_Bits;
```

#### s_RX_Data_Bits

During the s_RX_Data_Bits state, there is an index r_Bit_Index which is incremented
through the data bits (8N1 has eight data bits with indexes 0 through 7).

The s_RX_Data_Bits waits for g_CLKS_PER_BIT ticks. Whenever g_CLKS_PER_BIT is
reached, r_Clk_Count is reset to zero and the index r_Bit_Index is incremented.
Also the signal value is sampled and stored in the r_RX_Byte variable:

```
r_RX_Byte(r_Bit_Index) <= r_RX_Data;
```

The purpose of the temp variable r_RX_Byte is to be eventually assigned
to the output port o_RX_Byte after an entire symbol has been received
by the RX state machine.

Once the bit index reaches the value 7 and all eight bits have been sample,
r_Bit_Index is reset to the value 0 and the state is changed to s_RX_Stop_Bit.
Also the r_Clk_Count variale is reset to 0.

#### s_RX_Stop_Bit

In the s_RX_Stop_Bit state, the task is to sample the stop bit.
Therefore the state machine remain in the s_RX_Stop_Bit until the clock
r_Clk_Count is incremented to another g_CLKS_PER_BIT bits.

Then the transmission is right in the center of the stop bit.
The stop bit value is sampled and stored nowhere.

r_RX_DV is set to 1. The purpose of r_RX_DV is to be copied to
o_RX_DV eventually. r_Clk_Count is reset to 0 and the state machine
transitions to the s_Cleanup state.

#### s_Cleanup

s_Cleanup is only entered for a single clock tick.
r_RX_DV is reset and the state machine transitions back into the Idle state.

# Final Thoughts

My critique is that the overampling of eight times is not performed at all.
The signal is only sampled once.

# Processing the Received Symbol

The question is what to do with the received symbol.
For now, lets echo that symbol back.