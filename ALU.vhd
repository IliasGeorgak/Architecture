----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:17:08 03/16/2023 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           OP : in  STD_LOGIC_VECTOR (3 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0);
           ZERO : out  STD_LOGIC;
           COUT : out  STD_LOGIC;
           OVF : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal OUT_expanded : STD_LOGIC_VECTOR (32 DOWNTO 0);
signal TEMP: STD_LOGIC_VECTOR (2 DOWNTO 0);

begin
P1: process(A,B,OP,OUT_expanded,TEMP)
	begin
	
		OVF<='0';
		COUT<='0';
		
		case OP is 
			when "0000" =>
				OUT_expanded<= ("0" & A)+("0" & B);
				TEMP<= A(31) & B(31) & OUT_expanded(31);
				if (TEMP = "001") or (TEMP="110") then
					OVF<='1';
				end if;
				
			when "0001" =>
				OUT_expanded<= ("0" & A)-("0" & B);
				TEMP<= A(31) & B(31) & OUT_expanded(31);
				if (TEMP = "011") or (TEMP="100") then
					OVF<='1';
				end if;
				
				
			when "0010" =>
				OUT_expanded<="0" & (A and B);
				
			when "0011" =>
				OUT_expanded<="0" & (A or B);
				
			when "0100" =>
				OUT_expanded<="0" & (not A);
				
			when "1010" => --sra
				OUT_expanded<="0" & ("0"& A(31 downto 1));
				
			when "1000" => --srl
				OUT_expanded<="0" & ("0" & A(31 downto 1));
				
			when "1001" => --sll
				OUT_expanded<="0" & (A(30 downto 0) & "0");
				
			when "1100" =>
				OUT_expanded<="0" & (A(30 downto 0) & A(31));
			
			when "1101" =>
				OUT_expanded<="0" & (A(0)& A(31 downto 1));
			when others =>
				OUT_expanded<= "000000000000000000000000000000000";
		end case;
			
		COUT<=OUT_expanded(32);
		
		if (OUT_expanded(31 downto 0) = "00000000000000000000000000000000") then 
			zero<='1';
		else
			zero<='0';
		end if;
		
		OUTPUT<=OUT_expanded(31 downto 0);
	end process;
end Behavioral;