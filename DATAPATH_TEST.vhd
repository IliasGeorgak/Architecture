--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:02:59 04/21/2023
-- Design Name:   
-- Module Name:   /home/ise/Lab1/DATAPATH_TEST.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_TEST IS
END DATAPATH_TEST;
 
ARCHITECTURE behavior OF DATAPATH_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         Cloud_Ctrl : IN  std_logic_vector(1 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         Mem_WrEn : IN  std_logic_vector(3 downto 0);
         Mem_ReadEn : IN  std_logic_vector(3 downto 0);
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instruction : OUT  std_logic_vector(31 downto 0);
			Byte_sel : OUT std_logic_vector (1 downto 0);
         ALU_Zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal Cloud_Ctrl : std_logic_vector(1 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal Mem_WrEn : std_logic_vector(3 downto 0) := (others => '0');
   signal Mem_ReadEn : std_logic_vector(3 downto 0) := (others => '0');
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Instruction : std_logic_vector(31 downto 0);
	signal Byte_sel : std_logic_vector(1 downto 0);
   signal ALU_Zero : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          Cloud_Ctrl => Cloud_Ctrl,
          RF_WrEn => RF_WrEn,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          Mem_ReadEn => Mem_ReadEn,
          Reset => Reset,
          Clk => Clk,
          Instruction => Instruction,
			 Byte_sel => Byte_sel,
          ALU_Zero => ALU_Zero
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
