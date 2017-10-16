----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:51:16 10/04/2017 
-- Design Name: 
-- Module Name:    freq_gen - Functional 
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

entity freq_gen is
	generic( frequency: integer := 5E7 );
	port ( clock: out STD_LOGIC );
end freq_gen;

architecture Functional of freq_gen is
constant dt: time := 500ms / frequency;
begin
	z: process begin
		x: while true loop
			clock <= '0';
			wait for dt;
			clock <= '1';
			wait for dt;
		end loop x;
	end process z;
end Functional;

