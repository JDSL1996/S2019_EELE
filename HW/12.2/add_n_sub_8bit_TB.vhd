library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity add_n_sum_8bit_TB is
end entity;

architecture add_n_sum_8bit_TB_arch of add_n_sum_8bit_TB is
	component add_n_sum_8bit is
		port (	A, B	 	: in std_logic_vector(7 downto 0);
	      		ADDn_SUB	: in std_logic;
	      		Sum_Diff	: out std_logic_vector(7 downto 0);
	      		Cout_Bout	: out std_logic;
	      		Vout	 	: out std_logic);
	end component;

	signal A_TB, B_TB, Sum_Diff_TB 	: std_logic_vector(7 downto 0);
	signal Cout_Bout_TB, Vout_TB	: std_logic;
	signal ADDn_SUB_TB		: std_logic;

	begin
		DOT : add_n_sum_8bit port map (A_TB, B_TB, ADDn_SUB_TB, Sum_Diff_TB, Cout_Bout_TB, Vout_TB);

		STIM : process
			begin
				A_TB <= std_logic_vector(to_signed(7,8));
				B_TB <= std_logic_vector(to_signed(7,8));
				ADDn_SUB_TB <= '1';
				wait for 30 ns;

				A_TB <= std_logic_vector(to_signed(7,8));
				B_TB <= std_logic_vector(to_signed(-7,8));
				ADDn_SUB_TB <= '1';
				wait for 30 ns;

				A_TB <= std_logic_vector(to_signed(9,8));
				B_TB <= std_logic_vector(to_signed(-5,8));
				ADDn_SUB_TB <= '0';
				wait for 30 ns;


		end process;
end architecture;
