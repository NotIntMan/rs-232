----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:34 10/10/2017 
-- Design Name: 
-- Module Name:    shift_reg - Behavioral 
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

entity shift_reg is
	 generic ( width: integer := 8 );
    Port ( enable : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           init_value : in  STD_LOGIC_VECTOR (width - 1 downto 0);
           busy : out  STD_LOGIC;
           serial_signal : out  STD_LOGIC);
end shift_reg;

architecture Behavioral of shift_reg is
	Component multiplex_reg is
	Generic ( width: integer := width );
   Port ( enable : in  STD_LOGIC;
          choose : in  STD_LOGIC;
          first : in  STD_LOGIC_VECTOR (width - 1 downto 0);
          second : in  STD_LOGIC_VECTOR (width - 1 downto 0);
          output : out  STD_LOGIC_VECTOR (width - 1 downto 0));
	end component multiplex_reg;
	function logickify(s: std_logic) return std_logic is
	begin
		if s = '1' then
			return '1';
		else
			return '0';
		end if;
	end;
	signal in_enable: STD_LOGIC;
	signal in_busy: STD_LOGIC;
	signal buff: STD_LOGIC_VECTOR (width + 1 downto 0) := (others => '0');
	signal buff0: STD_LOGIC_VECTOR (width + 1 downto 0) := (others => '0');
begin
	in_enable <= (enable or in_busy) and clock;
	val: component multiplex_reg 
		generic map (width => width + 2)
		port map(
			enable => in_enable,
			choose => in_busy,
			first(width + 1) => '0',
			first(width downto 1) => init_value,
			first(0) => '1',
			second(width + 1 downto 1) => buff(width downto 0),
			second(0) => '1',
			output => buff
		);
	bu: component multiplex_reg 
		generic map (width => width + 2)
		port map(
			enable => in_enable,
			choose => in_busy,
			first => (others => '1'),
			second(width + 1 downto 1) => buff0(width downto 0),
			second(0) => '0',
			output => buff0
		);
	serial_signal <= buff(width + 1);
	in_busy <= logickify(buff0(width + 1));
	busy <= in_busy;
end Behavioral;
