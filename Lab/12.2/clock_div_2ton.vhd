library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_div_2ton is
 port (
	Clock_In	:	in  std_logic;
	Reset		:	in  std_logic;
	Sel 		: 	in  std_logic_vector (1 downto 0);
	Clock_Out: 	out std_logic);
end entity;

architecture clock_div_2ton_arch of clock_div_2ton is

 signal CNT, CNTn : std_logic_vector (37 downto 0);
 
 component dflipflop is
 port (
	Clock 	: in std_logic;
	Reset 	: in std_logic;
	D		 	: in std_logic;
	Q, Qn 	: out std_logic);
 end component;
 

 begin
 
	--n: 1=25, 18=191, 23=6, 25=1.5
 
	--ripple counter
	
	d0 : dflipflop port map (Reset => Reset, Clock => Clock_In, Q => CNT(0), Qn => CNTn(0), D => CNTn(0));
	
	GEN_char_decoder:
	for I in 1 to 37 generate
		dX : dflipflop port map
			(Reset => Reset, Clock => CNTn(I-1), Q => CNT(I), Qn => CNTn(I), D => CNTn(I));
	end generate GEN_char_decoder;
	--end counter
 
	MUX : process (Sel, CNT) 
	 begin
		case (Sel) is
				when "00" => Clock_Out <= CNT(1);
				when "01" => Clock_Out <= CNT(18);
				when "10" => Clock_Out <= CNT(23);
				when "11" => Clock_Out <= CNT(25);
		end case;
	 end process;
 
end architecture;