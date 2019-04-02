library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
 port (
	SW 		: 	in  std_logic_vector (7 downto 0);
	LEDR 		: 	out std_logic_vector (9 downto 0);
	HEX0 		: 	out std_logic_vector (6 downto 0);
	HEX1 		: 	out std_logic_vector (6 downto 0);
	HEX2 		: 	out std_logic_vector (6 downto 0);
	HEX3 		: 	out std_logic_vector (6 downto 0);
	HEX4 		: 	out std_logic_vector (6 downto 0);
	HEX5 		: 	out std_logic_vector (6 downto 0));
end entity;

architecture top_arch of top is

	signal A, B : signed (3 downto 0);
	signal Sum	: signed (3 downto 0);
	
 component twos_char_decoder
	port (
		TWOS_COMP_IN 	: in std_logic_vector (3 downto 0);
		MAG_OUT 			: out std_logic_vector (6 downto 0);
		SIGN_OUT 		: out std_logic_vector (6 downto 0));
 end component;

 begin
 
	A <= signed(SW(7 downto 4));
	B <= signed(SW(3 downto 0));
	
	sum_proc : process (SW)
		begin
			Sum <= A + B;
	end process;
	
	C0 : twos_char_decoder port map (TWOS_COMP_IN => SW(3 downto 0), MAG_OUT => HEX0, SIGN_OUT => HEX1);
	C1 : twos_char_decoder port map (TWOS_COMP_IN => SW(7 downto 4), MAG_OUT => HEX2, SIGN_OUT => HEX3);
	C2 : twos_char_decoder port map (TWOS_COMP_IN => std_logic_vector(Sum(3 downto 0)), MAG_OUT => HEX4, SIGN_OUT => HEX5);
	
	LEDR(7 downto 0) <= SW;
	
	OVERFLOW : process (SW)
		   begin
			if (SW(3) = '1' and SW(7) = '1' and Sum(3) = '0') then 
				LEDR(9) <= '1';

			elsif (SW(3) = '0' and SW(7) = '0' and Sum(3) = '1') then 
				LEDR(9) <= '1';
			else
				LEDR(9) <= '0';
			end if;

		end process;
 
end architecture;