--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:48:53 03/19/2023
-- Design Name:   
-- Module Name:   /home/ise/Lab1/rf_test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register_file
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
 
ENTITY rf_test IS
END rf_test;
 
ARCHITECTURE behavior OF rf_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT register_file
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
			Reset : in  STD_LOGIC;
         Clk : IN  std_logic
        );
    END COMPONENT;

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
	signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register_file PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
			 Reset => Reset,
          Clk => Clk
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
		Reset <= '1';
     
      wait for Clk_period*10;
		Reset <= '0';
      Ard1 <= "01000";
		Ard2 <= "00000";
		Awr <= "01000";
		Din <= "11000000000000000000000000000000";
		WrEn <= '1';
		wait for Clk_period*5;
		
		Ard1 <= "01000";
		Ard2 <= "00000";
		Awr <= "01000";
		Din <= "11110000000000000000000000000000";
		WrEn <= '0';
		wait for Clk_period*5;
		
		Ard1 <= "01000";
		Ard2 <= "00111";
		Awr <= "00111";
		Din <= "11000000000000111111100000001111";
		WrEn <= '1';
		wait for Clk_period*5;
		
		Ard1 <= "01000";
		Ard2 <= "00000";
		Awr <= "00000";
		Din <= "11000000000110000000000000110000";
		WrEn <= '1';
		wait for Clk_period*5;
		
		Ard1 <= "01100";
		Ard2 <= "00000";
		Awr <= "01100";
		Din <= "11000000000000000000000000011111";
		WrEn <= '0';
		wait for Clk_period*5;
		
		Ard1 <= "10000";
		Ard2 <= "00111";
		Awr <= "00111";
		Din <= "11000000000000111111100000000000";
		WrEn <= '1';
		wait for Clk_period*5;
		
		Ard1 <= "01000";
		Ard2 <= "00111";
		Awr <= "01110";
		Din <= "00010000000100000100001000000000";
		WrEn <= '1';
		wait for Clk_period*5;
		
		Ard1 <= "01000";
		Ard2 <= "01110";
		Awr <= "11111";
		Din <= "00010000000000000000000000000000";
		WrEn <= '0';
		wait for Clk_period*5;
		
		Ard1 <= "01000";
		Ard2 <= "11111";
		Awr <= "11111";
		Din <= "00010000000000000000000000000000";
		WrEn <= '0';
		wait for Clk_period*5;
		
		Reset <= '1';
		Ard1 <= "01000";
		Ard2 <= "11111";
		Awr <= "11000";
		Din <= "00010000000000001111000000000000";
		WrEn <= '1';
		wait for Clk_period*5;
		
      wait;
   end process;

END;
