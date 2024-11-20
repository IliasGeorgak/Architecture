----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:22:58 04/22/2023 
-- Design Name: 
-- Module Name:    TOP_MOD - Structural 
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

entity TOP_MOD is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end TOP_MOD;

architecture Structural of TOP_MOD is

	--signals
	signal ALU_Zero_sig: STD_LOGIC;
	signal instr_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal Byte_sel_sig: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal PC_sel_sig: STD_LOGIC;
	signal PC_LdEn_sig: STD_LOGIC;
	signal RF_WrData_sel_sig: STD_LOGIC;
	signal RF_B_sel_sig: STD_LOGIC;
	signal Cloud_ctrl_sig: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal ALU_func_sig: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal ALU_bin_sel_sig: STD_LOGIC;
	signal Mem_WrEn_sig: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal Mem_ReadEn_sig: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal RF_WrEn_sig: STD_LOGIC;
	
	--components
	COMPONENT DATAPATH
	PORT(
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		RF_B_sel : IN std_logic;
		RF_WrData_sel : IN std_logic;
		Cloud_Ctrl : IN std_logic_vector(1 downto 0);
		RF_WrEn : IN std_logic;
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		Mem_WrEn : IN std_logic_vector(3 downto 0);
		Mem_ReadEn : IN std_logic_vector(3 downto 0);
		Reset : IN std_logic;
		Clk : IN std_logic;          
		Instruction : OUT std_logic_vector(31 downto 0);
		Byte_sel : OUT std_logic_vector(1 downto 0);
		ALU_Zero : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT CONTROL
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		Clk : IN std_logic;
		Rst : IN std_logic;
		Zero : IN std_logic;
		Byte_sel : IN std_logic_vector(1 downto 0);          
		PC_sel : OUT std_logic;
		PC_LdEn : OUT std_logic;
		RF_WrData_sel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		Cloud_ctrl : OUT std_logic_vector(1 downto 0);
		ALU_func : OUT std_logic_vector(3 downto 0);
		ALU_bin_sel : OUT std_logic;
		Mem_WrEn : OUT std_logic_vector(3 downto 0);
		Mem_ReadEn : OUT std_logic_vector(3 downto 0);
		RF_WrEn : OUT std_logic
		);
	END COMPONENT;
	
begin

	Inst_DATAPATH: DATAPATH PORT MAP(
		PC_sel => PC_sel_sig,
		PC_LdEn => PC_LdEn_sig,
		RF_B_sel => RF_B_sel_sig,
		RF_WrData_sel => RF_WrData_sel_sig,
		Cloud_Ctrl => Cloud_ctrl_sig,
		RF_WrEn => RF_WrEn_sig,
		ALU_Bin_sel => ALU_bin_sel_sig,
		ALU_func => ALU_func_sig,
		Mem_WrEn => Mem_WrEn_sig,
		Mem_ReadEn => Mem_ReadEn_sig,
		Reset => Reset,
		Clk => Clk,
		Instruction => instr_sig,
		Byte_sel => Byte_sel_sig,
		ALU_Zero => ALU_Zero_sig
	);
	
	Inst_CONTROL: CONTROL PORT MAP(
		Instr => instr_sig,
		Clk => Clk,
		Rst => Reset,
		Zero => ALU_Zero_sig,
		Byte_sel => Byte_sel_sig,
		PC_sel => PC_sel_sig,
		PC_LdEn => PC_LdEn_sig,
		RF_WrData_sel => RF_WrData_sel_sig,
		RF_B_sel => RF_B_sel_sig,
		Cloud_ctrl => Cloud_ctrl_sig,
		ALU_func => ALU_func_sig,
		ALU_bin_sel => ALU_bin_sel_sig,
		Mem_WrEn => Mem_WrEn_sig,
		Mem_ReadEn => Mem_ReadEn_sig,
		RF_WrEn => RF_WrEn_sig
	);

end Structural;

