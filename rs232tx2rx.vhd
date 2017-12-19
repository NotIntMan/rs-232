--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:52:23 12/11/2017
-- Design Name:   
-- Module Name:   D:/vhdl/tx-project/rs232tx2rx.vhd
-- Project Name:  tx-project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: freq_gen
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
 
ENTITY rs232tx2rx IS
END rs232tx2rx; 

ARCHITECTURE behavior OF rs232tx2rx IS 
	component freq_gen
		generic( frequency: integer := 5E7 );
		port ( clock : out std_logic );
	end component;
	component rs232tx is
		Port ( enable : in  STD_LOGIC; --Подается изнутри
			value : in  STD_LOGIC_VECTOR (7 downto 0); --Подается изнутри
			clear_to_send : in  STD_LOGIC; --Подается на передачу
			clock : in  STD_LOGIC; --Тактовый сигнал
			busy : out  STD_LOGIC; --Подается внутрь
			ready_to_send : out  STD_LOGIC; --Подается на передачу
			serial_output : out  STD_LOGIC); --Подается на передачу
	end component rs232tx;
	component rs232rx is
		Port ( unlock : in  STD_LOGIC; --Подается изнутри
			ready_to_send : in  STD_LOGIC; --Подается с передачи
			serial_input : in  STD_LOGIC; --Подается с передачи
			clock : in  STD_LOGIC; --Тактовый сигнал
			clear_to_send : out  STD_LOGIC; --Подается на передачу
			done_interrupt : out  STD_LOGIC; --Подается внутрь
			value : out  STD_LOGIC_VECTOR (7 downto 0)); --Подается внутрь
	end component rs232rx;

   signal clock : STD_LOGIC;
	signal clear_to_send : STD_LOGIC := '0';
	signal ready_to_send : STD_LOGIC := '0';
	signal serial_signal : STD_LOGIC := '0';
	
	signal transmit_enable : STD_LOGIC := '0';
	signal transmit_value : STD_LOGIC_VECTOR (7 downto 0) := "01101001";
	signal transmit_busy : STD_LOGIC := '0';	
	
	signal receive_unlock : STD_LOGIC := '0';
	signal receive_done_interrupt : STD_LOGIC := '0';
	signal receive_value : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

   constant frequency : integer := 9600;
	constant dt : time := 1000ms / frequency;
 
BEGIN
   generator: freq_gen
		generic map ( frequency => frequency )
		port map ( clock => clock );
	transmitter: rs232tx
		port map (
			enable => transmit_enable,
			value => transmit_value,
			clear_to_send => clear_to_send,
			clock => clock,
			busy => transmit_busy,
			ready_to_send => ready_to_send,
			serial_output => serial_signal
		);
	receiver: rs232rx
		port map (
			unlock => receive_unlock,
			ready_to_send => ready_to_send,
			serial_input => serial_signal,
			clock => clock,
			clear_to_send => clear_to_send,
			done_interrupt => receive_done_interrupt,
			value => receive_value
		);
	main: process begin
		wait for dt/2;
		transmit_enable <= '1';
		wait for dt;
		transmit_enable <= '0';
		wait for 16*dt;
		transmit_value <= "10100101";
		wait for dt;
		transmit_enable <= '1';
		wait for dt;
		transmit_enable <= '0';
		wait for 2*dt;
		receive_unlock <= '1';
		wait for dt;
		receive_unlock <= '0';
		wait;
	end process main;
END;
