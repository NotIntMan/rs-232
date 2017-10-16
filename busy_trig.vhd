--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:29:39 10/10/2017
-- Design Name:   
-- Module Name:   D:/vhdl/tx-project/busy_trig.vhd
-- Project Name:  tx-project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: busy_trigger
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
 
ENTITY busy_trig IS
END busy_trig;
 
ARCHITECTURE behavior OF busy_trig IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT busy_trigger
    PORT(
         enable : IN  std_logic;
         sender_busy : IN  std_logic;
         sender_enable : OUT  std_logic;
         busy : OUT  std_logic
        );
    END COMPONENT;
	 
	 component freq_gen is
			generic( frequency: integer := 9600 );
			port ( clock: out STD_LOGIC );
		end component freq_gen;
    

   --Inputs
   signal enable : std_logic := '0';
   signal sender_busy : std_logic := '0';

 	--Outputs
   signal sender_enable : std_logic;
   signal busy : std_logic;
	
	constant dt: time := 50us;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: busy_trigger PORT MAP (
          enable => enable,
          sender_busy => sender_busy,
          sender_enable => sender_enable,
          busy => busy
        );
	process begin
		wait for dt;
		sender_busy <= '0';
		enable <= '1';
		wait for dt;
		if sender_enable = '1' then
			sender_busy <= '1';
		end if;
		wait for dt;
		enable <= '0';
		wait for dt;
		enable <= '1';
		wait for dt;
		enable <= '0';
		wait for dt;
		sender_busy <= '0';
		wait for dt;
		if sender_enable = '1' then
			sender_busy <= '1';
		end if;
		wait for dt;
		sender_busy <= '0';
		wait;
	end process;
END;
