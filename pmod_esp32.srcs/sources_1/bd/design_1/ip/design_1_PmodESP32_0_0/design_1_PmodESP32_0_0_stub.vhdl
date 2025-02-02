-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Nov 27 20:44:29 2024
-- Host        : ThinkPad-T14 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Xilinx/projects/pmod_esp32/pmod_esp32.srcs/sources_1/bd/design_1/ip/design_1_PmodESP32_0_0/design_1_PmodESP32_0_0_stub.vhdl
-- Design      : design_1_PmodESP32_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_PmodESP32_0_0 is
  Port ( 
    AXI_LITE_GPIO_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    AXI_LITE_GPIO_arready : out STD_LOGIC;
    AXI_LITE_GPIO_arvalid : in STD_LOGIC;
    AXI_LITE_GPIO_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    AXI_LITE_GPIO_awready : out STD_LOGIC;
    AXI_LITE_GPIO_awvalid : in STD_LOGIC;
    AXI_LITE_GPIO_bready : in STD_LOGIC;
    AXI_LITE_GPIO_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    AXI_LITE_GPIO_bvalid : out STD_LOGIC;
    AXI_LITE_GPIO_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_LITE_GPIO_rready : in STD_LOGIC;
    AXI_LITE_GPIO_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    AXI_LITE_GPIO_rvalid : out STD_LOGIC;
    AXI_LITE_GPIO_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_LITE_GPIO_wready : out STD_LOGIC;
    AXI_LITE_GPIO_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_LITE_GPIO_wvalid : in STD_LOGIC;
    AXI_LITE_UART_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_LITE_UART_arready : out STD_LOGIC;
    AXI_LITE_UART_arvalid : in STD_LOGIC;
    AXI_LITE_UART_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_LITE_UART_awready : out STD_LOGIC;
    AXI_LITE_UART_awvalid : in STD_LOGIC;
    AXI_LITE_UART_bready : in STD_LOGIC;
    AXI_LITE_UART_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    AXI_LITE_UART_bvalid : out STD_LOGIC;
    AXI_LITE_UART_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_LITE_UART_rready : in STD_LOGIC;
    AXI_LITE_UART_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    AXI_LITE_UART_rvalid : out STD_LOGIC;
    AXI_LITE_UART_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_LITE_UART_wready : out STD_LOGIC;
    AXI_LITE_UART_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_LITE_UART_wvalid : in STD_LOGIC;
    Pmod_out_pin10_i : in STD_LOGIC;
    Pmod_out_pin10_o : out STD_LOGIC;
    Pmod_out_pin10_t : out STD_LOGIC;
    Pmod_out_pin1_i : in STD_LOGIC;
    Pmod_out_pin1_o : out STD_LOGIC;
    Pmod_out_pin1_t : out STD_LOGIC;
    Pmod_out_pin2_i : in STD_LOGIC;
    Pmod_out_pin2_o : out STD_LOGIC;
    Pmod_out_pin2_t : out STD_LOGIC;
    Pmod_out_pin3_i : in STD_LOGIC;
    Pmod_out_pin3_o : out STD_LOGIC;
    Pmod_out_pin3_t : out STD_LOGIC;
    Pmod_out_pin4_i : in STD_LOGIC;
    Pmod_out_pin4_o : out STD_LOGIC;
    Pmod_out_pin4_t : out STD_LOGIC;
    Pmod_out_pin7_i : in STD_LOGIC;
    Pmod_out_pin7_o : out STD_LOGIC;
    Pmod_out_pin7_t : out STD_LOGIC;
    Pmod_out_pin8_i : in STD_LOGIC;
    Pmod_out_pin8_o : out STD_LOGIC;
    Pmod_out_pin8_t : out STD_LOGIC;
    Pmod_out_pin9_i : in STD_LOGIC;
    Pmod_out_pin9_o : out STD_LOGIC;
    Pmod_out_pin9_t : out STD_LOGIC;
    gpio_interrupt : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    uart_interrupt : out STD_LOGIC
  );

end design_1_PmodESP32_0_0;

architecture stub of design_1_PmodESP32_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "AXI_LITE_GPIO_araddr[8:0],AXI_LITE_GPIO_arready,AXI_LITE_GPIO_arvalid,AXI_LITE_GPIO_awaddr[8:0],AXI_LITE_GPIO_awready,AXI_LITE_GPIO_awvalid,AXI_LITE_GPIO_bready,AXI_LITE_GPIO_bresp[1:0],AXI_LITE_GPIO_bvalid,AXI_LITE_GPIO_rdata[31:0],AXI_LITE_GPIO_rready,AXI_LITE_GPIO_rresp[1:0],AXI_LITE_GPIO_rvalid,AXI_LITE_GPIO_wdata[31:0],AXI_LITE_GPIO_wready,AXI_LITE_GPIO_wstrb[3:0],AXI_LITE_GPIO_wvalid,AXI_LITE_UART_araddr[3:0],AXI_LITE_UART_arready,AXI_LITE_UART_arvalid,AXI_LITE_UART_awaddr[3:0],AXI_LITE_UART_awready,AXI_LITE_UART_awvalid,AXI_LITE_UART_bready,AXI_LITE_UART_bresp[1:0],AXI_LITE_UART_bvalid,AXI_LITE_UART_rdata[31:0],AXI_LITE_UART_rready,AXI_LITE_UART_rresp[1:0],AXI_LITE_UART_rvalid,AXI_LITE_UART_wdata[31:0],AXI_LITE_UART_wready,AXI_LITE_UART_wstrb[3:0],AXI_LITE_UART_wvalid,Pmod_out_pin10_i,Pmod_out_pin10_o,Pmod_out_pin10_t,Pmod_out_pin1_i,Pmod_out_pin1_o,Pmod_out_pin1_t,Pmod_out_pin2_i,Pmod_out_pin2_o,Pmod_out_pin2_t,Pmod_out_pin3_i,Pmod_out_pin3_o,Pmod_out_pin3_t,Pmod_out_pin4_i,Pmod_out_pin4_o,Pmod_out_pin4_t,Pmod_out_pin7_i,Pmod_out_pin7_o,Pmod_out_pin7_t,Pmod_out_pin8_i,Pmod_out_pin8_o,Pmod_out_pin8_t,Pmod_out_pin9_i,Pmod_out_pin9_o,Pmod_out_pin9_t,gpio_interrupt,s_axi_aclk,s_axi_aresetn,uart_interrupt";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "PmodESP32,Vivado 2019.1";
begin
end;
