library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
 port (
	Clock	:	in std_logic;
	Reset	:	in std_logic;
	SW 	: 	in std_logic_vector (3 downto 0);
	LEDR 	: 	out std_logic_vector (9 downto 0);
	HEX0 	: 	out std_logic_vector (6 downto 0);
	HEX1 	: 	out std_logic_vector (6 downto 0);
	HEX2 	: 	out std_logic_vector (6 downto 0);
	HEX3 	: 	out std_logic_vector (6 downto 0);
	HEX4 	: 	out std_logic_vector (6 downto 0);
	HEX5 	: 	out std_logic_vector (6 downto 0);
	GPIO_1: 	out std_logic_vector (7 downto 0));
end entity;

architecture top_arch of top is

 signal CNT, CNTn : std_logic_vector (37 downto 0);
 
 component char_decoder
	port (
		BIN_IN 	: in std_logic_vector (3 downto 0);
		HEX_OUT 	: out std_logic_vector (6 downto 0));
 end component;
 
 component dflipflop is
 port (
	Clock 	: in std_logic;
	Reset 	: in std_logic;
	D		 	: in std_logic;
	Q, Qn 	: out std_logic);
 end component;
 
 
 begin
 
	LEDR <= CNT(37 downto 28);
	GPIO_1 <= CNT(7 downto 0);
 
	C0 : char_decoder port map (BIN_IN => CNT(17 downto 14), HEX_OUT => HEX0);
	C1 : char_decoder port map (BIN_IN => CNT(21 downto 18), HEX_OUT => HEX1);
	C2 : char_decoder port map (BIN_IN => CNT(25 downto 22), HEX_OUT => HEX2);
	C3 : char_decoder port map (BIN_IN => CNT(29 downto 26), HEX_OUT => HEX3);
	C4 : char_decoder port map (BIN_IN => CNT(33 downto 30), HEX_OUT => HEX4);
	C5 : char_decoder port map (BIN_IN => CNT(37 downto 34), HEX_OUT => HEX5);
	
	d0 : dflipflop port map (Reset => Reset, Clock => Clock, Q => CNT(0), Qn => CNTn(0), D => CNTn(0));
	
	GEN_char_decoder:
	for I in 1 to 37 generate
		dX : dflipflop port map
			(Reset => Reset, Clock => CNTn(I-1), Q => CNT(I), Qn => CNTn(I), D => CNTn(I));
	end generate GEN_char_decoder;
	
	
 
end architecture;