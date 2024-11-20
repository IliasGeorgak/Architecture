----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:50:27 04/18/2023 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Zero : in  STD_LOGIC;
			  Byte_sel : in std_logic_vector(1 downto 0);
           PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           Cloud_ctrl : out  STD_LOGIC_VECTOR (1 downto 0);
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           ALU_bin_sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC_VECTOR(3 downto 0);
			  Mem_ReadEn : out STD_LOGIC_VECTOR(3 downto 0);
           RF_WrEn : out  STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is
signal opCode:std_logic_vector(5 downto 0);
signal func:std_logic_vector(3 downto 0);
signal imm_func:std_logic_vector(3 downto 0);
signal t_Cloud_ctrl:std_logic_vector(1 downto 0):="00"; 
signal t_PC_LdEn:std_logic:='1';
signal t_PC_sel:std_logic:='0';
signal t_RF_WrEn:std_logic:='0';
signal t_RF_WrData_sel:std_logic:='0';
signal t_RF_B_sel:std_logic:='0';
signal t_ALU_func:std_logic_vector(3 downto 0):="1111";
signal t_Alu_Bin_Sel:std_logic:='0';
signal t_Mem_WrEn:std_logic_vector(3 downto 0):="0000";
signal t_Mem_ReadEn:std_logic_vector(3 downto 0):="0000";


begin
opCode<=Instr(31 downto 26);
func<=Instr(3 downto 0);	
imm_func<=Instr(29 downto 26);

