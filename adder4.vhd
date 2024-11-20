----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:15 04/05/2023 
-- Design Name: 
-- Module Name:    adder4 - Behavioral 
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
use ieee.std_logic_unsigned.all;

entity adder4 is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output1 : out  STD_LOGIC_VECTOR (31 downto 0);
           output2 : out  STD_LOGIC_VECTOR (31 downto 0));
end adder4;

architecture Behavioral of adder4 is

signal o_temp : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(input, o_temp)
		begin
		
		o_temp <= input + "00000000000000000000000000000100";
		
	end process;
	
output1 <= o_temp;
output2 <= o_temp;

end Behavioral;

