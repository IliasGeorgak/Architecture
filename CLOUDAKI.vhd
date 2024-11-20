----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:01 04/12/2023 
-- Design Name: 
-- Module Name:    CLOUDAKI - Behavioral 
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

entity CLOUDAKI is
    Port ( CONTROL : in  STD_LOGIC_VECTOR (1 downto 0);
           INSTR : in  STD_LOGIC_VECTOR (15 downto 0);
           IMMED : out  STD_LOGIC_VECTOR (31 downto 0));
end CLOUDAKI;

architecture Behavioral of CLOUDAKI is
signal temp: std_logic_vector(31 downto 0);
begin

process(control,instr)
begin

case control is 
	when "00" =>                                --zero fill
		temp(31 downto 16) <= (others=>'0');
		temp(15 downto 0) <= instr;
	when "01" =>                                ----sign extend
		temp(15 downto 0)<= instr;
		temp( 31 downto 16) <= (others =>instr(15));
	when "10" =>                                 --shift left(16 bits) zero fill
		temp(31 downto 16) <= instr;
		temp(15 downto 0) <= (others=>'0'); 
	when  "11" =>                               --shift left(2bits) sign extend
		temp(17 downto 2) <= instr;                 
		temp (31 downto 18) <= (others=>instr(15));
		temp(1 downto 0)<="00";
	when others =>
	   temp<="00000000000000000000000000000000";
   end case;
end process;
Immed<=temp;


end Behavioral;

