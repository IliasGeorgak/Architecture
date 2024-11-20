--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:56:02 04/11/2023
-- Design Name:   
-- Module Name:   /home/ise/Shared_folder/Organwsh/EXECSTAGE_TEST.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXECSTAGE
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
 
ENTITY EXECSTAGE_TEST IS
END EXECSTAGE_TEST;
 
ARCHITECTURE behavior OF EXECSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXECSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
			ALU_zero : OUT std_logic;
         ALU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
	signal ALU_zero : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXECSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
			 ALU_zero => ALU_zero,
          ALU_out => ALU_out
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      RF_A <="00000000000000000000000000000001";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='0';
		ALU_func <="0000";  
      wait for 20 ns;

		RF_A <="00000000000000000000000000000001";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='1';
		ALU_func <="0000";  
      wait for 20 ns;
		
		RF_A <="00000000000000000000000000000011";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000010";
		ALU_Bin_sel <='0';
		ALU_func <="0001";  
      wait for 20 ns;
		
		RF_A <="00000000000000000000000000000011";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000010";
		ALU_Bin_sel <='1';
		ALU_func <="0001";  
      wait for 20 ns;
		
		RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='0';
		ALU_func <="0010";  
      wait for 20 ns;	
		
		RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='1';
		ALU_func <="0010";  
      wait for 20 ns;
		
		RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='0';
		ALU_func <="0011";  
      wait for 20 ns;	
		
		RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='1';
		ALU_func <="0011";  
      wait for 20 ns;
		
		RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='0';
		ALU_func <="0100";  
      wait for 20 ns;	
		
		RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000011";
		ALU_Bin_sel <='0';
		ALU_func <="0101";  
      wait for 20 ns;

      RF_A <="00000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000001111";
		ALU_Bin_sel <='0';
		ALU_func <="1001";  
      wait for 20 ns;		
		
		RF_A <="10000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000001111";
		ALU_Bin_sel <='0';
		ALU_func <="1000";  
      wait for 20 ns;	

		RF_A <="10000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000001111";
		ALU_Bin_sel <='1';
		ALU_func <="1000";  
      wait for 20 ns;
		
		RF_A <="10000000000000000000000000000111";
      RF_B <="00000000000000000000000000000001";
      Immed <="00000000000000000000000000000111";
		ALU_Bin_sel <='1';
		ALU_func <="0001";  
      wait for 20 ns;

      wait;
   end process;

END;
