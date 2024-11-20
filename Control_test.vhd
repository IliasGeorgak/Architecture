--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:35:13 04/22/2023
-- Design Name:   
-- Module Name:   /home/ilias/Documents/Xilinx/ProjectOrganwsh/Control_test.vhd
-- Project Name:  ProjectOrganwsh
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Control_test IS
END Control_test;
 
ARCHITECTURE behavior OF Control_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Zero : IN  std_logic;
         Byte_sel : IN  std_logic_vector(1 downto 0);
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         Cloud_ctrl : OUT  std_logic_vector(1 downto 0);
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ALU_bin_sel : OUT  std_logic;
         Mem_WrEn : OUT  std_logic_vector(3 downto 0);
         Mem_ReadEn : OUT  std_logic_vector(3 downto 0);
         RF_WrEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Zero : std_logic := '0';
   signal Byte_sel : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal Cloud_ctrl : std_logic_vector(1 downto 0);
   signal ALU_func : std_logic_vector(3 downto 0);
   signal ALU_bin_sel : std_logic;
   signal Mem_WrEn : std_logic_vector(3 downto 0);
   signal Mem_ReadEn : std_logic_vector(3 downto 0);
   signal RF_WrEn : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Instr => Instr,
          Clk => Clk,
          Rst => Rst,
          Zero => Zero,
          Byte_sel => Byte_sel,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Cloud_ctrl => Cloud_ctrl,
          ALU_func => ALU_func,
          ALU_bin_sel => ALU_bin_sel,
          Mem_WrEn => Mem_WrEn,
          Mem_ReadEn => Mem_ReadEn,
          RF_WrEn => RF_WrEn
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Rst<='1';
      wait for 20 ns;	

		Rst<='0';
		
		wait for 20 ns;
		
		Instr<="10000000001000100001100000110000"; --add
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="10000000001000100001100000111100"; --rol
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="11100000000000100001100011000011"; --li
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="11100100000000100001100011000011"; --lui
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="11000000001000100001100011000011"; --addi
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="11001100001000100001100011000011"; --ori
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="11001000001000100001100011000011"; --andi
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="01000000001000100001100011000011"; --beq
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="01000100001000100001100011000011"; --bne
		Zero<='1';
		
		wait for 20 ns;
		
		Instr<="00001100001000100001100011000011"; --lb
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="00011100001000100001100011000111"; --sb
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="00111100001000100001100011000011"; --lw
		Zero<='0';
		
		wait for 20 ns;
		
		Instr<="01111100001000100001100011000011"; --sw
		Zero<='0';
		
		wait for 20 ns;
		
		Rst<='1';
		
		wait for 20 ns;
		
		Rst<='0';
		
		wait for 20 ns;
		
		Instr<="00001100001000100001100011000011"; --lb
		Zero<='0';

      wait;
   end process;

END;
