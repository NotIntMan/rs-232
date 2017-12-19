----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:58:35 12/11/2017 
-- Design Name: 
-- Module Name:    rs232tx - Behavioral 
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

entity rs232tx is
	Port ( enable : in  STD_LOGIC; --Подается изнутри
		value : in  STD_LOGIC_VECTOR (7 downto 0); --Подается изнутри
		clear_to_send : in  STD_LOGIC; --Подается на передачу
		clock : in  STD_LOGIC; --Тактовый сигнал
		busy : out  STD_LOGIC; --Подается внутрь
		ready_to_send : out  STD_LOGIC; --Подается на передачу
		serial_output : out  STD_LOGIC); --Подается на передачу
end rs232tx;

architecture Behavioral of rs232tx is
	component txtrigger is
		 Port ( enable : in  STD_LOGIC;
				  disable : in  STD_LOGIC;
				  clear_to_send : in  STD_LOGIC;
				  clock : in STD_LOGIC;
				  ready_to_send : out  STD_LOGIC;
				  send_enable : out  STD_LOGIC);
	end component txtrigger;
	component shift_reg is
		 generic ( width: integer := 8 );
		 Port ( enable : in  STD_LOGIC;
				  clock : in  STD_LOGIC;
				  init_value : in  STD_LOGIC_VECTOR (width - 1 downto 0);
				  busy : out  STD_LOGIC;
				  serial_signal : out  STD_LOGIC);
	end component shift_reg;
	function l2b(logic: STD_LOGIC) return boolean is
	begin
		if logic = '1' then
			return true;
		else
			return false;
		end if;
	end;
	signal send_enable : STD_LOGIC := '0';
	signal disable : STD_LOGIC := '0';
	signal buf_busy : STD_LOGIC := '0';
begin
	trig: txtrigger
		port map (
			enable => enable,
			disable => disable,
			clear_to_send => clear_to_send,
			clock => clock,
			ready_to_send => ready_to_send,
			send_enable => send_enable
		);
	transmitter: shift_reg
		generic map ( width => 8 )
		port map (
			enable => send_enable,
			clock => clock,
			init_value => value,
			busy => buf_busy,
			serial_signal => serial_output
		);
	busy <= buf_busy;
	main: process(clock) begin
		if rising_edge(clock) then
			if l2b(disable) then
				disable <= '0';
			else
				if l2b(buf_busy) then
					disable <= '1';
				end if;
			end if;
		end if;
	end process main;
end Behavioral;
