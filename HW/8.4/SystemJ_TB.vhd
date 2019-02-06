library IEEE;
use IEEE.std_logic_1164.all;

entity SystemJ_TB is
end entity;

architecture SystemJ_TB_arch of SystemJ_TB is
  
 component SystemJ is
   port (ABCD  : in  bit_vector(3 downto 0);
         F     : out bit);
 end component;
 
 signal ABCD_TB : bit_vector(3 downto 0);
 signal F_TB    : bit;
 
 begin
    
    DUT : SystemJ port map (ABCD_TB, F_TB);
    
    STIM : process
      begin
        report "Starting input" severity NOTE;

	ABCD_TB <= "0000"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 0000 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 0000 with output of 0" severity NOTE;

        ABCD_TB <= "0001"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 0001 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 0001 with output of 0" severity NOTE;

        ABCD_TB <= "0010"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 0010 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 0010 with output of 0" severity NOTE;

        ABCD_TB <= "0011"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 0011 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 0011 with output of 0" severity NOTE;

        ABCD_TB <= "0100"; wait for 10 ns;
	assert (F_TB='0') report "PASSED at input 0100 with output of 1" severity NOTE;
	assert (F_TB='1') report "Failed at input 0100 with output of 0" severity ERROR;

        ABCD_TB <= "0101"; wait for 10 ns;
	assert (F_TB='0') report "PASSED at input 0101 with output of 1" severity NOTE;
	assert (F_TB='1') report "Failed at input 0101 with output of 0" severity ERROR;

        ABCD_TB <= "0110"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 0110 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 0110 with output of 0" severity NOTE;

        ABCD_TB <= "0111"; wait for 10 ns;
	assert (F_TB='0') report "PASSED at input 0111 with output of 1" severity NOTE;
	assert (F_TB='1') report "Failed at input 0111 with output of 0" severity ERROR;


        ABCD_TB <= "1000"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 1000 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 1000 with output of 0" severity NOTE;

        ABCD_TB <= "1001"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 1001 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 1001 with output of 0" severity NOTE;

        ABCD_TB <= "1010"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 1010 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 1010 with output of 0" severity NOTE;

        ABCD_TB <= "1011"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 1011 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 1011 with output of 0" severity NOTE;

        ABCD_TB <= "1100"; wait for 10 ns;
	assert (F_TB='0') report "PASSED at input 1100 with output of 1" severity NOTE;
	assert (F_TB='1') report "Failed at input 1100 with output of 0" severity ERROR;

        ABCD_TB <= "1101"; wait for 10 ns;
	assert (F_TB='0') report "PASSED at input 1101 with output of 1" severity NOTE;
	assert (F_TB='1') report "Failed at input 1101 with output of 0" severity ERROR;

        ABCD_TB <= "1110"; wait for 10 ns;
	assert (F_TB='0') report "Failed at input 1110 with output of 1" severity ERROR;
	assert (F_TB='1') report "PASSED at input 1110 with output of 0" severity NOTE;

        ABCD_TB <= "1111"; wait for 10 ns;
	assert (F_TB='0') report "PASSED at input 1111 with output of 1" severity NOTE;
	assert (F_TB='1') report "Failed at input 1111 with output of 0" severity ERROR;


       
    end process;
  
end architecture;

