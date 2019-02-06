library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity SystemL_TB is
end entity;

architecture SystemL_TB_arch of SystemL_TB is
  
  constant t_delay : time :=	10 ns;

 component SystemL is
   port (ABCD  : in  std_logic_vector(3 downto 0);
         F     : out std_logic);
 end component;
 
 signal ABCD_TB : std_logic_vector(3 downto 0);
 signal F_TB    : std_logic;
 
 begin
    
    DUT : SystemL port map (ABCD_TB, F_TB);
    
    STIM : process
      
    file Fin : TEXT open READ_MODE is "input_vectors.txt";

   variable cur_read_line : line;
   variable cur_read_field : std_logic_vector(3 downto 0);

   variable cur_write_line : line;

    begin

	while(not endfile(Fin)) loop

		readline(Fin, cur_read_line);
		read(cur_read_line, cur_read_field);
		ABCD_TB <= cur_read_field;	wait for 50 ns;

		write(cur_write_line, string'("Input Vector ABCD_TB="));
		write(cur_write_line, ABCD_TB);
		write(cur_write_line, string'(" Output F_TB="));
		write(cur_write_line, F_TB);
		writeline(OUTPUT, cur_write_line);

	end loop;

	wait;
        
    end process;
  
end architecture;