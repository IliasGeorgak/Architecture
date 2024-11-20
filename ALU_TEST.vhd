--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:43:03 03/16/2023
-- Design Name:   
-- Module Name:   /home/ilias/Documents/Xilinx/ALU/ALU_TEST.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_TEST IS
END ALU_TEST;
 
ARCHITECTURE behavior OF ALU_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         OP : IN  std_logic_vector(3 downto 0);
         OUTPUT : OUT  std_logic_vector(31 downto 0);
         ZERO : OUT  std_logic;
         COUT : OUT  std_logic;
         OVF : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal OP : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal OUTPUT : std_logic_vector(31 downto 0);
   signal ZERO : std_logic;
   signal COUT : std_logic;
   signal OVF : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          OP => OP,
          OUTPUT => OUTPUT,
          ZERO => ZERO,
          COUT => COUT,
          OVF => OVF
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 50 ns;	
		
		
		A <= "00000000000000000000000000000001";
		B <= "00000000000000000000000000000010";
		OP <= "0001"; --sub
		
      wait for 50 ns;
		
		A <= "01111111111111111111111111111111";
		B <= "01111111111111111111011111111111";
		OP <= "0010"; --and
		
		wait for 50 ns;
		
		A <= "00000000000000000000000000000010";
		B <= "00000000000000000000000000000010";
		OP <= "0001"; --sub zero
		
		wait for 50 ns;
		
		A <= "00000000000000000000000000000010";
		B <= "00000000000000000000000000000010";
		OP <= "0000"; --add
		
		wait for 50 ns;
		
		A <= "11111111111111111111111111111111";
		B <= "11111111111111111111111111111111";
		OP <= "0000"; --add with ovf
		
		wait for 50 ns;
		
		A <= "00000000000000000000000000000000";
		B <= "00000000000000000000000000000000";
		OP <= "0000"; --add all zero
		
		wait for 50 ns;
		
		A <= "00000000000100000000000000000001";
		B <= "00010000000000100000000000000010";
		OP <= "0011"; --or
		
		wait for 50 ns;
		
		A <= "00000011100000001000001000000000";
		B <= "00000000000000000000000000000000";
		OP <= "0100"; --not
		
		wait for 50 ns;
		
		
		A <= "01000011100000001000001000000001";
		B <= "00000000000000000000000000000000";
		OP <= "1000"; --srl
		
		wait for 50 ns;
		
		A <= "11000011100000001000001000000001";
		B <= "00000000000000000000000000000000";
		OP <= "1001"; --sll
		
		wait for 50 ns;
		
		A <= "01000011100000001000001000000001";
		B <= "00000000000000000000000000000000";
		OP <= "1010"; --sra/sla make up your mind
		
		wait for 50 ns;
		
		A <= "11000011100000001000001000000000";
		B <= "00000000000000000000000000000000";
		OP <= "1100"; --rol
		
		wait for 50 ns;
		
		A <= "11000011100000001000001000000000";
		B <= "00000000000000000000000000000000";
		OP <= "1101"; --ror
		
		wait for 50 ns;
		
		A <= "11000011100000001000001000000000";
		B <= "00000000000000000000000000000000";
		OP <= "1111"; --no op
		
		wait for 50 ns;
		
      wait;
   end process;

END;
