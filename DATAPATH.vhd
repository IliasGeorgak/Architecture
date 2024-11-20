----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:01:43 04/21/2023 
-- Design Name: 
-- Module Name:    DATAPATH - Structural 
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

entity DATAPATH is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           Cloud_Ctrl : in  STD_LOGIC_VECTOR (1 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WrEn : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_ReadEn : in  STD_LOGIC_VECTOR (3 downto 0);
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			  Byte_sel : out STD_LOGIC_VECTOR (1 downto 0);
           ALU_Zero : out  STD_LOGIC);
end DATAPATH;

architecture Structural of DATAPATH is

	signal ALU_Zero_sig: STD_LOGIC;
	signal immed_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal instr_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal RF_A_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal RF_B_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal ALU_out_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal mem_dout_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal mask_out_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);

	COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		Reset : IN std_logic;
		Clk : IN std_logic;          
		Instr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DECSTAGE
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		Clk : IN std_logic;
		Reset : IN std_logic;
		Cloud_ctrl : IN std_logic_vector(1 downto 0);          
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT EXECSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_zero : OUT std_logic;
		ALU_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MEMSTAGE
	PORT(
		clk : IN std_logic;
		Mem_WrEn : IN std_logic_vector(3 downto 0);
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);          
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT mem_mask
	PORT(
		i_Data : IN std_logic_vector(31 downto 0);
		sel : IN std_logic_vector(3 downto 0);          
		o_Data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


begin

	Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed => immed_sig,
		PC_sel => PC_sel,
		PC_LdEn => PC_LdEn,
		Reset => Reset,
		Clk => Clk,
		Instr => instr_sig
	);
	
	Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr => instr_sig,
		RF_WrEn => RF_WrEn,
		ALU_out => ALU_out_sig,
		MEM_out => mask_out_sig,
		RF_WrData_sel => RF_WrData_sel,
		RF_B_sel => RF_B_sel,
		Clk => Clk,
		Reset => Reset,
		Cloud_ctrl => Cloud_Ctrl,
		Immed => immed_sig,
		RF_A => RF_A_sig,
		RF_B => RF_B_sig
	);
	
	Inst_EXECSTAGE: EXECSTAGE PORT MAP(
		RF_A => RF_A_sig,
		RF_B => RF_B_sig,
		Immed => immed_sig,
		ALU_Bin_sel => ALU_Bin_sel,
		ALU_func => ALU_func,
		ALU_zero => ALU_Zero_sig,
		ALU_out => ALU_out_sig
	);

	Inst_MEMSTAGE: MEMSTAGE PORT MAP(
		clk => Clk,
		Mem_WrEn => Mem_WrEn,
		ALU_MEM_Addr => ALU_out_sig,
		MEM_DataIn => RF_B_sig,
		MEM_DataOut => mem_dout_sig
	);

	Inst_mem_mask: mem_mask PORT MAP(
		i_Data => mem_dout_sig,
		sel => Mem_ReadEn,
		o_Data => mask_out_sig
	);
	
	Instruction <= instr_sig;
	ALU_Zero <= ALU_Zero_sig;
	Byte_sel <= ALU_out_sig(1 downto 0);
	
end Structural;

