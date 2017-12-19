-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ReceiveTest IS
END ReceiveTest;

ARCHITECTURE behavior OF ReceiveTest IS 
	component receiver is
		Generic ( width: integer );
		port ( enable : in  STD_LOGIC;
				 clock : in  STD_LOGIC;
				 serial_input : in  STD_LOGIC;
				 busy : out  STD_LOGIC;
				 done_interrupt : out  STD_LOGIC;
				 value : out  STD_LOGIC_VECTOR (width - 1 downto 0));
	end component receiver;
	component freq_gen is
		generic( frequency: integer );
		port ( clock: out STD_LOGIC ); 
	end component freq_gen;
	
	signal enable : STD_LOGIC;
	signal clock : STD_LOGIC;
	signal serial_input : STD_LOGIC;
	signal busy : STD_LOGIC;
	signal done_interrupt : STD_LOGIC;
	constant bit_size : integer := 8;
	signal value : STD_LOGIC_VECTOR (bit_size - 1 downto 0);
	constant sendind_value : STD_LOGIC_VECTOR := "10010110";
	constant frequency : integer := 9600;
	constant clock_dt : time := 1000ms / frequency;
BEGIN
	gen: freq_gen
		generic map ( frequency => frequency )
		port map ( clock => clock );
	rec: receiver
		generic map ( width => bit_size )
		port map (
			enable => enable,
			clock => clock,
			serial_input => serial_input,
			busy => busy,
			done_interrupt => done_interrupt,
			value => value
		);
	main: process begin
		wait for clock_dt/2;
		enable <= '1';
		wait for clock_dt;
		serial_input <= '0';
		enable <= '0';
		for i in 0 to bit_size - 1 loop
			wait for clock_dt;
			serial_input <= sendind_value(i);
		end loop;
		wait for clock_dt;
		serial_input <= '1';
		wait for clock_dt * 10.5;
	end process main; 
END;
