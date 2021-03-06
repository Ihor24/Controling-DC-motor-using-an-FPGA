##https://github.com/Digilent/digilent-xdc/blob/master/Nexys-4-DDR-Master.xdc
##Take capitals in get_ports

## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
 create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {	CLK }];


##Buttons
set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { RST }]; #IO_L3P_T0_DQS_AD1P_15 Sch=cpu_resetn


##Switches

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { sw_Dir }]; #IO_L24N_T3_RS0_15 Sch=sw[0]



##Botones para subir/bajar el ciclo de trabajo
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { btn_up }]; #IO_L9P_T1_DQS_14 Sch=btnc
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { btn_down }]; #IO_L4N_T0_D05_14 Sch=btnu


##Pmod Header JA

set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { pinDir }]; #IO_L20N_T3_A19_15 Sch=ja[1]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { pinEn }]; #IO_L21N_T3_DQS_A18_15 Sch=ja[2]
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { JA[3] }]; #IO_L21P_T3_DQS_15 Sch=ja[3]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { JA[4] }]; #IO_L18N_T2_A23_15 Sch=ja[4]
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { JA[7] }]; #IO_L16N_T2_A27_15 Sch=ja[7]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { JA[8] }]; #IO_L16P_T2_A28_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { JA[9] }]; #IO_L22N_T3_A16_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { JA[10] }]; #IO_L22P_T3_A17_15 Sch=ja[10]





##Displays
##set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[0] }]; #IO_L23P_T3_FOE_B_15 Sch=an[0]
##set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[1] }]; #IO_L23N_T3_FWE_B_15 Sch=an[1]
##set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[2] }]; #IO_L24P_T3_A01_D17_14 Sch=an[2]
##set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[3] }]; #IO_L19P_T3_A22_15 Sch=an[3]
##set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[4] }]; #IO_L8N_T1_D12_14 Sch=an[4]
##set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[5] }]; #IO_L14P_T2_SRCC_14 Sch=an[5]
##set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[6] }]; #IO_L23P_T3_35 Sch=an[6]
##set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { Sel_displays[7] }]; #IO_L23N_T3_A02_D18_14 Sch=an[7]
