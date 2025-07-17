# Basic-8-bit-Microprocessor
VHDL ile 8-bit mikroişlemci tasarımı/ 8-bit Microprocessor Design with VHDL


computer.vhd          --> Top-level entity
│
├── CPU.vhd           --> Central Processing Unit
│   ├── control_unit.vhd      --> Instruction decoding & control signals
│   └── data_paths.vhd        --> Registers, buses, ALU integration
│       └── ALU.vhd           --> Arithmetic and logic operations
│
├── memory.vhd        --> Memory subsystem wrapper
│   ├── program_memory.vhd    --> ROM for instruction storage
│   ├── data_memory.vhd       --> RAM for general-purpose data
│   └── output_ports.vhd      --> Output ports (I/O interface)


     
