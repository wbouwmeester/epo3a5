library IEEE;
use IEEE.std_logic_1164.ALL;

entity calculator is
   port(XI	 :in    std_logic;
	XO	 :inout std_logic;
        top_reset:in    std_logic;
        top_sclk :in    std_logic;
        top_mosi :in    std_logic;
        top_ss   :in    std_logic;
        top_out  :out   std_logic_vector(7 downto 0));
end calculator;

architecture behaviour of calculator is

--components--

component osc10 
   PORT(E: IN STD_LOGIC;
        F: OUT STD_LOGIC;
        XI: IN STD_LOGIC;
        XO: INOUT STD_LOGIC := 'Z');
END component;

component cpu 
port(	cpu_rst	:	in	std_logic;
	cpu_en	:	in	std_logic;
	cpu_in	:	in	std_logic_vector(7 downto 0);
	cpu_instr:		in	std_logic_vector(11 downto 0);
	cpu_pc	:	out	std_logic_vector(7 downto 0);
	cpu_out	:	out	std_logic_vector(7 downto 0));
end component;

component gate
port(		input : in std_logic;
			output : out std_logic;
			sw	: in std_logic
		);
end component;

component rom
port(
    rom_a:    in std_logic_vector (7 DOWNTO 0);     -- address
    rom_d:    out std_logic_vector (11 DOWNTO 0)    -- instruction
);
end component;

component shift_reg
port(	clk: 		in std_logic;
	reset:	 	in std_logic;
	shift_in:		in std_logic;
	output: 		out std_logic_vector (7 downto 0)
	);
end component;

--Signals--

signal cpu_enable : std_logic;
signal cpu_input 	: std_logic_vector(7 downto 0);
signal cpu_instr	 : std_logic_vector(11 downto 0);
signal cpu_addr		 : std_logic_vector(7 downto 0);
signal osc_clk		: std_logic_vector;

--Portmaps

begin

lbl_osc:		osc10 port map(
		E		=>	'1',
		F		=>	osc_clk,
		XI		=>	XI,
		XO		=> 	XO);



lbl_cpu:		cpu port map(
		cpu_rst		=> 	top_reset,
		cpu_en		=>	cpu_enable,
		cpu_in		=> 	cpu_input,
		cpu_instr		=>	cpu_instr,
		cpu_pc		=>	cpu_addr,
		cpu_out		=>	top_out);

lbl_gate:		gate port map(
		input 		=>	osc_clk,
		output		=>	cpu_enable,
		sw		=>	top_ss);

lbl_rom:		rom port map(
		rom_a		=>	cpu_addr,
    		rom_d		=>	cpu_instr);

lbl_shift:		shift_reg port map(
		clk		=>	top_sclk,
		reset		=>	top_reset,
		shift_in		=>	top_mosi,
		output		=>	cpu_input);

end behaviour;




