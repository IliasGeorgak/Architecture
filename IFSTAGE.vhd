----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:05:55 04/15/2023 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
	 GENERIC ( N : INTEGER := 31) ;
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Structural of IFSTAGE is
--signals
signal o_pc: STD_LOGIC_VECTOR(N DOWNTO 0);
signal o_adder4_1: STD_LOGIC_VECTOR(N DOWNTO 0);
signal o_adder4_2: STD_LOGIC_VECTOR(N DOWNTO 0);
signal o_adder4i: STD_LOGIC_VECTOR(N DOWNTO 0);
signal o_mux: STD_LOGIC_VECTOR(N DOWNTO 0);
 
--components
	COMPONENT regist
	PORT(
		CLK : IN std_logic;
		WE : IN std_logic;
		Data : IN std_logic_vector(N downto 0);
		Reset : IN std_logic;
		Dout : OUT std_logic_vector(N downto 0)
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
	
	COMPONENT ROM
  PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
	
	COMPONENT adder4i
	PORT(
		input : IN std_logic_vector(31 downto 0);
		immed : IN std_logic_vector(31 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT adder4
	PORT(
		input : IN std_logic_vector(31 downto 0);          
		output1 : OUT std_logic_vector(31 downto 0);
		output2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin
	
	Inst_regist: regist PORT MAP(
		CLK => Clk,
		WE => PC_LdEn,
		Data => o_mux,
		Reset => Reset,
		Dout => o_pc 
	);
	
	Inst_mux2to1: mux2to1 PORT MAP(
		in1 => o_adder4_2,
		in2 => o_adder4i,
		sel =>PC_sel,
		o => o_mux
	);
  
  your_instance_name : ROM
  PORT MAP (
    a => o_pc(11 downto 2),
    spo => Instr
  );
  
  Inst_adder4: adder4 PORT MAP(
		input => o_pc,
		output1 => o_adder4_1,
		output2 => o_adder4_2
	);

	Inst_adder4i: adder4i PORT MAP(
		input => o_adder4_1,
		immed => PC_Immed,
		output => o_adder4i
	);
	
end Structural;