process(rst,instr,zero)
begin
if(Rst='1') then
	      t_Cloud_ctrl <="00"; 
			t_PC_LdEn <= '0';
			t_PC_sel<='0';
			t_RF_WrEn<='0';
			t_RF_WrData_sel<='0';
			t_RF_B_sel<='0';
			t_ALU_func<="1111";
			t_Alu_Bin_Sel <='0';
			t_Mem_WrEn <="0000";
			t_Mem_ReadEn <="0000";
	elsif Instr(31 downto 26) ="100000" then --ALU 
				t_RF_WrData_sel<='0'; -- Fill write register with ALU data
				t_PC_sel <= '0'; -- Not a branch instruction
				t_RF_B_sel<='0'; -- We have three registers
				t_Alu_Bin_Sel <='0'; -- We do not have an immediate
				t_RF_WrEn<='1';--We want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="00";--dont care 
				t_PC_LdEn <= '1';
				t_ALU_func<=Instr(3 downto 0);
				
				
	elsif Instr(31 downto 26) = "110000" then --addi
				t_RF_WrData_sel<='0'; -- Fill write register with ALU data
				t_PC_sel <= '0'; -- Not a branch instruction
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='1'; -- Same
				t_RF_WrEn<='1';--We want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="00";--dont care 
				t_PC_LdEn <= '1';
				t_ALU_func<="0000";
				
	elsif Instr(31 downto 26) ="110010" then --andi
				t_RF_WrData_sel<='0'; -- Fill write register with ALU data
				t_PC_sel <= '0'; -- Not a branch instruction
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='1'; -- Same
				t_RF_WrEn<='1';--We want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="00";--dont care 
				t_PC_LdEn <= '1';
				t_ALU_func<="0010";
				
	elsif Instr(31 downto 26) ="110011" then --ori
				t_RF_WrData_sel<='0'; -- Fill write register with ALU data
				t_PC_sel <= '0'; -- Not a branch instruction
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='1'; -- Same
				t_RF_WrEn<='1';--We want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="00";--dont care 
				t_PC_LdEn <= '1';
				t_ALU_func<="0011";
				
	elsif Instr(31 downto 26) ="111000" then --li
				t_RF_WrData_sel<='0'; -- Fill write register with ALU data
				t_PC_sel <= '0'; -- Not a branch instruction
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='1'; -- Same
				t_RF_WrEn<='1';--We want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="01";--sign extend 
				t_PC_LdEn <= '1';
				t_ALU_func<="0000"; --Add the immediate to 'zero' register
				
	elsif Instr(31 downto 26) ="111001" then --lui
				t_RF_WrData_sel<='0'; -- Fill write register with ALU data
				t_PC_sel <= '0'; -- Not a branch instruction
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='1'; -- Same
				t_RF_WrEn<='1';--We want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="10";--shift and zero-fill 
				t_PC_LdEn <= '1';
				t_ALU_func<="0000"; --Add the immediate to 'zero' register
					
					
	elsif Instr(31 downto 26) ="111111" then --b
				t_RF_WrData_sel<='0'; -- Dont care
				t_PC_sel <= '1'; -- A branch instruction
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='0'; -- Dont care
				t_RF_WrEn<='0';--We do not want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="11";--shift and sign extend 
				t_PC_LdEn <= '1';
				t_ALU_func<="1111"; --dont care
			
		elsif Instr(31 downto 26) ="010001" then --bne
				t_PC_sel<='0';
				t_RF_WrData_sel<='0'; -- Dont care
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='0'; -- Dont care
				t_RF_WrEn<='0';--We do not want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="11";--shift and sign extend 
				t_PC_LdEn <= '1';
				t_ALU_func<="0001"; --RF_A minus RF_B (if zero they are equal)
				if(zero = '0') then --If they are not equal we branch
				 t_PC_sel <= '1'; -- Branch
				end if;
			
		elsif Instr(31 downto 26) ="010000" then --beq
				t_RF_WrData_sel<='0'; -- Dont care
				t_RF_B_sel<='1'; -- We have an immediate
				t_Alu_Bin_Sel <='0'; -- Dont care
				t_RF_WrEn<='0';--We do not want to write to a register
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				t_Cloud_ctrl <="11";--shift and sign extend 
				t_PC_LdEn <= '1';
				t_ALU_func<="0001"; --RF_A minus RF_B (if zero they are equal)
				if(zero = '1') then --If they are equal we branch
				 t_PC_sel <= '1'; -- Branch
				else
				 t_PC_sel <= '0'; -- Dont branch
				end if;
					
			
				
		elsif Instr(31 downto 26) ="001111" then --lw
				t_Cloud_ctrl <="01";--sign extend 
				t_PC_LdEn <= '1';
				t_PC_sel<='0';--Not a branch
				t_RF_WrEn<='1';--We want to write to a register
				t_RF_WrData_sel<='1'; -- Write from memory
				t_RF_B_sel<='1'; -- We have an immediate
				t_ALU_func<="0000"; --Add the immediate to RF_A to get the memory address
				t_Alu_Bin_Sel <='1'; -- Immediate
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				t_Mem_ReadEn <="1111"; --Read a whole word
				
		elsif Instr(31 downto 26) ="000011" then --lb
				t_Cloud_ctrl <="01";--sign extend 
				t_PC_LdEn <= '1';
				t_PC_sel<='0';--Not a branch
				t_RF_WrEn<='1';--We want to write to a register
				t_RF_WrData_sel<='1'; -- Write from memory
				t_RF_B_sel<='1'; -- We have an immediate
				t_ALU_func<="0000"; --Add the immediate to RF_A to get the memory address
				t_Alu_Bin_Sel <='1'; -- Immediate
				t_Mem_WrEn <="0000"; --Nothing to write to the memory
				--choose which byte to read
				if Byte_sel = "00" then
					t_Mem_ReadEn <="0001";
				elsif Byte_sel = "01" then
					t_Mem_ReadEn <="0010";
				elsif Byte_sel = "10" then
					t_Mem_ReadEn <="0100";
				elsif Byte_sel = "11" then
					t_Mem_ReadEn <="1000";
				end if;
				
		elsif Instr(31 downto 26) = "011111" then --sw
				t_Cloud_ctrl <="01";--sign extend 
				t_PC_LdEn <= '1';
				t_PC_sel<='0';--Not a branch
				t_RF_WrEn<='0';--We do not want to write to a register
				t_RF_WrData_sel<='0'; -- Dont care
				t_RF_B_sel<='1'; -- We have an immediate
				t_ALU_func<="0000"; --Add the immediate to RF_A to get the memory address
				t_Alu_Bin_Sel <='1'; -- Immediate
				t_Mem_WrEn <="1111"; --Write a whole word
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
				
		elsif Instr(31 downto 26) ="000111" then --sb
				t_Cloud_ctrl <="01";--sign extend 
				t_PC_LdEn <= '1';
				t_PC_sel<='0';--Not a branch
				t_RF_WrEn<='0';--We do not want to write to a register
				t_RF_WrData_sel<='0'; -- Dont care
				t_RF_B_sel<='1'; -- We have an immediate
				t_ALU_func<="0000"; --Add the immediate to RF_A to get the memory address
				t_Alu_Bin_Sel <='1'; -- Immediate
				--choose which byte to write
				if Byte_sel = "00" then
					t_Mem_WrEn <="0001";
				elsif Byte_sel = "01" then
					t_Mem_WrEn <="0010";
				elsif Byte_sel = "10" then
					t_Mem_WrEn <="0100";
				elsif Byte_sel = "11" then
					t_Mem_WrEn <="1000";
				end if;
				t_Mem_ReadEn <="0000"; --Nothing to read from memory
			
			else
				t_Cloud_ctrl <="00"; 
				t_PC_LdEn <= '1';
				t_PC_sel<='0';
				t_RF_WrEn<='0';
				t_RF_WrData_sel<='0';
				t_RF_B_sel<='0';
				t_ALU_func<="1111";
				t_Alu_Bin_Sel <='0';
				t_Mem_WrEn <="0000";
				t_Mem_ReadEn <="0000";
			
			
		end if;

end process;

Cloud_ctrl<=t_Cloud_ctrl; 
PC_LdEn<=t_PC_LdEn;
PC_sel<=t_PC_sel;
RF_WrEn<=t_RF_WrEn;
RF_WrData_sel<=t_RF_WrData_sel;
RF_B_sel<=t_RF_B_sel;
ALU_func<=t_ALU_func;
Alu_Bin_Sel <=t_ALU_Bin_sel;
Mem_WrEn <=t_Mem_WrEn;
Mem_ReadEn <=t_Mem_ReadEn;

end Behavioral;

