library ieee;
use ieee.std_logic_1164.all;

entity cpu_tb is
end entity cpu_tb;

architecture behaviour of cpu_tb is
component cpu
	port (	cpu_rst	:	in	std_logic;
		cpu_en	:	in	std_logic;
		cpu_in	:	in	std_logic_vector(7 downto 0);
		cpu_instr:	in	std_logic_vector(11 downto 0);
		cpu_pc	:	out	std_logic_vector(7 downto 0);
		cpu_out	:	out	std_logic_vector(7 downto 0));
end component;

signal cpu_rst	:	std_logic;
signal cpu_en	:	std_logic;
signal cpu_in	:	std_logic_vector(7 downto 0);
signal cpu_instr:	std_logic_vector(11 downto 0);
signal cpu_pc	:	std_logic_vector(7 downto 0);
signal cpu_out	:	std_logic_vector(7 downto 0);

begin
lbl1: cpu port map(cpu_rst, cpu_en, cpu_in, cpu_instr, cpu_pc, cpu_out);
cpu_en <= '1' after 0 ns,
	'0' after 10 ns when cpu_en/= '0' else '1' after 40 ns;
cpu_rst <= '1' after 0 ns,
	'0' after 50 ns;
cpu_in <= "00000000" after 0 ns,
	"00000010" after 950 ns,
	"11110000" after 1550 ns;
cpu_instr <= "000000000000" after 0 ns,
	"010100001100" after 50 ns,         -- load argument w1=12
        "011100000001" after 100 ns,        -- Store to adress R1
        "010100001100" after 150 ns,        -- load argument w2=12
        "011100000010" after 200 ns,        -- Store to adress R2
        "010100000110" after 250 ns,        -- load argument barw=6
        "011100000011" after 300 ns,        -- Store to adress R3
        "010100001100" after 350 ns,        -- load argument x=12
        "011100000100" after 400 ns,        -- Store to adress R4
        "010100010000" after 450 ns,        -- load argument y=16
        "011100000101" after 500 ns,        -- Store to adress R5
        "010100000001" after 550 ns,        -- load argument xv=1
        "011100000110" after 600 ns,        -- Store to adress R6
        "010100000001" after 650 ns,        -- load argument yv=1
        "011100000111" after 700 ns,        -- Store to adress R7
        "010111111111" after 750 ns,        -- clear screen
        "011100001010" after 800 ns,        -- Store to adress R10
	"000100010001" after 850 ns,	-- jump to hold (18)
	"111100000000" after 900 ns,	-- Clear c
	"011000000001" after 950 ns,	-- load inputvector cpu_in
	"101000001000" after 1000 ns,	-- XOR 00001000
	"100011111000" after 1050 ns,	-- ADD 11111000
	"011100000001" after 1100 ns,	-- St R1 (R1 to output)
	"010000010111" after 1150 ns,	-- bc start
	"000100010001" after 1200 ns,	-- jump to hold (18)
	"000000000000" after 1250 ns,
	"000100110011" after 1300 ns,
	"001000010001" after 1350 ns,
	"001100000010" after 1400 ns,
	"010000000011" after 1450 ns,
	"010111001100" after 1500 ns,
	"011000000110" after 1550 ns,
	"011100000001" after 1600 ns,
	"100000000001" after 1650 ns,
	"100101100011" after 1700 ns,
	"101011111111" after 1750 ns,
	"101100000011" after 1800 ns,
	"110010101010" after 1850 ns,
	"110101001001" after 1900 ns,
	"111000000000" after 1950 ns,
	"111100000000" after 2000 ns;

end architecture;
