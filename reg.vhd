----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:54:01 10/04/2017 
-- Design Name: 
-- Module Name:    register - Behavioral 
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

entity reg is
	generic ( width: integer := 8 );
   port ( enable : in  STD_LOGIC;
          new_value : in  STD_LOGIC_VECTOR (width - 1 downto 0);
          value : out  STD_LOGIC_VECTOR (width - 1 downto 0));
end reg;

architecture Behavioral of reg is
begin
	change: process(enable) begin
		if rising_edge(enable) then
			value <= new_value;
		end if;
	end process change;
end Behavioral;

