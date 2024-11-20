----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:54 04/05/2023 
-- Design Name: 
-- Module Name:    adder4i - Behavioral 
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

entity adder4i is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           immed : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end adder4i;

architecture Behavioral of adder4i is

signal o_temp : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(input, immed, o_temp)
		begin
		
		o_temp <= input + immed;
		
	end process;
	
output <= o_temp;

end Behavioral;

