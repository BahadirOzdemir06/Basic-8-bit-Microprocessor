library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 use ieee.std_logic_unsigned.all; 
 
 entity control_unit is 
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
end control_unit;
architecture arch of control_unit is
type state_type is ( S_FETCH_0, S_FETCH_1, S_FETCH_2, S_DECODE_3,
                S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6, 
				S_LDA_DIR_4, S_LDA_DIR_5, S_LDA_DIR_6, S_LDA_DIR_7,S_LDA_DIR_8,
				S_LDB_IMM_4, S_LDB_IMM_5, S_LDB_IMM_6, 
				S_LDB_DIR_4, S_LDB_DIR_5, S_LDB_DIR_6, S_LDB_DIR_7,S_LDB_DIR_8,
				S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6, S_STA_DIR_7,
                S_ADD_AB_4,
                S_BRA_4,S_BRA_5,S_BRA_6,				
                S_BEQ_4,S_BEQ_5,S_BEQ_6,S_BEQ_7
				);
signal current_state,next_state: state_type;
------------------ COMMAND LIST--------------------------------------------------
																				--
																				--
 ---lOAD AND STORE---------------------------------------                       --
 constant LDA_IMM: std_logic_vector(7 downto 0):= x"86"	;                       --
 constant LDA_DIR: std_logic_vector(7 downto 0):= x"87"	;                       --
 constant LDB_IMM: std_logic_vector(7 downto 0):= x"88"	;                       --
 constant LDB_DIR: std_logic_vector(7 downto 0):= x"89"	;                       --
 constant STA_DIR: std_logic_vector(7 downto 0):= x"96"	;                       --
 constant STB_DIR: std_logic_vector(7 downto 0):= x"97"	;                       --
 ----DATA MANIPULATIONS----------------------------------                       --
 constant ADD_AB : std_logic_vector(7 downto 0):= x"42"	;                       --
 constant SUB_AB : std_logic_vector(7 downto 0):= x"43"	;                       --
 constant AND_AB : std_logic_vector(7 downto 0):= x"44"	; 						--										
 constant OR_AB  : std_logic_vector(7 downto 0):= x"45"	;                       --
 constant INCA   : std_logic_vector(7 downto 0):= x"46"	;                       --
 constant INCB   : std_logic_vector(7 downto 0):= x"47"	;                       --
 constant DECA   : std_logic_vector(7 downto 0):= x"48"	;                       --
 constant DECB   : std_logic_vector(7 downto 0):= x"49"	;                       --
 ------BRANCHES------------------------------------------                       --
 constant BRA   : std_logic_vector(7 downto 0):= x"20"	;                       --
 constant BMI   : std_logic_vector(7 downto 0):= x"21"	;                       --
 constant BPL   : std_logic_vector(7 downto 0):= x"22"	;                       --
 constant BEQ   : std_logic_vector(7 downto 0):= x"23"	;                       --
 constant BNE   : std_logic_vector(7 downto 0):= x"24"	;                       --
 constant BVS   : std_logic_vector(7 downto 0):= x"25"	;                       --
 constant BVC   : std_logic_vector(7 downto 0):= x"26"	;                       --
 constant BCS   : std_logic_vector(7 downto 0):= x"27"	;                       --
 constant BCC   : std_logic_vector(7 downto 0):= x"28"	;                       --
----------------------------------------------------------------------------------

				


begin 

--Current State Logic:
process(clk,rst)
 begin 
  if rst= '1' then 
   current_state <= S_FETCH_0;
   elsif rising_edge(clk) then 
    current_state <= next_state;
   
   end if;
  end process;
  
  
  
 -- Next State Logic 
  process(current_state, IR, CCR_Result)
   begin 
     case current_state is 
	 
	  when S_FETCH_0 => 
	  
	  next_state <= S_FETCH_1;
	  
	  when S_FETCH_1  => 
	  
	  next_state <= S_FETCH_2;
	  
	  when S_FETCH_2  => 
	  
	  next_state <= S_DECODE_3;
	  
	  when S_DECODE_3 => 
	  
	        if    (IR = LDA_IMM) then 
			
			     next_state <= S_LDA_IMM_4;
			
			elsif (IR = LDA_DIR) then 
			    
				  next_state <= S_LDA_DIR_4;
				  
			elsif (IR = LDB_IMM) then 
			
			     next_state <= S_LDB_IMM_4;
			
			elsif (IR = LDB_DIR) then 
			    
				  next_state <= S_LDB_DIR_4;
				 
			elsif (IR = STA_DIR) then
			
			      next_state <= S_STA_DIR_4;
			  
			elsif (IR = ADD_AB ) then
			
			      next_state <= S_ADD_AB_4;
			
			elsif (IR = BRA    ) then
			
			      next_state <= S_BRA_4; 
			
			elsif (IR = BEQ    ) then
			
			   if (CCR_Result(2)= '1') then 
			      
				   next_state <= S_BEQ_4;
			   
			   else 
			   
			       next_state <= S_BEQ_7;
			   
			   end if;
			else
			  
			  next_state <= S_FETCH_0;
			  
			end if;
