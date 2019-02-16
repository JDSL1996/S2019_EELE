library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
 port (
	Clock_50	:	in  std_logic;
	Reset		:	in  std_logic;
	SW 		: 	in  std_logic_vector (3 downto 0);
	LEDR 		: 	out std_logic_vector (9 downto 0);
	HEX0 		: 	out std_logic_vector (6 downto 0);
	HEX1 		: 	out std_logic_vector (6 downto 0);
	HEX2 		: 	out std_logic_vector (6 downto 0);
	HEX3 		: 	out std_logic_vector (6 downto 0);
	HEX4 		: 	out std_logic_vector (6 downto 0);
	HEX5 		: 	out std_logic_vector (6 downto 0);
	GPIO_1	: 	out std_logic_vector (9 downto 0));
end entity;

architecture top_arch of top is

 signal CNT, CNTn : std_logic_vector (37 downto 0);
 signal Clock_div : std_logic;
 type State_Type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
 signal current_state, next_state : State_Type;
 signal Walking1_Out : std_logic_vector (9 downto 0);
 
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
 
	--ripple counter
	LEDR <= Walking1_Out;
	GPIO_1 <= Walking1_Out;
	Clock_div <= CNT(20);
 
	C0 : char_decoder port map (BIN_IN => CNT(17 downto 14), HEX_OUT => HEX0);
	C1 : char_decoder port map (BIN_IN => CNT(21 downto 18), HEX_OUT => HEX1);
	C2 : char_decoder port map (BIN_IN => CNT(25 downto 22), HEX_OUT => HEX2);
	C3 : char_decoder port map (BIN_IN => CNT(29 downto 26), HEX_OUT => HEX3);
	C4 : char_decoder port map (BIN_IN => CNT(33 downto 30), HEX_OUT => HEX4);
	C5 : char_decoder port map (BIN_IN => CNT(37 downto 34), HEX_OUT => HEX5);
	
	d0 : dflipflop port map (Reset => Reset, Clock => Clock_50, Q => CNT(0), Qn => CNTn(0), D => CNTn(0));
	
	GEN_char_decoder:
	for I in 1 to 37 generate
		dX : dflipflop port map
			(Reset => Reset, Clock => CNTn(I-1), Q => CNT(I), Qn => CNTn(I), D => CNTn(I));
	end generate GEN_char_decoder;
	--end counter
	
	STATE_MEMORY : process (Clock_div, Reset)
		begin
			if (Reset = '0') then
				current_state <= S0;
			elsif (rising_edge(Clock_div)) then
				current_state <= next_state;
			end if;
		end process;

	NEXT_STATE_LOGIC : process (current_state, SW(0))
		begin
			case (current_state) is
				when S0 => if (SW(0) = '0') then
						next_state <= S9;
					   else	
						next_State <= S1;
					   end if;
				
				when S1 => if (SW(0) = '0') then
						next_state <= S0;
					   else	
						next_State <= S2;
					   end if;

				when S2 => if (SW(0) = '0') then
						next_state <= S1;
					   else	
						next_State <= S3;
					   end if;

				when S3 => if (SW(0) = '0') then
						next_state <= S2;
					   else	
						next_State <= S4;
					   end if;
						
				when S4 => if (SW(0) = '0') then
						next_state <= S3;
					   else	
						next_State <= S5;
					   end if;
				
				when S5 => if (SW(0) = '0') then
						next_state <= S4;
					   else	
						next_State <= S6;
					   end if;

				when S6 => if (SW(0) = '0') then
						next_state <= S5;
					   else	
						next_State <= S7;
					   end if;

				when S7 => if (SW(0) = '0') then
						next_state <= S6;
					   else	
						next_State <= S8;
					   end if;
						
				when S8 => if (SW(0) = '0') then
						next_state <= S7;
					   else	
						next_State <= S9;
					   end if;

				when S9 => if (SW(0) = '0') then
						next_state <= S8;
					   else	
						next_State <= S0;
					   end if;
				
				when others => next_state <= S0;
			end case;
		end process;
		
	OUTPUT_LOGIC : process (current_state)
		begin
			Walking1_Out <= (others =>'0');
			case (current_state) is
				when S0 => Walking1_Out(0) <= '1';
				
				when S1 => Walking1_Out(1) <= '1';

				when S2 => Walking1_Out(2) <= '1';

				when S3 => Walking1_Out(3) <= '1';
						
				when S4 => Walking1_Out(4) <= '1';
				
				when S5 => Walking1_Out(5) <= '1';

				when S6 => Walking1_Out(6) <= '1';

				when S7 => Walking1_Out(7) <= '1';
						
				when S8 => Walking1_Out(8) <= '1';

				when S9 => Walking1_Out(9) <= '1';
			end case;
		end process;
	
 
end architecture;