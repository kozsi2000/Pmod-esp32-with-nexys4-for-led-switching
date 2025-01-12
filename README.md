# Pmod esp32 using with nexys4 for led switching

## Project Description:

This project use Pmod esp32 for communication between phone and fpga board for the build-in led switching. 
When the Fpga is power on, the esp32 setting up for the communication and connect to the predefined station.
After if you connected with phone to the same station, then you can send and receive commands via Tcpterm.

This repository contains the necessary files for the execution.

Early requriments for the project:

- Vivado 2019.1 **VERY IMPORTANT! USE JUST THIS VERSION** (https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html)
- Vivado boards (https://github.com/Digilent/vivado-boards)
- Vivado library master (https://github.com/Digilent/vivado-library)
- Tera Term (https://teratermproject.github.io/index-en.html) or you can use any terminal for the uart communicaton.
- Tcpterm for tcp communication.
