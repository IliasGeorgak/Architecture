--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:21:16 04/21/2023
-- Design Name:   
-- Module Name:   /home/ise/Lab1/mem_mask_test.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mem_mask
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
 
 
ENTITY mem_mask_test IS
END mem_mask_test;
 
ARCHITECTURE behavior OF mem_mask_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mem_mask
    PORT(
         i_Data : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(3 downto 0);
         o_Data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_Data : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal o_Data : std_logic_vector(31 downto 0);
   
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mem_mask PORT MAP (
          i_Data => i_Data,
          sel => sel,
          o_Data => o_Data
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		i_Data <= "11000000001100000000110000000011";
		
		sel <= "1000";
		wait for 100 ns;	

      sel <= "0100";
		wait for 100 ns;	 
		
		sel <= "0010";
		wait for 100 ns;

		sel <= "0001";
		wait for 100 ns;	
		
		sel <= "1111";
		wait for 100 ns;
		
		sel <= "0000";
		wait for 100 ns;

      wait;
   end process;

END;
