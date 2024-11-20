----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:11 03/16/2023 
-- Design Name: 
-- Module Name:    regist - Behavioral 
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

entity regist is
	 GENERIC (N : INTEGER := 32) ;
    Port ( CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  Reset : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (N-1 downto 0));
end regist;


architecture Behavioral of regist is

signal dout_temp: STD_LOGIC_VECTOR(N-1 DOWNTO 0):= "00000000000000000000000000000000";

begin
	PROCESS
		BEGIN
		--wait for clock positive
		WAIT UNTIL CLK'EVENT AND CLK = '1';
		--check if write enable is high
      if Reset = '1' then
			dout_temp <= "00000000000000000000000000000000";
		else
			if WE = '1' then
				dout_temp <= Data;
			else
			--do nothing
				dout_temp <= dout_temp;
			end if;
		end if;
	END PROCESS;
Dout <= dout_temp;

end Behavioral;

