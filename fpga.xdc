# Clocks

    set_property PACKAGE_PIN D15 [get_ports clk_74_25_p]; # Bank 67 VCCO - VADJ_FMC - IO_L11P_T1U_N8_GC_67
    set_property PACKAGE_PIN D14 [get_ports clk_74_25_n]; # Bank 67 VCCO - VADJ_FMC - IO_L11N_T1U_N9_GC_67
    set_property IOSTANDARD LVDS [get_ports clk_74_25*];
    create_clock -period 13.468 [get_ports clk_74_25_p];

# I2C0

    set_property PACKAGE_PIN AE19 [get_ports i2c0_scl]; # Bank 65 VCCO - VCC1V2 - IO_L19N_T3L_N1_DBC_AD9N_65
    set_property PACKAGE_PIN AH23 [get_ports i2c0_sda]; # Bank 65 VCCO - VCC1V2 - IO_L13N_T2L_N1_GC_QBC_65
    set_property IOSTANDARD LVCMOS12 [get_ports i2c0*];
    set_property DRIVE 8 [get_ports i2c0*];
    set_false_path -to [get_ports i2c0*];
    set_false_path -from [get_ports i2c0*];

# PL-side LEDs

    set_property PACKAGE_PIN AL11 [get_ports gpio_led[0]]; # Bank 66 VCCO - VCC1V2 - IO_L8P_T1L_N2_AD5P_66
    set_property PACKAGE_PIN AL13 [get_ports gpio_led[1]]; # Bank 66 VCCO - VCC1V2 - IO_L7N_T1L_N1_QBC_AD13N_66
    set_property PACKAGE_PIN AK13 [get_ports gpio_led[2]]; # Bank 66 VCCO - VCC1V2 - IO_L7P_T1L_N0_QBC_AD13P_66
    set_property PACKAGE_PIN AE15 [get_ports gpio_led[3]]; # Bank 64 VCCO - VCC1V2 - IO_L19N_T3L_N1_DBC_AD9N_64
    set_property PACKAGE_PIN AM8 [get_ports gpio_led[4]]; # Bank 66 VCCO - VCC1V2 - IO_L6N_T0U_N11_AD6N_66
    set_property PACKAGE_PIN AM9 [get_ports gpio_led[5]]; # Bank 66 VCCO - VCC1V2 - IO_L6P_T0U_N10_AD6P_66
    set_property PACKAGE_PIN AM10 [get_ports gpio_led[6]]; # Bank 66 VCCO - VCC1V2 - IO_L5N_T0U_N9_AD14N_66
    set_property PACKAGE_PIN AM11 [get_ports gpio_led[7]]; # Bank 66 VCCO - VCC1V2 - IO_L5P_T0U_N8_AD14P_66
    set_property IOSTANDARD LVCMOS12 [get_ports gpio_led];
    set_false_path -to [get_ports gpio_led];

# HDMI Clock Loopback

    set_property PACKAGE_PIN G14 [get_ports hdmi_rec_clock_c_p]; # Bank 67 VCCO - VADJ_FMC - IO_L10P_T1U_N6_QBC_AD4P_67
    set_property PACKAGE_PIN F13 [get_ports hdmi_rec_clock_c_n]; # Bank 67 VCCO - VADJ_FMC - IO_L10N_T1U_N7_QBC_AD4N_67
    set_property IOSTANDARD LVDS [get_ports hdmi_rec_clock*];

    set_property PACKAGE_PIN AD8 [get_ports hdmi_si5324_out_c_p]; # Bank 223 - MGTREFCLK0P_223
    set_property PACKAGE_PIN AD7 [get_ports hdmi_si5324_out_c_n]; # Bank 223 - MGTREFCLK0N_223
    set_property IOSTANDARD LVDS [get_ports hdmi_si5324_out_c*];
    create_clock -period 6.734 [get_ports hdmi_si5324_out_c_p];

# HDMI SI5319C Control

    set_property PACKAGE_PIN N12 [get_ports hdmi_ctl_scl]; # Bank 87 VCCO - VCC3V3 - IO_L1N_AD11N_87
    set_property PACKAGE_PIN P12 [get_ports hdmi_ctl_sda]; # Bank 87 VCCO - VCC3V3 - IO_L1P_AD11P_87
    set_false_path -to [get_ports hdmi_ctl*];
    set_false_path -from [get_ports hdmi_ctl*];

    set_property PACKAGE_PIN H8 [get_ports hdmi_si5324_rst]; # Bank 87 VCCO - VCC3V3 - IO_L12P_AD0P_87
    set_property PACKAGE_PIN G8 [get_ports hdmi_si5324_lol]; # Bank 87 VCCO - VCC3V3 - IO_L12N_AD0N_87
    set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 87]];
