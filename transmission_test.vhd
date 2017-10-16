-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY transmisssion_test IS
END transmisssion_test;

ARCHITECTURE behavior OF transmisssion_test IS 
	component transmitter is
		Generic ( width: integer := 8 );
		Port ( enable : in  STD_LOGIC;
			clock : in  STD_LOGIC;
			input : in  STD_LOGIC_VECTOR (width - 1 downto 0);
			busy : out  STD_LOGIC;
			serial_output : out  STD_LOGIC);
	end component transmitter;
	component freq_gen is
		generic( frequency: integer := 5E7 );
		port ( clock: out STD_LOGIC );
	end component freq_gen;
	
	signal enable: STD_LOGIC := '0';
	signal clock: STD_LOGIC := '0';
	constant width: integer := 8;
	signal input: STD_LOGIC_VECTOR (width - 1 downto 0) := (others => '0');
	signal busy: STD_LOGIC := '0';
	signal serial_output: STD_LOGIC := '0';
	constant freq: integer := 9600;
	constant dt: time := 500ms / freq;
BEGIN
	gen: freq_gen
		generic map ( frequency => freq)
		port map (clock => clock);
	tr: transmitter
		port map (
			enable => enable,
			clock => clock,
			input => input,
			busy => busy,
			serial_output => serial_output
		);
	process begin
		wait for dt;
		input <= "10101010";
		wait for 2*dt;
		enable <= '1';
		wait for dt;
		enable <= '0';
		wait for 28*dt;
		enable <= '1';
		wait for dt;
		enable <= '0';
		wait for dt;
		input <= "10010110";
		enable <= '1';
		wait for dt;
		enable <= '0';
		wait;
	end process;
END;
