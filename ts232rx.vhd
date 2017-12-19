----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:44:26 12/11/2017 
-- Design Name: 
-- Module Name:    ts232rx - Behavioral 
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

entity rs232rx is
	Port ( unlock : in  STD_LOGIC; --Подается изнутри
		ready_to_send : in  STD_LOGIC; --Подается с передачи
		serial_input : in  STD_LOGIC; --Подается с передачи
		clock : in  STD_LOGIC; --Тактовый сигнал
		clear_to_send : out  STD_LOGIC; --Подается на передачу
		done_interrupt : out  STD_LOGIC; --Подается внутрь
		value : out STD_LOGIC_VECTOR (7 downto 0)); --Подается внутрь
end rs232rx;

architecture Behavioral of rs232rx is
	component rxtrigger is
		 Port ( ready_to_send : in  STD_LOGIC;
			busy : in  STD_LOGIC;
			unlock: in STD_LOGIC;
			clock: in STD_LOGIC;
			clear_to_send : out  STD_LOGIC);
	end component rxtrigger;
	component  receiver is
		Generic ( width: integer  );
		 port ( enable : in  STD_LOGIC;
			clock : in  STD_LOGIC;
			serial_input : in  STD_LOGIC;
			busy : out  STD_LOGIC;
			done_interrupt : out  STD_LOGIC;
			value : out  STD_LOGIC_VECTOR (width - 1 downto 0));
	end component receiver;
	signal buf_busy : STD_LOGIC := '0';
	signal buf_cts : STD_LOGIC := '0';
begin
	clear_to_send <= buf_cts;
	trig: rxtrigger
		port map (
			ready_to_send => ready_to_send,
			busy => buf_busy,
			unlock => unlock,
			clock => clock,
			clear_to_send => buf_cts
		);
	rec: receiver
		generic map ( width => 8 )
		port map (
			enable => buf_cts,
			clock => clock,
			serial_input => serial_input,
			busy => buf_busy,
			done_interrupt => done_interrupt,
			value => value
		);
end Behavioral;
