## This is a processor designed in VHDL and simulated in Xilinx ISE

## Testing the project
 All necesssary test benches and coe files containing sample assembly programs to be loaded to the ROM are included with the project files.
 In order to simulate the processor yourself you will need either Xilinx or Vivado ISE (other tools could also do the job but have not been tested).
 You will also have to use the built in tools to generate the RAM and ROM memory modules.
  
## Instruction set
The instruction set given for this project is called CHARIS and is very closely related to MIPS. It was provided by the professor as a part of the Computer Architecture course and is rather simple. An image with a table containg the opcodes along with their charis representation and their function is included with the project.

## Design 
This project implemented all the necessary modules of a MIPS inspired CPU: A Fetch Instruction(IF) Stage, A Decode Stage(DEC), An Execution Stage(EXEC/ALU), Memory Access Stage(MEM) as well as a Control Module. The processor is 32-bit and executes assembly instructions loaded into the ROM through a .coe file(three sample ones have been provided). The Hardware description language used is VHDL. The processor can perform all expected functions including mathematical and logical operations, saving to and loading from memory, writing to and reading from registers, performing branching both conditional and unconditional. It also accounts for all basic data hazards.
