library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity add_n_sum_8bit is
	port (A, B	 : in std_logic_vector(7 downto 0);
	      ADDn_SUB	 : in std_logic;
	      Sum_Diff	 : out std_logic_vector(7 downto 0);
	      Cout_Bout	 : out std_logic;
	      Vout	 : out std_logic);
end entity;

architecture add_n_sum_8bit_arch of add_n_sum_8bit is

	component full_adder is
		port (A, B, Cin	 : in std_logic;
	       	       sum, Cout : out std_logic);
	end component;

	signal C1, C2, C3, C4, C5, C6, C7 : std_logic;
	signal temp_B : std_logic_vector(7 downto 0);
	signal overflow_check : std_logic;

	begin			
		temp_B(0) <= B(0) xor ADDn_SUB;
		temp_B(1) <= B(1) xor ADDn_SUB;
		temp_B(2) <= B(2) xor ADDn_SUB;
		temp_B(3) <= B(3) xor ADDn_SUB;
		temp_B(4) <= B(4) xor ADDn_SUB;
		temp_B(5) <= B(5) xor ADDn_SUB;
		temp_B(6) <= B(6) xor ADDn_SUB;
		temp_B(7) <= B(7) xor ADDn_SUB;

		A0 : full_adder port map (A(0), temp_B(0), ADDn_SUB, Sum_Diff(0), C1);
		A1 : full_adder port map (A(1), temp_B(1), C1, Sum_Diff(1), C2);
		A2 : full_adder port map (A(2), temp_B(2), C2, Sum_Diff(2), C3);
		A3 : full_adder port map (A(3), temp_B(3), C3, Sum_Diff(3), C4);
		A4 : full_adder port map (A(4), temp_B(4), C4, Sum_Diff(4), C5);
		A5 : full_adder port map (A(5), temp_B(5), C5, Sum_Diff(5), C6);
		A6 : full_adder port map (A(6), temp_B(6), C6, Sum_Diff(6), C7);
		A7 : full_adder port map (A(7), temp_B(7), C7, overflow_check, Cout_Bout);

		Sum_Diff(7) <= overflow_check;

		OVERFLOW : process (overflow_check)
		   begin
			if (A(7) = '1' and temp_B(7) = '1' and overflow_check = '0') then 
				Vout <= '1';

			elsif (A(7) = '0' and temp_B(7) = '0' and overflow_check = '1') then 
				Vout <= '1';

			elsif (A(7) = '1' and temp_B(7) = '0' and overflow_check = '0') then 
				Vout <= '1';

			elsif (A(7) = '0' and temp_B(7) = '1' and overflow_check = '1') then 
				Vout <= '1';

			else
				Vout <= '0';
			end if;

		end process;
end architecture;
