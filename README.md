# Audio-Recorder-FPGA-Project
An audio recorder and playback device built for the Anvyl Spartan-6 XL45 development board as part of the CDA4203 (Computer System Design) final project.

This uses a PicoBlaze embedded processor programmed with KCPSM6, the on-board 128MHz DRAM for audio file logging (and selection), on-board I2S audio codec for audio signal coding & decoding (16-bit audio @ 44.1kHz). In addition, it uses the on-board buttons and switches as well as UART communications (implemented with the PicoBlaze processor) to create an interactive user interface. 

The top module for the entire program is top.v.
