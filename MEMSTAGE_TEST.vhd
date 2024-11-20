--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:38:50 04/15/2023
-- Design Name:   
-- Module Name:   /home/ise/Lab1/MEMSTAGE_TEST.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGE_TEST IS
END MEMSTAGE_TEST;
 
ARCHITECTURE behavior OF MEMSTAGE_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         clk : IN  std_logic;
         Mem_WrEn : IN std_logic_vector(3 DOWNTO 0);
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Mem_WrEn : std_logic_vector(3 DOWNTO 0) := (others => '0');
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          clk => clk,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		--peripou 15 nsec gia na grapsei sthn RAM
		--prwta diabazei sta 2 nsec
      wait for 100 ns;	
		
		--write
      Mem_WrEn <= "1111";
		ALU_MEM_Addr <= "00000000000000000000000000000000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0001";
		ALU_MEM_Addr <= "00000000000000000000000000010000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0010";
		ALU_MEM_Addr <= "00000000000000000000000000100000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0100";
		ALU_MEM_Addr <= "00000000000000000000000000110000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "1000";
		ALU_MEM_Addr <= "00000000000000000000000001000000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		--read
		Mem_WrEn <= "0000";
		ALU_MEM_Addr <= "00000000000000000000000000000000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0000";
		ALU_MEM_Addr <= "00000000000000000000000000010000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0000";
		ALU_MEM_Addr <= "00000000000000000000000000100000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0000";
		ALU_MEM_Addr <= "00000000000000000000000000110000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;
		
		Mem_WrEn <= "0000";
		ALU_MEM_Addr <= "00000000000000000000000001000000";
		MEM_DataIn <=  "11000000001100000000110000000011";
		wait for 10 ns;

      wait;
   end process;

END;