------------------------------------	  
	  when S_LDA_IMM_4 => 
	  
	       next_state <= S_LDA_IMM_5;
	  
	  when S_LDA_IMM_5 => 
	  
	       next_state <= S_LDA_IMM_6;
	  
	  when S_LDA_IMM_6 => 
	  
	       next_state <= S_FETCH_0;
-------------------------------------	  
	  when S_LDA_DIR_4 => 
	  
	      next_state <= S_LDA_DIR_5;
	  
	  when S_LDA_DIR_5 => 
	  
	      next_state <= S_LDA_DIR_6;
	  
	  when S_LDA_DIR_6 => 
	  
	      next_state <= S_LDA_DIR_7;
	  
	  when S_LDA_DIR_7 => 
	  
	      next_state <= S_LDA_DIR_8;
	  
	  when S_LDA_DIR_8 => 
	  
	      next_state <= S_FETCH_0;
--------------------------------------

when S_LDB_IMM_4 => 
	  
	       next_state <= S_LDB_IMM_5;
	  
	  when S_LDB_IMM_5 => 
	  
	       next_state <= S_LDB_IMM_6;
	  
	  when S_LDB_IMM_6 => 
	  
	       next_state <= S_FETCH_0;
-------------------------------------	  
	  when S_LDB_DIR_4 => 
	  
	      next_state <= S_LDB_DIR_5;
	  
	  when S_LDB_DIR_5 => 
	  
	      next_state <= S_LDB_DIR_6;
	  
	  when S_LDB_DIR_6 => 
	  
	      next_state <= S_LDB_DIR_7;
	  
	  when S_LDB_DIR_7 => 
	  
	      next_state <= S_LDB_DIR_8;
	  
	  when S_LDB_DIR_8 => 
	  
	      next_state <= S_FETCH_0;
--------------------------------------		  
	  when S_STA_DIR_4 => 
	  
	      next_state <= S_STA_DIR_5;
	  
	  when S_STA_DIR_5 => 
	  
	      next_state <= S_STA_DIR_6;
	  
	  when S_STA_DIR_6 => 
	  
	      next_state <= S_STA_DIR_7;
	  
	  when S_STA_DIR_7 => 
	  
	      next_state <= S_FETCH_0;
---------------------------------------	  
	  when S_ADD_AB_4 => 
	  
	      next_state <= S_FETCH_0;
---------------------------------------	  
	  when S_BRA_4 => 
	  
	     next_state <= S_BRA_5;
	  
	  when S_BRA_5 => 
	  
	     next_state <= S_BRA_6;
	  
	  when S_BRA_6 => 
	  
	     next_state <= S_FETCH_0;
---------------------------------------	  
	  when S_BEQ_4 => 
	  
	     next_state <= S_BEQ_5;
	  
	  when S_BEQ_5 => 
	  
	    next_state <= S_BEQ_6;
	  
	  when S_BEQ_6 => 
	  
	    next_state <= S_FETCH_0;
	  
	  when S_BEQ_7 => 
	  
		next_state <= S_FETCH_0; 
