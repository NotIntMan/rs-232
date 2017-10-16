--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:43:29 10/10/2017
-- Design Name:   
-- Module Name:   D:/vhdl/tx-project/busy_shift.vhd
-- Project Name:  tx-project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: multiplex_reg
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY busy_shift IS
END busy_shift;
 
ARCHITECTURE behavior OF busy_shift IS 
	function logickify(s: std_logic) return std_logic is
	begin
		if s = '1' then
			return '1';
		else
			return '0';
		end if;
	end;
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplex_reg
	 Generic ( width: integer := 8 );
    PORT(
         enable : IN  std_logic;
         choose : IN  std_logic;
         first : IN  std_logic_vector(width - 1 downto 0);
         second : IN  std_logic_vector(width - 1 downto 0);
         output : OUT  std_logic_vector(width - 1 downto 0)
        );
    END COMPONENT;
	 component freq_gen is
			generic( frequency: integer := 9600 );
			port ( clock: out STD_LOGIC );
		end component freq_gen;
    
	constant width: integer := 10;
   --Inputs
   signal enable : std_logic := '0';
	signal in_busy : std_logic := '0';
   signal first : std_logic_vector(width - 1 downto 0) := (others => '1');
   signal second : std_logic_vector(width - 1 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(width - 1 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplex_reg 
		 GENERIC MAP (
			width => width
		 )
		 PORT MAP (
          enable => enable,
          choose => in_busy,
          first => first,
          second(width - 1 downto 1) => output(width - 2 downto 0),
			 second(0) => '0',
          output => output
        );
	gen: freq_gen
		PORT MAP (
			clock => enable
		);
	in_busy <= logickify(output(width - 1));
END;
 