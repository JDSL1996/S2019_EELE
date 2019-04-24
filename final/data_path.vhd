library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_path is
port (  clock     : in std_logic;
        reset           : in std_logic;
        address         : out std_logic_vector(7 downto 0);
        to_memory       : out std_logic_vector (7 downto 0);
        from_memory     : in std_logic_vector (7 downto 0);

        IR_Load     : in std_logic;
        IR          : out std_logic_vector (7 downto 0);
        MAR_Load    : in std_logic;
        PC_Load     : in std_logic;
        PC_inc      : in std_logic;
        A_Load      : in std_logic;
        B_Load      : in std_logic;
        ALU_Sel     : in std_logic_vector (2 downto 0);
        CCR_Result  : out std_logic_vector (3 downto 0);
        CCR_Load    : in std_logic;
        Bus2_Sel    : in std_logic_vector (1 downto 0);
        Bus1_Sel    : in std_logic_vector (1 downto 0));
  end entity;

architecture data_path_arch of data_path is
    component ALU
        port (  A, B        : in std_logic_vector (7 downto 0);
                ALU_Sel     : in std_logic_vector (2 downto 0);
                NZVC        : out std_logic_vector (3 downto 0);
                ALU_Result  : out std_logic_vector (7 downto 0));
    end component;
    
    signal BUS1, BUS2        	: std_logic_vector (7 downto 0);
    signal MAR, PC        	: std_logic_vector (7 downto 0);
    signal PC_uns        	: UNSIGNED (7 downto 0);
    signal A,B        		: std_logic_vector (7 downto 0);
    signal ALU_Result        	: std_logic_vector (7 downto 0);
    signal NZVC       		: std_logic_vector (3 downto 0);
    
    begin

	ALU_1 : ALU 
		port map ( 	A => A, 
				B => B, 
				ALU_Sel => ALU_Sel,
				NZVC => NZVC, 
				ALU_Result => ALU_Result);

	to_memory <= Bus1;
	address <= MAR;

	MUX_BUS1 : process(Bus1_Sel, PC, A, B)
	  begin
		case (Bus1_Sel) is
			when "00"	=> Bus1 <= PC;
			when "01"	=> Bus1 <= A;
			when "10"	=> Bus1 <= B;
			when others	=> Bus1 <= x"00";
		end case;
	end process;

	MUX_BUS2 : process(Bus2_Sel, ALU_Result, Bus1, from_memory)
	  begin
		case (Bus2_Sel) is
			when "00"	=> Bus2 <= ALU_Result;
			when "01"	=> Bus2 <= Bus1;
			when "10"	=> Bus2 <= from_memory;
			when others	=> Bus2 <= x"00";
		end case;
	end process;

	INSTRUCTION_REGISTER : process(Clock, Reset)
	  begin
		if (reset = '0') then
			IR <= x"00";
		elsif (Clock'event and Clock = '1') then
			if (IR_LOAD = '1') then
				IR <= Bus2;
			end if;
		end if;
	end process;

	MEMORY_REGISTER : process(Clock, Reset)
	  begin
		if (reset = '0') then
			MAR <= x"00";
		elsif (Clock'event and Clock = '1') then
			if (MAR_LOAD = '1') then
				MAR <= Bus2;
			end if;
		end if;
	end process;

	PROGRAM_COUNTER : process(Clock, Reset)
	  begin
		if (reset = '0') then
			PC_uns <= x"00";
		elsif (Clock'event and Clock = '1') then
			if (PC_Load = '1') then
				PC_uns <= unsigned(Bus2);
			elsif(PC_Inc = '1') then
				PC_uns <= PC_uns + 1;
			end if;
		end if;
	end process;

	PC <= std_logic_vector(PC_uns);

	A_REGISTER : process(Clock, Reset)
	  begin
		if (reset = '0') then
			A <= x"00";
		elsif (Clock'event and Clock = '1') then
			if (A_LOAD = '1') then
				A <= Bus2;
			end if;
		end if;
	end process;

	B_REGISTER : process(Clock, Reset)
	  begin
		if (reset = '0') then
			B <= x"00";
		elsif (Clock'event and Clock = '1') then
			if (B_LOAD = '1') then
				B <= Bus2;
			end if;
		end if;
	end process;
    
end architecture;