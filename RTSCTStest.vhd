--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:40:50 11/20/2017
-- Design Name:   
-- Module Name:   D:/vhdl/tx-project/RTSCTStest.vhd
-- Project Name:  tx-project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: txtrigger
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
 
ENTITY RTSCTStest IS
END RTSCTStest;
 
ARCHITECTURE behavior OF RTSCTStest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT txtrigger
    PORT(
         enable : IN  std_logic;
         disable : IN  std_logic;
         clear_to_send : IN  std_logic;
			clock : in STD_LOGIC;
         ready_to_send : OUT  std_logic;
         send_enable : OUT  std_logic
        );
    END COMPONENT;
	 
    COMPONENT rxtrigger
    Port ( ready_to_send : in  STD_LOGIC;
           busy : in  STD_LOGIC;
			  unlock: in STD_LOGIC;
			  clock: in STD_LOGIC;
           clear_to_send : out  STD_LOGIC);
    END COMPONENT;
	 
	component freq_gen is
		generic( frequency: integer );
		port ( clock: out STD_LOGIC ); 
	end component freq_gen;


   --Inputs
   signal enable : std_logic := '0';
   signal disable : std_logic := '0';
   signal clear_to_send : std_logic := '0';
   signal ready_to_send : std_logic;
   signal send_enable : std_logic;
	signal busy : std_logic := '0';
	signal unlock : std_logic := '0';
	signal clock: std_logic := '0';
	constant dt: time := 1000ms / 9600;
BEGIN
	gen : freq_gen
		GENERIC MAP ( frequency => 9600 )
		PORT MAP ( clock => clock );
   txt: txtrigger PORT MAP (
			enable => enable,
			disable => disable,
			clock => clock,
			clear_to_send => clear_to_send,
			ready_to_send => ready_to_send,
			send_enable => send_enable
		);
	rxt: rxtrigger PORT MAP (
			ready_to_send => ready_to_send,
			busy => busy,
			unlock => unlock,
			clock => clock,
			clear_to_send => clear_to_send
		);
		
	main: process begin
		wait for dt*3/2;
		enable <= '1';
		wait for dt;
		enable <= '0';
		wait for dt;
		disable <= '1';
		if (clear_to_send = '1') then
			busy <= '1';
		end if;
		wait for dt;
		disable <= '0';
		wait for dt;
		busy <= '0';
		wait for dt;
		enable <= '1';
		wait for dt;
		enable <= '0';
		wait for dt;
		unlock <= '1';
		wait;
	end process main;
END;
