# 8-Bit CPU in Verilog

### A custom 8-bit single-cycle CPU designed from scratch in Verilog, synthesized and verified on an Intel DE10-Lite FPGA (MAX 10) using Quartus Prime.

<p align="center">
  <img src="demo.gif" alt="Demo GIF" width="500"/>
</p>

### Overview

This project implements a complete 8-bit processor: ALU, register file, instruction memory, and control unit, each built up module by module, each independently simulated and verified before integration. It was built to gain hands-on understanding of digital logic design, Verilog, and FPGA deployment, going from individual combinational/sequential circuits through a working fetch-decode-execute system running on real hardware.

<p align="center">
  <img src="board_photo.JPG" alt="FPGA Board Photo" width="500"/>
</p>

### Architecture

<p align="center">
  <img src="docs/cpu_architecture_diagram.png" alt="ARCHITECTURE" width="500"/>
</p>

The CPU uses a single-cycle architecture where every instruction completes fetch, decode, execute, and write-back within one clock cycle. The program counter drives the instruction memory, the control unit decodes each fetched instruction into ALU and register-file control signals, and the register file and ALU exchange operands and results each cycle.

### Instruction Set Architecture

8-bit instruction format: `[opcode: 3 bits]` `[reg: 2 bits]` `[reg2/immediate: 3 bits]`

This is a 2-address format with the destination register doubling as one of the two operands (e.g., `ADD R0, R1` means $R0 \leftarrow R0 + R1$), which lets a full instruction (opcode + two operand references) fit in 8 bits.

| Opcode | Mnemonic | Format | Description |
| :--- | :--- | :--- | :--- |
| `000` | **HALT/NOP** | - | No operation, PC freezes |
| `001` | **ADD** | `ADD Rd, Rs` | $Rd \leftarrow Rd + Rs$ |
| `010` | **SUB** | `SUB Rd, Rs` | $Rd \leftarrow Rd - Rs$ |
| `011` | **AND** | `AND Rd, Rs` | $Rd \leftarrow Rd \ \& \ Rs$ |
| `100` | **OR** | `OR Rd, Rs` | $Rd \leftarrow Rd \mid Rs$ |
| `101` | **LOAD** | `LOAD Rd, #imm` | $Rd \leftarrow \text{immediate}$ |
| `110/111` | *(reserved)* | - | No operation (safe default) |

### Features

* Single-cycle fetch-decode-execute architecture
* 4 general 8-bit registers (R0–R3)
* 16-word instruction memory (ROM)
* Dual-port combinational register reads, gated synchronous writes
* ALU supporting ADD/SUB/AND/OR with zero and carry-out flags
* Real-time output on physical LEDs and 7-segment hex displays
* Every module independently verified with a self-checking testbench

### Bugs Found and Fixed

**Opcode-0 Aliasing:** In the original instruction encoding, opcode `000` meant `LOAD`. Verilog memory defaults to all zeros when not explicitly initialized, and unused instruction memory slots were explicitly set to `8'b000_00_000` as a safe placeholder. Since the program counter never stops incrementing on its own, it eventually walks into this unused memory, and `000_00_000` is decoded as a real, valid instruction: `LOAD R0, #0`, silently overwriting a correct result of 8 back down to 0.
