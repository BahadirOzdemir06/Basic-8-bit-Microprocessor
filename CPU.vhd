 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 use ieee.std_logic_unsigned.all; 
 
 entity CPU is 
         port(
		       clk        : in std_logic;
			   rst        : in std_logic;
               from_memory: in std_logic_vector(7 downto 0);
			   ----------
			   address    : out std_logic_vector(7 downto 0);
			   to_memory  : out std_logic_vector(7 downto 0);
			    write_en   : out std_logic
            );
end CPU;

architecture arch of CPU is

component control_unit is 
         port(
		       clk        : in std_logic;
			   rst        : in std_logic;
			   CCR_Result : in std_logic_vector(3 downto 0);
			   IR         : in std_logic_vector(7 downto 0);
			   ----------------------
			   IR_load    : out std_logic;
			   MAR_load   : out std_logic;
			   PC_load    : out std_logic;
			   PC_Inc     : out std_logic;
			   A_load     : out std_logic;
			   B_load     : out std_logic;
			   ALU_Sel    : out std_logic_vector(2 downto 0);
			   CCR_Load   : out std_logic;
			   Bus2_Sel   : out std_logic_vector(1 downto 0);
			   Bus1_Sel   : out std_logic_vector(1 downto 0);
			   write_en   : out std_logic
            	);
end component;






component data_path is 
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
end component;

----connection signals----

signal CCR_Result :  std_logic_vector(3 downto 0);
signal IR         :  std_logic_vector(7 downto 0);
signal IR_load    :  std_logic;
signal MAR_load   :  std_logic;
signal PC_load    :  std_logic;
signal PC_Inc     :  std_logic;
signal A_load     :  std_logic;
signal B_load     :  std_logic;
signal CCR_Load   :  std_logic;
signal Bus2_Sel   :  std_logic_vector(1 downto 0);
signal Bus1_Sel   :  std_logic_vector(1 downto 0);
signal ALU_Sel    :  std_logic_vector(2 downto 0);


begin 


--Control Unit

Control_Unit_U: control_unit port map (
                                        clk         => clk         ,
                                        rst         => rst         ,
                                        CCR_Result  => CCR_Result  ,
                                        IR          => IR          ,
                                        IR_load     => IR_load     ,
                                        MAR_load    => MAR_load    ,
                                        PC_load     => PC_load     ,
                                        PC_Inc      => PC_Inc      ,
                                        A_load      => A_load      ,
                                        B_load      => B_load      ,
                                        ALU_Sel     => ALU_Sel     ,
                                        CCR_Load    => CCR_Load    ,
                                        Bus2_Sel    => Bus2_Sel    ,
                                        Bus1_Sel    => Bus1_Sel    ,
                                        write_en    => write_en    
                                        );




Data_Path_U: data_path port map (
                                 
								 clk          => clk           ,
								 rst          => rst           ,
								 IR_load      => IR_load       ,
								 MAR_load     => MAR_load      ,
								 PC_load      => PC_load       ,
								 PC_Inc       => PC_Inc        ,
								 A_load       => A_load        ,
								 B_load       => B_load        ,
								 ALU_Sel      => ALU_Sel       ,
								 CCR_Load     => CCR_Load      ,
								 Bus2_Sel     => Bus2_Sel      ,
								 Bus1_Sel     => Bus1_Sel      ,
								 from_memory  => from_memory   ,
								 IR           => IR            ,
								 CCR_Result   => CCR_Result    ,
								 address      => address       ,
								 to_memory    => to_memory     

								 );
end arch;