--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : M1_M2_M3_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Dec 22 18:14:52 2020
-- Last update : Tue Dec 22 18:19:13 2020
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2020 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity M1_M2_M3_tb is

end entity M1_M2_M3_tb;

-----------------------------------------------------------

architecture testbench of M1_M2_M3_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK            : std_logic;
	signal RST            : std_logic;
	signal sw_Dir         : std_logic;
	signal btn_up         : std_logic;
	signal btn_down       : std_logic;
	signal sw_sel_display : std_logic;
	signal velocidad      : std_logic_vector (7 downto 0);
	signal pinDir         : std_logic;
	signal pinEn          : std_logic;
	signal Seg7_code      : std_logic_vector (7 downto 0);
	signal Sel_displays   : std_logic_vector (3 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;

	RESET_GEN : process
	begin
		RST <= '0';
		sw_sel_display <= '0';
		sw_Dir <= '0';
		btn_up <= '0';
		btn_down <= '0';
		velocidad <= "00000000";
		wait for 3 mS;
		RST <= '1';
		wait for 10 mS;
		btn_up <= '1';
		wait for 20 uS;
		btn_up <= '0';
		wait for 20 uS;
		sw_Dir <= '1';
		wait for 5 mS;
		btn_up <= '1';
        wait for 20 uS;
        btn_up <= '0';
        wait for 20 uS;
		sw_Dir <= '0';
		sw_sel_display <= '1';
		wait for 5 mS;
		sw_sel_display <= '0';
		wait for 10 mS;
		btn_down <= '1';
        wait for 20 uS;
        btn_down <= '0';
        wait for 20 uS;
        sw_Dir <= '1';
        wait for 5 mS;
        sw_Dir <= '0';
        sw_sel_display <= '1';
        wait for 5 mS;
        sw_sel_display <= '0';
        wait for 5 mS;
        RST <= '0';
        velocidad <= "11110000";
        wait for 3 mS;
        RST <= '1';
        wait for 10 mS;
        btn_up <= '1';
        wait for 20 uS;
        btn_up <= '0';
        wait for 20 uS;
        sw_Dir <= '1';
        wait for 5 mS;
        btn_up <= '1';
        wait for 20 uS;
        btn_up <= '0';
        wait for 20 uS;
        sw_Dir <= '0';
        sw_sel_display <= '1';
        wait for 5 mS;
        sw_sel_display <= '0';
        btn_down <= '1';
        wait for 20 uS;
        btn_down <= '0';
        wait for 10 mS;
        btn_down <= '1';
        wait for 20 uS;
        btn_down <= '0';
        wait for 20 uS;
        sw_Dir <= '1';
        wait for 5 mS;
        sw_Dir <= '0';
        sw_sel_display <= '1';
        wait for 5 mS;
        sw_sel_display <= '0';
        wait for 5 mS;
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.M1_M2_M3
		port map (
			CLK            => CLK,
			RST            => RST,
			sw_Dir         => sw_Dir,
			btn_up         => btn_up,
			btn_down       => btn_down,
			sw_sel_display => sw_sel_display,
			velocidad      => velocidad,
			pinDir         => pinDir,
			pinEn          => pinEn,
			Seg7_code      => Seg7_code,
			Sel_displays   => Sel_displays
		);

end architecture testbench;