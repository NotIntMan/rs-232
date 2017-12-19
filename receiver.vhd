----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:02:16 11/30/2017 
-- Design Name: 
-- Module Name:    receiver - Behavioral 
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

entity receiver is
	Generic ( width: integer  );
   port ( enable : in  STD_LOGIC;
          clock : in  STD_LOGIC;
          serial_input : in  STD_LOGIC;
          busy : out  STD_LOGIC;
          done_interrupt : out  STD_LOGIC;
          value : out  STD_LOGIC_VECTOR (width - 1 downto 0));
end receiver;

architecture Behavioral of receiver is
	signal enabled : STD_LOGIC;
	signal buff_value : STD_LOGIC_VECTOR (width + 1 downto 0);
begin
	main: process(clock) begin
		if rising_edge(clock) then
			if enabled = '1' then
				-- Shift and receive process
				buff_value(width + 1 downto 1) <= buff_value(width downto 0);
				buff_value(0) <= serial_input;
				-- Check for completion
				if (buff_value(0) = '1') and (buff_value(width + 1) = '0') then
					-- Intterruption "Done" signal into output
					value <= buff_value(width downto 1);
					enabled <= '0';
					done_interrupt <= '1';
				end if;
			else
				-- Enable process
				if enable = '1' then
					enabled <= '1';
					buff_value <= (others => '1');
					done_interrupt <= '0';
				end if;
			end if;
		end if;
	end process main;
	busy <= enabled;
end Behavioral;
