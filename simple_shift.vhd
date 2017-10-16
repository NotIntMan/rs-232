--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:22:49 10/10/2017
-- Design Name:   
-- Module Name:   D:/vhdl/tx-project/simple_shift.vhd
-- Project Name:  tx-project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shift_reg
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
 
ENTITY simple_shift IS
END simple_shift;
 
ARCHITECTURE behavior OF simple_shift IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shift_reg
    PORT(
         enable : IN  std_logic;
         clock : IN  std_logic;
         init_value : IN  std_logic_vector(7 downto 0);
         busy : OUT  std_logic;
         serial_signal : OUT  std_logic
        );
    END COMPONENT;
	 COMPONENT freq_gen is
			generic( frequency: integer := 5E7 );
			port ( clock: out STD_LOGIC );
	 end COMPONENT freq_gen;
    

   --Inputs
   signal enable : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal busy : std_logic;
   signal serial_signal : std_logic;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shift_reg PORT MAP (
          enable => enable,
          clock => clock,
          init_value => "10011001",
          busy => busy,
          serial_signal => serial_signal
        );
	gen: freq_gen
		generic map ( frequency => 9600 )
		port map ( clock => clock );
	main: process begin
		wait for 2ms;
		enable <= '1';
		wait for 100us;
		enable <= '0';
		wait;
	end process main;
END;
