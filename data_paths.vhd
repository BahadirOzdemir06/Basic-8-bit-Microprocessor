library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 use ieee.std_logic_unsigned.all; 
 
 entity data_path is 
         port(
		       clk        : in std_logic;
			   rst        : in std_logic;
			   IR_load    : in std_logic;
			   MAR_load   : in std_logic;
			   PC_load    : in std_logic;
			   PC_Inc     : in std_logic;
			   A_load     : in std_logic;
			   B_load     : in std_logic;
			   ALU_Sel    : in std_logic_vector(2 downto 0);
			   CCR_Load   : in std_logic;
			   Bus2_Sel   : in std_logic_vector(1 downto 0);
			   Bus1_Sel   : in std_logic_vector(1 downto 0);
			   from_memory: in std_logic_vector(7 downto 0);
			   ----
			   IR         : out std_logic_vector(7 downto 0);
			   CCR_Result : out std_logic_vector(3 downto 0);
			   address    : out std_logic_vector(7 downto 0);
			   to_memory  : out std_logic_vector(7 downto 0)
            	);
end data_path;
architecture arch of data_path is

component ALU is 
          port(
		      A       : in std_logic_vector(7 downto 0);
			  B       : in std_logic_vector(7 downto 0);
			  ALU_sel : in std_logic_vector(2 downto 0);
			  ----
			  NZVC_out: out std_logic_vector(3 downto 0);
			  ALU_out : out std_logic_vector(7 downto 0)
            	);
end component;

---Signals
signal BUS1      : std_logic_vector(7 downto 0);
signal BUS2      : std_logic_vector(7 downto 0);
signal ALU_Result: std_logic_vector(7 downto 0);
signal IR_reg    : std_logic_vector(7 downto 0);
signal MAR       : std_logic_vector(7 downto 0);
signal PC        : std_logic_vector(7 downto 0);
signal A_reg     : std_logic_vector(7 downto 0);
signal B_reg     : std_logic_vector(7 downto 0);
signal CCR_in    : std_logic_vector(3 downto 0);
signal CCR_reg   : std_logic_vector(3 downto 0);







begin 


--BUS1_MUX:

  BUS1 <= PC     when Bus1_Sel = "00" else 
          A_reg  when Bus1_Sel = "01" else
		  B_reg  when Bus1_Sel = "10" else (others => '0');
		  




--BUS2_MUX:

  BUS2 <= ALU_Result  when Bus2_Sel = "00" else 
          BUS1        when Bus2_Sel = "01" else
		  from_memory when Bus2_Sel = "10" else (others => '0');

--IR:

process(clk,rst)
  begin 
   if rst = '1' then 
    IR_reg <= (others => '0');
	elsif rising_edge(clk) then 
	   if IR_load = '1' then 
	     IR_reg <=  BUS2;
		end if;
		end if;
  end process;
  IR <= IR_reg;

--MAR:

process(clk,rst)
  begin 
   if rst = '1' then 
    MAR <= (others => '0');
	elsif rising_edge(clk) then 
	   if MAR_load = '1' then 
	     MAR <=  BUS2;
		end if;
		end if;
  end process;
   address <= MAR;
   
--PC:

process(clk,rst)
  begin 
   if rst = '1' then 
    PC <= (others => '0');
	elsif rising_edge(clk) then 
	   if PC_load = '1' then 
	     PC <=  BUS2;
	   elsif PC_Inc = '1' then 
	     PC <= PC + x"01";
		end if;
		end if;
  end process;
  
  
 --A register:

process(clk,rst)
  begin 
   if rst = '1' then 
    A_reg <= (others => '0');
	elsif rising_edge(clk) then 
	   if A_load = '1' then 
	     A_reg <=  BUS2;
		end if;
		end if;
  end process;


 --B register:

process(clk,rst)
  begin 
   if rst = '1' then 
    B_reg <= (others => '0');
	elsif rising_edge(clk) then 
	   if B_load = '1' then 
	     B_reg <=  BUS2;
		end if;
		end if;
  end process;
  
  
 --ALU 
 
 ALU_U: ALU port map (
                       A         => B_reg,
                       B         => BUS1,
                       ALU_sel   => ALU_Sel,
                       ----      
                       NZVC_out  => CCR_in,
                       ALU_out   => ALU_Result
                     
					 );

--CCR Register

process(clk,rst)
  begin 
   if rst = '1' then 
    CCR_reg <= (others => '0');
	elsif rising_edge(clk) then 
	   if CCR_load = '1' then 
	     CCR_reg <=  CCR_in;
		end if;
		end if;
  end process;
  CCR_Result <= CCR_reg;

---
 to_memory <= BUS1;
end arch;