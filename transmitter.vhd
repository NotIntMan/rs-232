----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:26:24 10/16/2017 
-- Design Name: 
-- Module Name:    transmitter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity transmitter is
	Generic ( width: integer := 8 );
	Port ( enable : in  STD_LOGIC;
		clock : in  STD_LOGIC;
		input : in  STD_LOGIC_VECTOR (width - 1 downto 0);
		busy : out  STD_LOGIC;
		serial_output : out  STD_LOGIC);
end transmitter;

architecture Behavioral of transmitter is
	function logick_or(v: STD_LOGIC; def: STD_LOGIC) return STD_LOGIC is
	begin
		case v is
			when '0' =>
				return v;
			when '1' =>
				return v;
			when others =>
				return def;
		end case;
	end function;
	component reg is
		generic ( width: integer := width );
		port ( enable : in  STD_LOGIC;
				 new_value : in  STD_LOGIC_VECTOR (width - 1 downto 0);
				 value : out  STD_LOGIC_VECTOR (width - 1 downto 0));
	end component reg;
	component shift_reg is
		 generic ( width: integer := width );
		 Port ( enable : in  STD_LOGIC;
				  clock : in  STD_LOGIC;
				  init_value : in  STD_LOGIC_VECTOR (width - 1 downto 0);
				  busy : out  STD_LOGIC;
				  serial_signal : out  STD_LOGIC);
	end component shift_reg;
	component busy_trigger is
		Port ( enable : in  STD_LOGIC;
			sender_busy : in  STD_LOGIC;
			sender_enable: out STD_LOGIC;
			busy : out  STD_LOGIC);
	end component busy_trigger;
	signal buffered_enable: STD_LOGIC;
	signal buffered_busy: STD_LOGIC;
	signal buffered_value: STD_LOGIC_VECTOR (width - 1 downto 0);
	signal buffered_output: STD_LOGIC;
begin
	input_reg: reg
		generic map (width => width)
		port map (
			enable => buffered_enable,
			new_value => input,
			value => buffered_value
		);
	transmit_reg: shift_reg
		generic map (width => width)
		port map (
			enable => buffered_enable,
			clock => clock,
			init_value => buffered_value,
			busy => buffered_busy,
			serial_signal => buffered_output
		);
	busy_trig: busy_trigger
		port map (
			enable => enable,
			sender_busy => buffered_busy,
			sender_enable => buffered_enable,
			busy => busy
		);
	serial_output <= logick_or(buffered_output, '1');
end Behavioral;

