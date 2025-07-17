 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 use ieee.std_logic_unsigned.all; 
 
 entity ALU is 
         port(
		      A       : in std_logic_vector(7 downto 0);
			  B       : in std_logic_vector(7 downto 0);
			  ALU_sel : in std_logic_vector(2 downto 0);
			  ----
			  NZVC_out: out std_logic_vector(3 downto 0);
			  ALU_out : out std_logic_vector(7 downto 0)
            	);
end ALU;
architecture arch of ALU is

signal sum_unsigned: std_logic_vector(8 downto 0);
signal alu_reg     : std_logic_vector(7 downto 0);
signal add_overflow: std_logic;
signal sub_overflow: std_logic;


begin 
 process(ALU_sel, A, B)
    begin 
	 sum_unsigned <= (others => '0');
	 alu_reg      <= (others => '0');
	 add_overflow <= (others => '0');
	 sub_overflow <= (others => '0');
	 
	 case ALU_sel is 
	  
	   when "000" => 
	    alu_reg      <= A+B;
		sum_unsigned <= ('0' & A) + ('0' & B);
	   
	   when "001" =>
	   alu_reg       <= A-B;
	   sum_unsigned <= ('0' & A) - ('0' & B);
	   
	   when "010" => 
	   alu_reg <= A and B;
	   
	   when "011" => 
	   alu_reg <= A or B;
	   
	   when "100" =>
	   alu_reg <= A + x"01";
	   
	   when "101" => 
	   alu_reg <= A - x"01";
	   
	   when others =>
	   sum_unsigned <= (others => '0');
	   alu_reg      <= (others => '0');
	   add_overflow <= (others => '0');
	   sub_overflow <= (others => '0');
	 
	   end case;
	end process;

  ALU_out <= alu_reg;
  
  -- NZVC (Negative, Zero, Overflow, Carry)
  
  --N
  NZVC_out(3) <= alu_reg(7);
  
  --Z
  NZVC_out(2) <= '1' when alu_reg = x"00" else '0'; 

  --V
  add_overflow <= (not (A(7)) and not (B(7)) and (alu_reg(7))) or ( (A(7)) and  (B(7)) and not(alu_reg(7)));
  sub_overflow <= (not (A(7)) and  (B(7)) and (alu_reg(7))) or ( (A(7)) and  not(B(7)) and not(alu_reg(7)));
  NZVC_out(1) <= add_overflow when (ALU_sel = "000") else 
                 sub_overflow when (ALU_sel = "001") else '0'; 

  --C
  NZVC_out(0) <=  sum_unsigned(0) when (ALU_sel = "000") else 
                  sum_unsigned(0) when (ALU_sel = "001") else '0'; 
end arch;