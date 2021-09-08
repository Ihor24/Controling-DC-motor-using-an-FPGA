--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : M2_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Sun Dec 20 13:25:03 2020
-- Last update : Sun Dec 20 13:27:50 2020
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

entity M2_tb is

end entity M2_tb;

-----------------------------------------------------------

architecture testbench of M2_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK      : std_logic;
	signal RST      : std_logic;
	signal btn_up   : std_logic;
	signal btn_down : std_logic;
	signal vecPWM   : std_logic_vector (7 downto 0);

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
		btn_up <= '0';
		btn_down <= '0';
		wait for 10 mS;
		RST <= '1';
		wait for 5 mS;
		btn_up <= '1';
		wait for 10 uS;
		btn_up <= '0';
		wait for 5 mS;
        btn_up <= '1';
        wait for 10 uS;
        btn_up <= '0';
		wait for 10 mS;
		btn_down <= '1';
		wait for 10 uS;
		btn_down <= '0';
		wait for 10 mS;
		btn_up <= '1';
		wait for 40 uS;
		btn_up <= '0';
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.M2
		port map (
			CLK      => CLK,
			RST      => RST,
			btn_up   => btn_up,
			btn_down => btn_down,
			vecPWM   => vecPWM
		);

end architecture testbench;