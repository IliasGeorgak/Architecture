----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:52:24 03/17/2023 
-- Design Name: 
-- Module Name:    compare_mod - Behavioral 
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

entity compare_mod is
    Port ( ard : in  STD_LOGIC_VECTOR (4 downto 0);
           awr : in  STD_LOGIC_VECTOR (4 downto 0);
			  WE : in STD_LOGIC;
			  Reset : in STD_LOGIC;
           o : out  STD_LOGIC);
end compare_mod;

architecture Behavioral of compare_mod is

signal o_temp: STD_LOGIC;

begin
	process(ard, awr, WE, Reset)
		begin
		if reset = '1' then
			o_temp <= '0';
		elsif awr = "00000" then
			o_temp <= '0';
		elsif WE = '1' and ard = awr then
			o_temp <= '1';
		else
			o_temp <= '0';
		end if;
	end process;
o <= o_temp;
end Behavioral;

