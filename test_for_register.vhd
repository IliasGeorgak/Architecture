--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:53:49 03/19/2023
-- Design Name:   
-- Module Name:   /home/ise/Lab1/test_for_register.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: regist
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;
 
ENTITY test_for_register IS
END test_for_register;
 
ARCHITECTURE behavior OF test_for_register IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT regist
    PORT(
         CLK : IN  std_logic;
         WE : IN  std_logic;
         Data : IN  std_logic_vector(31 downto 0);
			Reset : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal WE : std_logic := '0';
   signal Data : std_logic_vector(31 downto 0) := (others => '0');
	signal Reset : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: regist PORT MAP (
          CLK => CLK,
          WE => WE,
          Data => Data,
			 Reset => Reset,
          Dout => Dout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

		WE <= '0';
		Data <= "00000000000000000000000000000011";
		wait for 100 ns;

      WE <= '1';
		Data <= "00000000000000000000000000000011";
		wait for 100 ns;
		
		WE <= '0';
		Data <= "11000000000000000000000000000000";
		wait for 100 ns;
		
		WE <= '1';
		Data <= "00000000000000001100000000000000";
		wait for 100 ns;
		
		WE <= '0';
		Data <= "10000000000000000000000000000001";
		wait for 100 ns;

		Reset <= '1';
		WE <= '1';
		Data <= "10000000000011110000000000000001";
		wait for 100 ns;
		
		WE <= '1';
		Data <= "10000000000000000000111100000001";
		wait for 100 ns;
      wait;
   end process;

END;
