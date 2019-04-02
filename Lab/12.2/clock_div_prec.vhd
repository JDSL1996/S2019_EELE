library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_div_prec is
 port (
	Clock_In	:	in  std_logic;
	Reset		:	in  std_logic;
	Sel 		: 	in  std_logic_vector (1 downto 0);
	Clock_Out: 	out std_logic);
end entity;

architecture clock_div_prec_arch of clock_div_prec is

 signal clk_div : std_logic;
 signal max_val, current : integer;

 begin
 
	--n: 1=2.5*10^7, 10=2.5*10^6, 100=2.5*10^5, 1000=2.5*10^4
 
	MAX : process (Sel) 
	 begin
		case (Sel) is
				when "00" => max_val <= 25000000;
				when "01" => max_val <= 2500000;
				when "10" => max_val <= 250000;
				when "11" => max_val <= 25000;
		end case;
	 end process;
	
	CLOCK : process (Clock_In, Reset)
	 begin
		if (Reset = '0') then
			clk_div <= '0';
			current <= 0;
		elsif (rising_edge(Clock_In)) then
			current <= current + 1;
			if (current > max_val) then
				current <= 0;
				clk_div <= not clk_div;
			end if;
		end if;
		
		
	end process;
	
	Clock_Out <= clk_div;
 
end architecture;