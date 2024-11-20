----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:56:54 03/19/2023 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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

--package arrays is
--		type my_array is array (31 downto 0) of std_logic_vector(31 downto 0);
--end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;
use work.arrays.all;

entity register_file is
GENERIC ( N : INTEGER := 31; K : INTEGER := 4 ) ;
    Port ( Ard1 : in  STD_LOGIC_VECTOR (K downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (K downto 0);
           Awr : in  STD_LOGIC_VECTOR (K downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (N downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (N downto 0);
           Din : in  STD_LOGIC_VECTOR (N downto 0):="00000000000000000000000000000000";
           WrEn : in  STD_LOGIC;
			  Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end register_file;

architecture Behavioral of register_file is

	signal o_and : STD_LOGIC_VECTOR(N DOWNTO 0);
	signal regNum: STD_LOGIC_VECTOR(N DOWNTO 0);
	signal t_regDout : my_array;
	signal o_compmod_1: STD_LOGIC;
	signal o_compmod_2: STD_LOGIC;
	signal o_mux32to1_1: STD_LOGIC_VECTOR(N DOWNTO 0);
	signal o_mux32to1_2: STD_LOGIC_VECTOR(N DOWNTO 0);

	COMPONENT decoder
	PORT(
		input : IN std_logic_vector(K downto 0);          
		output : OUT std_logic_vector(N downto 0)
		);
	END COMPONENT;

	COMPONENT regist
	PORT(
		CLK : IN std_logic;
		WE : IN std_logic;
		Data : IN std_logic_vector(31 downto 0);
		Reset : IN std_logic;          
		Dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT mux32to1 
        generic (bus_width : integer := 32;
                sel_width : integer := 5);
        port (  i : in my_array;
                sel : in std_logic_vector(sel_width - 1 downto 0);
                o : out std_logic_vector(bus_width - 1 downto 0));
	end component;
	
	COMPONENT compare_mod
	PORT(
		ard : IN std_logic_vector(4 downto 0);
		awr : IN std_logic_vector(4 downto 0);
		WE : IN std_logic;
		Reset : IN std_logic;
		o : OUT std_logic
		);
	END COMPONENT;

	COMPONENT mux2to1
	PORT(
		in1 : IN std_logic_vector(31 downto 0);
		in2 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
begin

	Inst_decoder: decoder PORT MAP(
		input => Awr,
		output => regNum
	);
	
	process(o_and, regNum, WrEn, Reset)
		begin
			o_and(0) <= '0';

			and_loop : for i in 1 to 31 loop
						  o_and(i) <= (WrEn and regNum(i)); 
						  end loop;
	end process;
	
	regGen: for i in 0 to N generate
		
		regG: regist PORT MAP(
		CLK => Clk,
		WE => o_and(i),
		Data => Din,
		Reset => Reset,
		Dout => t_regDout(i)
		);
	end generate regGen;
	
	Inst_mux32to1_1: mux32to1 PORT MAP(
		i => t_regDout,
		sel=> Ard1,
		o => o_mux32to1_1 
	);
	
	Inst_mux32to1_2: mux32to1 PORT MAP(
		i => t_regDout,
		sel=> Ard2,
		o => o_mux32to1_2
	);
	
	Inst_compare_mod1: compare_mod PORT MAP(
		ard => Ard1,
		awr => Awr,
		WE => WrEn,
		Reset => Reset,
		o => o_compmod_1
	);
	
	Inst_compare_mod2: compare_mod PORT MAP(
		ard => Ard2,
		awr => Awr,
		WE => WrEn,
		Reset => Reset,
		o => o_compmod_2
	);
	
	Inst_mux2to1_1: mux2to1 PORT MAP(
		in1 => o_mux32to1_1,
		in2 => Din,
		sel => o_compmod_1,
		o => Dout1
	);
	
	Inst_mux2to1_2: mux2to1 PORT MAP(
		in1 => o_mux32to1_2,
		in2 => Din,
		sel => o_compmod_2,
		o => Dout2
	);

end Behavioral;