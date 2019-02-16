library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter_16bit_UpDown is
     port (Clock, Reset : in  std_logic;
           Up           : in  std_logic;
           Count_Out    : out std_logic_vector(15 downto 0));
end entity;

architecture Counter_16bit_UpDown_arch of Counter_16bit_UpDown is

 signal CNT_int : integer;
 begin
	COUNTER : process (Clock, Reset)
	 begin
		if(Reset = '0') then
			CNT_int <= 0;
		elsif (rising_edge(Clock)) then
		  if (Up = '1') then	
			if (CNT_int = 65536 ) then
			  CNT_int <= 0;
			else
			  CNT_int <= CNT_int +1;
			end if;
		   else
			if (CNT_int = 0 ) then
			  CNT_int <= 65536;
			else
			  CNT_int <= CNT_int -1;
			end if;
		   end if;
		end if;
	 end process;

	Count_Out <= std_logic_vector(to_unsigned(CNT_int, 16));

end architecture;