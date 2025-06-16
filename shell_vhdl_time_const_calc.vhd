/* */
library ieee;
--use ieee.math_real.all;
use ieee.numeric_std_unsigned.all;
use ieee.std_logic_1164.all;
library unisim;

entity shell_vhdl_time_const_calc is
    port (

    -- General Purpose Clocks

        clk_74_25_p, clk_74_25_n: in std_ulogic; -- 74.25 MHz LVDS clock from Si5341B (U69)

    -- HDMI Si5319C Jitter Attenuator

        hdmi_si5324_rst: out std_ulogic;
        hdmi_ctl_scl, hdmi_ctl_sda: inout std_ulogic;
        hdmi_rec_clock_c_p, hdmi_rec_clock_c_n: out std_ulogic; -- to Si5319C CKIN inputs, AC coupled
        hdmi_si5324_out_c_p, hdmi_si5324_out_c_n: in std_ulogic; -- from Si5319C CKOUT outputs, AC coupled
        hdmi_si5324_lol: in std_ulogic;

    -- General Purpose IOs & Misc

        gpio_led: out std_ulogic_vector(8-1 downto 0);
        i2c0_scl, i2c0_sda: inout std_logic

    );
end entity;
architecture shell_vhdl_time_const_calc_a of shell_vhdl_time_const_calc is
    constant T_CLK_74_25_MHZ: time := 1000 ns / 74.25; -- synth error
    --constant T_CLK_74_25_MHZ: time := 1000 ns / 100.0; -- synth error
    --constant T_CLK_74_25_MHZ: time := 1000 ns / 100; -- synth OK
    --constant T_CLK_74_25_MHZ: time := 1000 * 1000 ns / 74250; -- synth OK
    signal clk_74_25: std_ulogic;
begin
    assert false report "T_CLK_74_25_MHZ: " & time'image(T_CLK_74_25_MHZ) severity note;
si5319_b: block is
    constant T_RSTMN: time := 1 us;
    constant T_READY: time := 10 ms;
    constant RST_CYCLES: positive := 1 + (T_RSTMN / T_CLK_74_25_MHZ);
    constant READY_CYCLES: positive := 1 + (T_READY / T_CLK_74_25_MHZ);
begin
process is begin
    report
        "T_RSTMN: " & time'image(T_RSTMN) & ", " &
        "T_CLK_74_25_MHZ: " & time'image(T_CLK_74_25_MHZ) & ", " &
        "T_RSTMN / T_CLK_74_25_MHZ: " & integer'image(T_RSTMN / T_CLK_74_25_MHZ)
        severity note;
    wait;
end process;
end block;
clocking_b: block
    signal clk_74_25_local: std_ulogic;
begin
    ibufds_clk_74_25: unisim.vcomponents.ibufds port map (
        i => clk_74_25_p, ib => clk_74_25_n, o => clk_74_25_local);
    bufg_clk_74_25: unisim.vcomponents.bufg port map (
        i => clk_74_25_local, o => clk_74_25);
    obufds_clk_74_25: unisim.vcomponents.obufds port map (
        i => clk_74_25, o => hdmi_rec_clock_c_p, ob => hdmi_rec_clock_c_n);
end block;
end architecture;
