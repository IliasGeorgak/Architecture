----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:33 04/08/2023 
-- Design Name: 
-- Module Name:    mux_2to1_4bit - Behavioral 
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

entity mux_2to1_5bit is
    Port ( in1 : in  STD_LOGIC_VECTOR (4 downto 0);
           in2 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           o : out  STD_LOGIC_VECTOR (4 downto 0));
end mux_2to1_5bit;

architecture Behavioral of mux_2to1_5bit is

signal o_temp : STD_LOGIC_VECTOR (4 downto 0);

begin
	process(in1, in2, sel)
		begin
		--output <= "00000000000000000000000000000000";

		if sel = '0' then
			o_temp <= in1;
		elsif sel = '1' then
			o_temp <= in2;
		end if;
	end process;
o <= o_temp;

end Behavioral;

