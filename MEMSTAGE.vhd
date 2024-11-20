----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:36:49 04/12/2023 
-- Design Name: 
-- Module Name:    MEMSTAGE - Structural 
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

entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Structural of MEMSTAGE is

signal mem_enable_sig: STD_LOGIC;
signal o_mask_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);

COMPONENT MEM
  PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mem_mask
	PORT(
		i_Data : IN std_logic_vector(31 downto 0);
		sel : IN std_logic_vector(3 downto 0);          
		o_Data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin
	
	process(Mem_WrEn, mem_enable_sig)
	begin
	
	if Mem_WrEn = "0000" then
		mem_enable_sig <= '0';
	else 
		mem_enable_sig <= '1';
	end if;
	end process;

	your_instance_name : MEM
	PORT MAP (
    a => ALU_MEM_Addr(11 downto 2),
    d => o_mask_sig,
    clk => clk,
    we => mem_enable_sig,
    spo => MEM_DataOut
  );
  
  Inst_mem_mask: mem_mask PORT MAP(
		i_Data => MEM_DataIn,
		sel => Mem_WrEn,
		o_Data => o_mask_sig
	);

end Structural;

