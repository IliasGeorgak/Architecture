library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;

package arrays is
        --type my_array is array(natural range <>, natural range <>) of std_logic;
		  type my_array is array (31 downto 0) of std_logic_vector(31 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;
use work.arrays.all;

entity mux32to1 is
        generic (bus_width : integer := 32;
                sel_width : integer := 5);
        port (  i : in my_array; --(2**sel_width - 1 downto 0, bus_width - 1 downto 0);
                sel : in std_logic_vector(sel_width - 1 downto 0);
                o : out std_logic_vector(bus_width - 1 downto 0));
end mux32to1;

architecture dataflow of mux32to1 is

signal o_temp : STD_LOGIC_VECTOR (31 downto 0);

	begin
		process(i,sel)
			begin
		

			for k in 31 downto 0 loop
				if sel = k then
					
				o_temp <= i(k);
				end if;
			end loop;
		end process;
	o <= o_temp;
			
end dataflow;