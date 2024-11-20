--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:18:14 04/10/2023
-- Design Name:   
-- Module Name:   /home/ise/Shared_folder/Organwsh/DECSTAGE_TEST.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DECSTAGE_TEST IS
END DECSTAGE_TEST;
 
ARCHITECTURE behavior OF DECSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
			Reset : IN std_logic;
			Cloud_ctrl: IN std_logic_vector(1 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';
	signal Reset : std_logic := '0';
	signal Cloud_ctrl: std_logic_vector(1 downto 0) := (others=>'0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
			 Reset => Reset,
			 Cloud_ctrl=> Cloud_ctrl,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
		--Perimenoume to Mem out sthn exodo A kai 0 sthn B tou RF kai to immediate me zero fill
      Instr<="10000000010000100000011101110000";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='1';
		RF_B_sel<='0';
		Cloud_ctrl<="00"; --zero-fill
      wait for 100 ns;	
		
		--Perimenoume to Mem_out(apo prin) sthn exodo A kai sthn B tou RF kai to immediate me sign extend
      Instr<="10000000010000100001011101110000";
		RF_WrEn<='0';
		ALU_out<="00000000000000000000000000111111";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='0';
		RF_B_sel<='0';
		Cloud_ctrl<="01"; --sign extend
      wait for 100 ns;	
		
		--Perimenoume to 0 sthn exodo A kai ALU_out sthn B tou RF kai to immediate me shift kai zero fill
		Instr<="10000000000000100001011101110000";
		RF_WrEn<='1';
		ALU_out<="11111111111111111111111111111110";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='0';
		RF_B_sel<='0';
		Cloud_ctrl<="10"; --shift zero fill
      wait for 100 ns;	
		
		--Perimenoume to 0 sthn exodo A kai ALU_out(prohgoumeno) sthn B tou RF kai to immediate me shift kai sign extend
		Instr<="10000000000000110001011101110000";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000010";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='0';
		RF_B_sel<='0';
		Cloud_ctrl<="11"; --shift sign extend
      wait for 100 ns;	
		
		--Perimenoume to prohgoumeno ALU_out(..11110) sth B k ..10 sthn A tou RF kai to immediate me zero fill
		Instr<="10000000011000100001011101110000";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000001110000010";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		Cloud_ctrl<="00";
      wait for 100 ns;	

      --Perimenoume to prohgoumeno ALU_out(....10) sthn  B kai to prohgoumeno ALU_out sthn A tou RF kai to immediate me sign extend
		Instr<="10000000011000101001011101110000";
		RF_WrEn<='0';
		ALU_out<="00000000000000000000001110000010";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		Cloud_ctrl<="01";	
		wait for 100ns;

		--Perimenoume to prohgoumeno ALU_out(....10) sthn  B kai to prohgoumeno ALU_out sthn A tou RF kai to immediate me shift kai sign extend
		Instr<="10000000011000101001011101110000";
		RF_WrEn<='0';
		ALU_out<="00000000000000000000001110000010";
		MEM_out<="00000000000000000000000000000011";
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		Cloud_ctrl<="11";	

      -- insert stimulus here 

      wait;
   end process;

END;
