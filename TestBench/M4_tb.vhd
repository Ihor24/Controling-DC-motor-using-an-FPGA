--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : M4_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Thu Dec 24 16:52:21 2020
-- Last update : Thu Dec 24 16:52:25 2020
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

entity M4_tb is

end entity M4_tb;

-----------------------------------------------------------

architecture testbench of M4_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK       : std_logic;
	signal RST       : std_logic;
	signal pinSA     : std_logic;
	signal pinSB     : std_logic;
	signal velocidad : std_logic_vector(7 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS
	constant C_CLK_PERIOD2 : real := 10.0e-7; -- NS

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
	
	CLK_SA : process
        begin
            pinSA <= '1';
            wait for 20 nS;
            pinSB <= '1';
            wait for C_CLK_PERIOD2 / 2.0 * (1 SEC);
            pinSA <= '0';
            wait for 20 nS;
            pinSB <= '0';
            wait for C_CLK_PERIOD2 / 2.0 * (1 SEC);

        end process CLK_SA;

	RESET_GEN : process
	begin
		RST <= '0';
		wait for 3 mS;
		RST <= '1';
		wait for 5 mS;
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.M4
		port map (
			CLK       => CLK,
			RST       => RST,
			pinSA     => pinSA,
			pinSB     => pinSB,
			velocidad => velocidad
		);

end architecture testbench;