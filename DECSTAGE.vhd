----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:43:01 04/08/2023 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
	GENERIC(N: INTEGER := 31; K: INTEGER := 4);
    Port ( Instr  : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel  : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  Reset : in STD_LOGIC;
			  Cloud_ctrl: in std_logic_vector(1 downto 0);
           Immed  : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B  : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

signal o_mux_wr: std_logic_vector(N downto 0);
signal i_rd1: std_logic_vector(K downto 0);
signal i_rd2: std_logic_vector(K downto 0);
signal o_mux_rd2: std_logic_vector(K downto 0);

COMPONENT mux2to1
PORT(
		in1 : IN std_logic_vector(31 downto 0);
		in2 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		o : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT register_file
	PORT(
		Ard1 : IN std_logic_vector(4 downto 0);
		Ard2 : IN std_logic_vector(4 downto 0);
		Awr : IN std_logic_vector(4 downto 0);
		Din : IN std_logic_vector(31 downto 0);
		WrEn : IN std_logic;
		Reset : IN std_logic;
		Clk : IN std_logic;          
		Dout1 : OUT std_logic_vector(31 downto 0);
		Dout2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT mux_2to1_5bit
	PORT(
		in1 : IN std_logic_vector(4 downto 0);
		in2 : IN std_logic_vector(4 downto 0);
		sel : IN std_logic;          
		o : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CLOUDAKI
	PORT(
		CONTROL : IN std_logic_vector(1 downto 0);
		INSTR : IN std_logic_vector(15 downto 0);          
		IMMED : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
begin

Inst_mux_2to1_5bit: mux_2to1_5bit PORT MAP(
		in1 => Instr(15 downto 11),
		in2 => Instr(20 downto 16),
		sel => RF_B_sel,
		o => o_mux_rd2
	);

Inst_mux2to1: mux2to1 PORT MAP(
		in1 => ALU_out,
		in2 => MEM_out,
		sel => RF_WrData_sel,
		o => o_mux_wr
	);
	
Inst_register_file: register_file PORT MAP(
		Ard1 => Instr(25 downto 21),
		Ard2 => o_mux_rd2,
		Awr => Instr(20 downto 16),
		Dout1 => RF_A,
		Dout2 => RF_B,
		Din => o_mux_wr,
		WrEn => RF_WrEn,
		Reset => Reset,
		Clk => Clk
	);

Inst_CLOUDAKI: CLOUDAKI PORT MAP(
		CONTROL => Cloud_ctrl,
		INSTR => Instr(15 downto 0),
		IMMED => Immed
	);


end Behavioral;

