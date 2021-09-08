library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity M1_M2_M3_M4 is
	port (
			CLK : in std_logic;
			RST : in std_logic;
			sw_Dir : in std_logic;
			btn_up : in std_logic;
			btn_down : in std_logic;
			sw_sel_display : in std_logic;
			pinSA : in std_logic;
			pinSB : in std_logic;
			pinDir : out std_logic;
	   		pinEn : out std_logic;
			Seg7_code : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0));
	
end entity M1_M2_M3_M4;

architecture rtl of M1_M2_M3_M4 is

	component M1 is
		port (
			CLK : in std_logic; --Señal de Reloj
			RST : in std_logic; --Señal de Reset asincrono y a nivel bajo
			sw_Dir : in std_logic; --Entrada sentido de giro
			PWM_vector : in std_logic_vector (7 downto 0); --Vector D
			pinDir : out std_logic; --Salida sentido de giro
			pinEn : out std_logic); --Salida PWM
	end component M1;

	component M2 is
		port (
			CLK : in std_logic;
			RST : in std_logic;
			btn_up : in std_logic;
			btn_down : in std_logic;
			vecPWM : out std_logic_vector (7 downto 0));
	end component M2;

	component M3 is
		port (
			CLK : in std_logic;
			RST : in std_logic;
			sw_sel_display : in std_logic;
			sw_Dir : in std_logic;
			vecPWM : in std_logic_vector (7 downto 0);
			velocidad : in std_logic_vector (7 downto 0);
			Seg7_code : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0));
	end component M3;

	component M4 is
		port (
			CLK : in std_logic;
			RST : in std_logic;
			pinSA : in std_logic;
			pinSB : in std_logic;
			velocidad : out std_logic_vector(7 downto 0));
	end component M4;

	signal vecPWM_i : std_logic_vector (7 downto 0);
	signal velocidad_i : std_logic_vector (7 downto 0);

begin

	Conexion_M1 : M1
		port map (
			CLK => CLK,
			RST => RST,
			sw_Dir => sw_Dir,
			PWM_vector => vecPWM_i,
			pinDir => pinDir,
			pinEn => pinEn);

	Conexion_M2 : M2
		port map (
			CLK => CLK,
			RST => RST,
			btn_up => btn_up,
			btn_down => btn_down,
			vecPWM => vecPWM_i);

	Conexion_M3 : M3
		port map (
			CLK => CLK,
			RST => RST,
			sw_sel_display => sw_sel_display,
			sw_Dir => sw_Dir,
			vecPWM => vecPWM_i,
			velocidad => velocidad_i,
			Seg7_code => Seg7_code,
			Sel_displays => Sel_displays);

	Conexion_M4 : M4
		port map (
			CLK => CLK,
			RST => RST,
			pinSA => pinSA,
			pinSB => pinSB,
			velocidad => velocidad_i);


	
end architecture rtl;