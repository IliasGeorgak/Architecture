----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:20:19 04/21/2023 
-- Design Name: 
-- Module Name:    mem_mask - Behavioral 
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

entity mem_mask is
    Port ( i_Data : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           o_Data : out  STD_LOGIC_VECTOR (31 downto 0));
end mem_mask;

architecture Behavioral of mem_mask is

signal o_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);

begin
	process(i_Data, sel)
		begin
	
		if sel = "0000" then
			o_sig <= "00000000000000000000000000000000";
		elsif sel = "0001" then
			o_sig <= "000000000000000000000000" & i_Data(7 downto 0);
		elsif sel = "0010" then
			o_sig <= "0000000000000000" & i_Data(15 downto 8) & "00000000";
		elsif sel = "0100" then
			o_sig <= "00000000" & i_Data(23 downto 16) & "0000000000000000";
		elsif sel = "1000" then
			o_sig <= i_Data(31 downto 24) & "000000000000000000000000";
		elsif sel = "1111" then
			o_sig <= i_Data;
		end if;
		
	end process;
		
O_Data <= o_sig;

end Behavioral;

