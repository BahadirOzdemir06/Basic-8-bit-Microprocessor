# Basic-8-bit-Microprocessor
VHDL ile 8-bit mikroişlemci tasarımı/ 8-bit Microprocessor Design with VHDL


📁 computer.vhd
│   --> Top-level entity. Integrates CPU, memory, and I/O peripherals.
│   --> Üst seviye modül. CPU, bellek ve çevre birimlerini birleştirir.
│
├── 📁 CPU.vhd
│   │   --> Central Processing Unit: Coordinates fetch-decode-execute.
│   │   --> Merkezi İşlem Birimi: Fetch-decode-execute döngüsünü yönetir.
│   │
│   ├── control_unit.vhd
│   │   --> Generates control signals based on instruction opcode.
│   │   --> Komutlara göre kontrol sinyalleri üretir.
│   │
│   └── data_paths.vhd
│       │   --> Register file and internal data flow control.
│       │   --> Register yapısı ve veri akışı kontrolü.
│       │
│       └── ALU.vhd
│           --> Performs arithmetic and logic operations (ADD, SUB, AND, OR, etc.)
│           --> Aritmetik ve mantıksal işlemleri gerçekleştirir (TOPLA, ÇIKAR vb.)
│
├── 📁 memory.vhd
│   │   --> Combines all memory blocks: program + data + I/O.
│   │   --> Tüm bellek modüllerini bir araya getirir: program + veri + çıkış.
│
│   ├── program_memory.vhd
│   │   --> Read-only memory for instructions.
│   │   --> Komutlar için salt okunur bellek (ROM).
│   │
│   ├── data_memory.vhd
│   │   --> General-purpose read/write data memory (RAM).
│   │   --> Genel amaçlı veri belleği (RAM).
│   │
│   └── output_ports.vhd
│       --> Interfaces with external world; writes result to output bus.
│       --> Dış dünyayla iletişim kurar; veriyi çıkış portlarına aktarır.
        

     
