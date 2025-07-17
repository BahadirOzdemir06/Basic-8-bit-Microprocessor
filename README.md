# Basic-8-bit-Microprocessor
VHDL ile 8-bit mikroişlemci tasarımı/ 8-bit Microprocessor Design with VHDL


Design Hierarchy:

| Module                     | Submodules                                      | Description                   |
| -------------------------- | ----------------------------------------------- | ----------------------------- |
| `computer.vhd`             | `CPU`, `memory`                                 | Top-level entity              |
| ├── `CPU.vhd`              | `control_unit`, `data_paths`                    | Main CPU core logic           |
| │   ├── `control_unit.vhd` | –                                               | Controls data path operations |
| │   └── `data_paths.vhd`   | `ALU`                                           | Data flow architecture        |
| │          └── `ALU.vhd`   | –                                               | Arithmetic Logic Unit         |
| └── `memory.vhd`           | `program_memory`, `data_memory`, `output_ports` | Memory and I/O interface      |
| ├── `program_memory.vhd`   | –                                               | Instruction ROM               |
| ├── `data_memory.vhd`      | –                                               | General purpose RAM           |
| └── `output_ports.vhd`     | –                                               | Output port module            |

