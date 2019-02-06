library IEEE;
use IEEE.std_logic_1164.all;

entity SystemI is
   port (ABCD  : in  std_logic_vector(3 downto 0);
         F     : out std_logic);
end entity;

architecture SystemI_arch of SystemI is
   begin
      process (ABCD)
         begin
	      if      (ABCD(3)='0' and ABCD(2)='0' and ABCD(1)='0' and ABCD(0)='1') then F <= '1';
	      elsif   (ABCD(3)='0' and ABCD(2)='0' and ABCD(1)='1' and ABCD(0)='1') then F <= '1';
	      elsif   (ABCD(3)='1' and ABCD(2)='0' and ABCD(1)='0' and ABCD(0)='1') then F <= '1';
	      elsif   (ABCD(3)='1' and ABCD(2)='0' and ABCD(1)='1' and ABCD(0)='1') then F <= '1';
	      else     F <= '0';
	      end if;
      end process;

end architecture;
