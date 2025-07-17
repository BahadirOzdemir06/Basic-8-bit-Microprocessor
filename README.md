# Basic-8-bit-Microprocessor
VHDL ile 8-bit mikroişlemci tasarımı/ 8-bit Microprocessor Design with VHDL


Design Hierarchy:

computer.vhd                          --> En üst seviye sistem entegrasyonu
│
├── CPU.vhd                           --> Merkezi işlem birimi
│   ├── control_unit.vhd             --> Komut çözümleme ve kontrol sinyalleri üretimi
│   └── data_paths.vhd               --> Veri yolu altyapısı (registerlar, veri akışı)
│       └── ALU.vhd                  --> Aritmetik ve mantıksal işlemler
│
└── memory.vhd                        --> Bellek sistemi
    ├── program_memory.vhd           --> ROM (komut hafızası)
    ├── data_memory.vhd              --> RAM (veri hafızası)
    └── output_ports.vhd             --> Dış dünyaya çıkış portları
