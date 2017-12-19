----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:51 11/20/2017 
-- Design Name: 
-- Module Name:    rxtrigger - Behavioral 
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

entity rxtrigger is
    Port ( ready_to_send : in  STD_LOGIC;
           busy : in  STD_LOGIC;
			  unlock: in STD_LOGIC;
			  clock: in STD_LOGIC;
           clear_to_send : out  STD_LOGIC);
end rxtrigger;

architecture Behavioral of rxtrigger is
	function l2b(logic: STD_LOGIC) return boolean is
	begin
		if logic = '1' then
			return true;
		else
			return false;
		end if;
	end;
	signal blocked: STD_LOGIC;
begin
	main: process(clock) begin
		if rising_edge(clock) then
			if l2b(blocked) then
				if l2b(unlock) then
					blocked <= '0';
				end if;
			else
				if (l2b(ready_to_send) and (not l2b(busy))) then
					clear_to_send <= '1';
				end if;
				if l2b(busy) then
					clear_to_send <= '0';
					blocked <= '1';
				end if;
			end if;
		end if;
	end process main;
end Behavioral;
