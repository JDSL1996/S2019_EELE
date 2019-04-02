library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_64x8_sync is
     port (Clock    : in  std_logic;
           Address  : in  std_logic_vector(5 downto 0);
           Data_Out : out std_logic_vector(7 downto 0));
end entity;

architecture rom_64x8_sync_arch of rom_64x8_sync is
	type ROM_type is array (0 to 63) of std_logic_vector(7 downto 0);

	constant ROM : ROM_type := ( 	
					0 => x"00",
					1 => x"11",
					2 => x"22",
					3 => x"33",
					4 => x"44",
					5 => x"55",
					6 => x"66",
					7 => x"77",
					8 => x"88",
					9 => x"99",
					10 => x"AA",
					11 => x"BB",
					12 => x"CC",
					13 => x"DD",
					14 => x"EE",
					15 => x"FF",
					16 => x"FF",
					17 => x"EE",
					18 => x"DD",
					19 => x"CC",
					20 => x"BB",
					21 => x"AA",
					22 => x"99",
					23 => x"88",
					24 => x"77",
					25 => x"66",
					26 => x"55",
					27 => x"44",
					28 => x"33",
					29 => x"22",
					30 => x"11",
					others => x"00");
	begin
	
		process (Clock)
		begin
			if (rising_edge(Clock)) then
				data_out <= ROM (to_integer(unsigned(address)));
			end if;
	end process;
	
		

end architecture;