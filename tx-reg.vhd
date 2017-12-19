----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:59 11/20/2017 
-- Design Name: 
-- Module Name:    tx-trigger - Behavioral 
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

entity txtrigger is
    Port ( enable : in  STD_LOGIC;
			  disable : in  STD_LOGIC;
           clear_to_send : in  STD_LOGIC;
           ready_to_send : out  STD_LOGIC;
           send_enable : out  STD_LOGIC);
end txtrigger;

architecture Behavioral of txtrigger is
signal enabled: STD_LOGIC;
begin
	main: process(enable, disable, clear_to_send) begin
		if (rising_edge(enable) and not(enabled = '1')) then
			enabled <= '1';
			ready_to_send <= '1';
			send_enable <= '0';
		end if;
		if (rising_edge(disable) and (enabled = '1')) then
			enabled <= '0';
			ready_to_send <= '0';
			send_enable <= '0';
		end if;
		if (rising_edge(clear_to_send) and (enabled = '1')) then
			ready_to_send <= '0';
			send_enable <= '1';
		end if;
	end process main;
end Behavioral;
