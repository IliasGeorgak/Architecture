----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:55 04/10/2023 
-- Design Name: 
-- Module Name:    EXECSTAGE - Behavioral 
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

entity EXECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_zero : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end EXECSTAGE;

architecture Behavioral of EXECSTAGE is

COMPONENT mux2to1
	PORT(
		in1 : IN std_logic_vector(31 downto 0);
		in2 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		OP : IN std_logic_vector(3 downto 0);          
		OUTPUT : OUT std_logic_vector(31 downto 0);
		ZERO : OUT std_logic;
		COUT : OUT std_logic;
		OVF : OUT std_logic
		);
	END COMPONENT;	

signal mux_o: std_logic_vector(31 downto 0);

begin

Inst_mux2to1: mux2to1 PORT MAP(
		in1 => RF_B,
		in2 => Immed,
		sel => ALU_Bin_sel,
		o => mux_o
	);
	
Inst_ALU: ALU PORT MAP(
		A => RF_A,
		B => mux_o,
		OP => ALU_func,
		OUTPUT => ALU_out,
		ZERO => ALU_zero,
		COUT => open,
		OVF => open
	);	




end Behavioral;

