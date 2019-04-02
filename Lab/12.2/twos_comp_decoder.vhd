library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity twos_char_decoder is
	port (
		TWOS_COMP_IN 	: in std_logic_vector (3 downto 0);
		MAG_OUT 			: out std_logic_vector (6 downto 0);
		SIGN_OUT 		: out std_logic_vector (6 downto 0));
 end entity;
 
architecture twos_char_decoder_arch of twos_char_decoder is
 begin
 -- Decoder process goes here…
 process (TWOS_COMP_IN)
	begin
		case (TWOS_COMP_IN) is
			when "0000" => 
				MAG_OUT <= "1000000";
				SIGN_OUT <= "0000000";
			when "0001" => 
				MAG_OUT <= "1111001";
				SIGN_OUT <= "0000000";
			when "0010" => 
				MAG_OUT <= "0100100";
				SIGN_OUT <= "0000000";
			when "0011" => 
				MAG_OUT <= "0110000";
				SIGN_OUT <= "0000000";
			
			when "0100" => 
				MAG_OUT <= "0011001";
				SIGN_OUT <= "0000000";
			when "0101" => 
				MAG_OUT <= "0010010";
				SIGN_OUT <= "0000000";
			when "0110" => 
				MAG_OUT <= "0000010";
				SIGN_OUT <= "0000000";
			when "0111" => 
				MAG_OUT <= "1111000";
				SIGN_OUT <= "0000000";
			
			when "1000" => 
				MAG_OUT <= "1111001";
				SIGN_OUT <= "0111111";
			when "1001" => 
				MAG_OUT <= "0100100";
				SIGN_OUT <= "0111111";
			when "1010" => 
				MAG_OUT <= "0110000";
				SIGN_OUT <= "0111111";
			when "1011" => 
				MAG_OUT <= "0011001";
				SIGN_OUT <= "0111111";
			
			when "1100" => 
				MAG_OUT <= "0010010";
				SIGN_OUT <= "0111111";
			when "1101" => 
				MAG_OUT <= "0000010";
				SIGN_OUT <= "0111111";
			when "1110" => 
				MAG_OUT <= "1111000";
				SIGN_OUT <= "0111111";
			when "1111" => 
				MAG_OUT <= "0000000";
				SIGN_OUT <= "0111111";
		end case;
	end process;

end architecture;