----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:54:43 10/10/2017 
-- Design Name: 
-- Module Name:    multiplex_reg - Behavioral 
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

entity multiplex_reg is
	 Generic ( width: integer := 8 );
    Port ( enable : in  STD_LOGIC;
           choose : in  STD_LOGIC;
           first : in  STD_LOGIC_VECTOR (width - 1 downto 0);
           second : in  STD_LOGIC_VECTOR (width - 1 downto 0);
           output : out  STD_LOGIC_VECTOR (width - 1 downto 0));
end multiplex_reg;

architecture Behavioral of multiplex_reg is
begin
	change: process(enable) begin
		i: if rising_edge(enable) then
			j: if choose = '0' then
				output <= first;
			else
				output <= second;
			end if j;
		end if i;
	end process change;
end Behavioral;

