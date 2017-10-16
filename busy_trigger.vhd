----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:11:09 10/10/2017 
-- Design Name: 
-- Module Name:    busy_trigger - Behavioral 
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

entity busy_trigger is
	Port ( enable : in  STD_LOGIC;
		sender_busy : in  STD_LOGIC;
		sender_enable: out STD_LOGIC;
		busy : out  STD_LOGIC);
end busy_trigger;

architecture Behavioral of busy_trigger is
	function logickify(s: std_logic) return std_logic is
	begin
		if s = '1' then
			return '1';
		else
			return '0';
		end if;
	end;
	function signalify(s: boolean) return std_logic is
	begin
		if s then
			return '1';
		else
			return '0';
		end if;
	end;
	signal need_when_av: boolean := false;
begin
	xchange: process (enable, sender_busy) begin
		if need_when_av then
			sender_enable <= enable or (not logickify(sender_busy));
			if rising_edge(sender_busy) then
				need_when_av <= false;
			end if;
		else 
			sender_enable <= enable;
			if rising_edge(enable) then
				need_when_av <= true;
			end if;
		end if;
	end process xchange;
	busy <= sender_busy or signalify(need_when_av);
end Behavioral;
