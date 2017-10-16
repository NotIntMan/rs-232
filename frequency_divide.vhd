--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:47:11 10/04/2017
-- Design Name:   
-- Module Name:   D:/vhdl/tx-project/frequency_divide.vhd
-- Project Name:  tx-project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: freq_div
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
 
ENTITY frequency_divide IS
END frequency_divide;
 
ARCHITECTURE behavior OF frequency_divide IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT freq_gen
	 generic( frequency: integer := 5E7 );
    port(
         clock: out STD_LOGIC
        );
    END COMPONENT;
    

    COMPONENT freq_div
	 generic( frequency_in: integer := 5E7;
				frequency_out: integer := 9600);
    port(
         clock_in : IN  std_logic;
         clock_out : OUT  std_logic
        );
    END COMPONENT;

   --Inputs
   signal clock_in : std_logic := '0';

 	--Outputs
   signal clock_out : std_logic;

BEGIN
	fg: freq_gen PORT MAP (
			clock => clock_in
		);
   fd: freq_div PORT MAP (
			clock_in => clock_in,
			clock_out => clock_out
		);
	
END;