--------------------------------------		 
	  when others  => 
	     
		next_state <= S_FETCH_0;
	 
	 end case;
   
   
   
   end process;
   
   
   
 --OUTPUT LOGIC----
 
 process(current_state)
  begin 
     
	 IR_load  <= '0';
	 MAR_load <= '0';
	 PC_load  <= '0';
	 A_load   <= '0';
	 B_load   <= '0';
	 ALU_Sel  <= (others => '0') ;
	 Bus2_SeL <= (others => '0') ;
	 Bus1_SeL <= (others => '0') ;
	 write_en <= '0';
	 CCR_Load <= '0';
	 PC_Inc   <= '0';
	 
	 
	 
    case current_state is 
	  when S_FETCH_0 => 
	  
	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';
	  
	  when S_FETCH_1  => 
	  
	   PC_Inc <= '1';
	  
	  when S_FETCH_2  => 
	  
	   Bus2_Sel <= "10";
	   IR_load <= '1';
	  
	  when S_DECODE_3 => 
	  
	       
------------------------------------	  
	  when S_LDA_IMM_4 => 
	  
	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';
	  
	  when S_LDA_IMM_5 => 
	  
	     PC_Inc <= '1';   
	  
	  when S_LDA_IMM_6 => 
	  
	     A_load <= '1';
-------------------------------------	  
	  when S_LDA_DIR_4 => 
	  
	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';
	     
	  
	  when S_LDA_DIR_5 => 
	  
	      PC_Inc <= '1'; 
	  
	  when S_LDA_DIR_6 => 
	  
	     Bus2_Sel <= "10";
		  MAR_load <= '1';
	  
	  when S_LDA_DIR_7 => 
	  
	      
	  
	  when S_LDA_DIR_8 => 
	      
		  Bus2_Sel <= "10";
	       A_load <= '1';
--------------------------------------	 
	  when S_LDB_IMM_4 => 
	  
	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';
	  
	  when S_LDB_IMM_5 => 
	  
	     PC_Inc <= '1';   
	  
	  when S_LDB_IMM_6 => 
	  
	     B_load <= '1';
-------------------------------------	  
	  when S_LDB_DIR_4 => 
	  
	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';
	     
	  
	  when S_LDB_DIR_5 => 
	  
	      PC_Inc <= '1'; 
	  
	  when S_LDB_DIR_6 => 
	  
	     Bus2_Sel <= "10";
		  MAR_load <= '1';
	  
	  when S_LDB_DIR_7 => 
	  
	      
	  
	  when S_LDB_DIR_8 => 
	      
		  Bus2_Sel <= "10";
	       B_load <= '1';
--------------------------------------	  
	  when S_STA_DIR_4 => 

	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';	  
	 
	  
	  when S_STA_DIR_5 => 

      PC_Inc <= '1'; 
	  
	  when S_STA_DIR_6 => 
	  
	  Bus2_Sel <= x"10";
      MAR_load <= '1';
	  
	  when S_STA_DIR_7 => 
	  
	  Bus1_Sel <= "01";
	  write_en <= '1';

---------------------------------------	  
	  when S_ADD_AB_4 => 
	  
	  Bus1_Sel <= "01";
	  Bus2_Sel <= "00";
	  ALU_Sel  <= "000";
	  A_load   <= '1';
	  CCR_Load <= '1';

---------------------------------------	  
	  when S_BRA_4 => 

	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';	 	  

	  
	  when S_BRA_5 => 
	  

	  
	  when S_BRA_6 => 
	  
	    Bus2_Sel <= "10";
		PC_load  <= '1';
        
---------------------------------------	  
	  when S_BEQ_4 => 

	   Bus1_Sel <= "00";
	   Bus2_Sel <= "01";
	   MAR_load <= '1';	 	  

	  
	  when S_BEQ_5 => 
	  

	  when S_BEQ_6 => 
	  
	   Bus2_Sel <= "10";
		PC_load  <= '1';
      
	  
	  when S_BEQ_7 => 
	  
        PC_Inc <= '1';
--------------------------------------		 
	  when others  => 
	     
	 IR_load  <= '0';
	 MAR_load <= '0';
	 PC_load  <= '0';
	 A_load   <= '0';
	 B_load   <= '0';
	 ALU_Sel  <= (others => '0') ;
	 Bus2_SeL <= (others => '0') ;
	 Bus1_SeL <= (others => '0') ;
	 write_en <= '0';
	 CCR_Load <= '0';
	 PC_Inc   <= '0';
	 
	
	
	end case;
  
  
  
  
  end process;

end arch;