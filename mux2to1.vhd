----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:39:35 03/17/2023 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;
--use work.multiplexer.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2to1 is
    generic (bus_width : positive := 32);
    port ( 
					 in1 : in std_logic_vector(bus_width - 1 downto 0);
					 in2 : in std_logic_vector(bus_width - 1 downto 0);
                sel : in std_logic;
                o : out std_logic_vector(bus_width - 1 downto 0));
end mux2to1;

architecture Behavioral of mux2to1 is

signal o_temp : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(in1, in2, sel)
		begin

		if sel = '0' then
			o_temp <= in1;
		elsif sel = '1' then
			o_temp <= in2;
		end if;
	end process;
o <= o_temp;
end Behavioral;

