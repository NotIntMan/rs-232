----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:46 10/04/2017 
-- Design Name: 
-- Module Name:    freq_div - Behavioral 
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

entity freq_div is
	generic( frequency_in: integer := 5E7;
				frequency_out: integer := 9600);
   port ( clock_in : in  STD_LOGIC;
          clock_out : out  STD_LOGIC);
end freq_div;

architecture Behavioral of freq_div is
constant rel: integer := frequency_in / frequency_out;

function bool2logic(input: in boolean) return STD_LOGIC is
begin
	if (input) then
		return '1';
	else
		return '0';
	end if;
end;

signal ticks: integer := 0;
signal state: boolean := false;
begin
	z: process (clock_in)
	begin
		ticks <= ticks + 1;
		if (ticks > rel) then
			ticks <= 0;
			state <= not(state);
			clock_out <= bool2logic(state);
		end if;
	end process z;
end Behavioral;
