library IEEE;
use IEEE.std_logic_1164.all;

entity SystemJ is
   port (ABCD  : in  bit_vector(3 downto 0);
         F     : out bit);
end entity;

architecture SystemJ_arch of SystemJ is
   begin
      SystemJ_Proc : process (ABCD)
         
	--variable ABCD : bit_vector (3 downto 0);

	begin
	      --ABCD := A & B & C & D;

		case (ABCD) is
		  when "0100" | "0101" | "0111" | "1100" | "1101" | "1111" => F <= '1';
		  when others		=> F <= '0';
		end case;
      end process;

end architecture;
