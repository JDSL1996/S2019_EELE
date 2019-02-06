library IEEE;
use IEEE.std_logic_1164.all;

entity SystemL is
   port (ABCD  : in  std_logic_vector(3 downto 0);
         F     : out std_logic);
end entity;

architecture SystemL_arch of SystemL is
   begin
      SystemL_Proc : process (ABCD)
         
	--variable ABCD : bit_vector (3 downto 0);

	begin
	      --ABCD := A & B & C & D;

		case (ABCD) is
		  when "0001" | "1001" | "1011" | "1101" => F <= '0';
		  when others		=> F <= '1';
		end case;
      end process;

end architecture;

