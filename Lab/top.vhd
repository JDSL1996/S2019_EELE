library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
 port (
	Clock_50	:	in  std_logic;
	Reset		:	in  std_logic;
	SW 		: 	in  std_logic_vector (3 downto 0);
	LEDR 		: 	out std_logic_vector (9 downto 0);
	HEX0 		: 	out std_logic_vector (6 downto 0);
	HEX1 		: 	out std_logic_vector (6 downto 0);
	HEX2 		: 	out std_logic_vector (6 downto 0);
	HEX3 		: 	out std_logic_vector (6 downto 0);
	HEX4 		: 	out std_logic_vector (6 downto 0);
	HEX5 		: 	out std_logic_vector (6 downto 0);
	GPIO_1	: 	out std_logic_vector (7 downto 0));
end entity;

architecture top_arch of top is

 signal CNT			: std_logic_vector (23 downto 0);
 signal Clock_div : std_logic;
 signal CNT_uns	: unsigned (23 downto 0);
 
 component char_decoder
	port (
		BIN_IN 	: in std_logic_vector (3 downto 0);
		HEX_OUT 	: out std_logic_vector (6 downto 0));
 end component;
 
 component clock_div_prec is
 port (
	Clock_In	:	in  std_logic;
	Reset		:	in  std_logic;
	Sel 		: 	in  std_logic_vector (1 downto 0);
	Clock_Out: 	out std_logic);
end component;
 

 begin
 
	clk : clock_div_prec port map (Clock_In => Clock_50, Reset => Reset, Sel => SW(1 downto 0), Clock_Out => Clock_div);
	
--	Counter_24 : process (Clock_div, Reset)
--		begin
--			if (Reset = '0') then
--				CNT_uns <= (others =>'0');
--			elsif (rising_edge(Clock_div)) then
--				CNT_uns <= CNT_uns + 1;
--			end if;
--	end process;
	
	Counter_3 : process (Clock_div, Reset)
		begin
			if (Reset = '0') then
				CNT_uns(3 downto 0) <= (others =>'0');
			elsif (rising_edge(Clock_div)) then
				if (CNT_uns (3 downto 0) = "1001") then
					CNT_uns (3 downto 0) <= "0000";
				elsif (rising_edge(Clock_div)) then
					CNT_uns(3 downto 0) <= CNT_uns(3 downto 0) + 1;
				end if;
				
			end if;
	end process;
	
	Counter_7 : process(Clock_div, Reset)
	begin
			if (Reset = '0') then
				CNT_uns(7 downto 4) <= (others =>'0');
			elsif (rising_edge(Clock_div)) then
				if(CNT_uns (3 downto 0) = "1001") then
					if (CNT_uns (7 downto 4) = "1001") then
						CNT_uns (7 downto 4) <= "0000";
					else
						CNT_uns(7 downto 4) <= CNT_uns(7 downto 4) + 1;
					end if;
				end if;
			end if;
	end process;
	
	Counter_11 : process(Clock_div, Reset)
	begin
			if (Reset = '0') then
				CNT_uns(11 downto 8) <= (others =>'0');
			elsif (rising_edge(Clock_div)) then
				if(CNT_uns (7 downto 4) = "1001" and CNT_uns (3 downto 0) = "1001") then
					if (CNT_uns (11 downto 8) = "1001") then
						CNT_uns (11 downto 8) <= "0000";
					else
						CNT_uns(11 downto 8) <= CNT_uns(11 downto 8) + 1;
					end if;
				end if;
			end if;
	end process;
	
	Counter_15 : process(Clock_div, Reset)
	begin
			if (Reset = '0') then
				CNT_uns(15 downto 12) <= (others =>'0');
			elsif (rising_edge(Clock_div)) then
				if(CNT_uns (11 downto 8) = "1001" and CNT_uns (7 downto 4) = "1001" and CNT_uns (3 downto 0) = "1001") then
					if (CNT_uns (15 downto 12) = "1001") then
						CNT_uns (15 downto 12) <= "0000";
					else
						CNT_uns(15 downto 12) <= CNT_uns(15 downto 12) + 1;
					end if;
				end if;
			end if;
	end process;
	
	Counter_19 : process(Clock_div, Reset)
	begin
			if (Reset = '0') then
				CNT_uns(19 downto 16) <= (others =>'0');
			elsif (rising_edge(Clock_div)) then
				if(CNT_uns (15 downto 0) = "1001100110011001") then
					if (CNT_uns (19 downto 16) = "1001") then
						CNT_uns (19 downto 16) <= "0000";
					else
						CNT_uns(19 downto 16) <= CNT_uns(19 downto 16) + 1;
					end if;
				end if;
			end if;
	end process;
	
	Counter_23 : process(Clock_div, Reset)
	begin
			if (Reset = '0') then
				CNT_uns(23 downto 20) <= (others =>'0');
			elsif (rising_edge(Clock_div)) then
				if(CNT_uns (19 downto 0) = "10011001100110011001") then
					if (CNT_uns (23 downto 20) = "1001") then
						CNT_uns (23 downto 20) <= "0000";
					else
						CNT_uns(23 downto 20) <= CNT_uns(23 downto 20) + 1;
					end if;
				end if;
			end if;
	end process;
	
	CNT <= std_logic_vector(CNT_uns);
	
	LEDR(0) <= Clock_div;
	GPIO_1(0) <= Clock_div;
 
	C0 : char_decoder port map (BIN_IN => CNT(3 downto 0), HEX_OUT => HEX0);
	C1 : char_decoder port map (BIN_IN => CNT(7 downto 4), HEX_OUT => HEX1);
	C2 : char_decoder port map (BIN_IN => CNT(11 downto 8), HEX_OUT => HEX2);
	C3 : char_decoder port map (BIN_IN => CNT(15 downto 12), HEX_OUT => HEX3);
	C4 : char_decoder port map (BIN_IN => CNT(19 downto 16), HEX_OUT => HEX4);
	C5 : char_decoder port map (BIN_IN => CNT(23 downto 20), HEX_OUT => HEX5);	
 
end architecture;