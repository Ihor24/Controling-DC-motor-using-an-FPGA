library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity M1_M2 is
	port (
		CLK : in std_logic;
		RST : in std_logic;
		sw_Dir : in std_logic;
		btn_up : in std_logic;
		btn_down : in std_logic;
		pinDir : out std_logic;
	    pinEn : out std_logic);

end entity M1_M2;

architecture rtl of M1_M2 is

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
	
	signal vecPWM_i : std_logic_vector (7 downto 0);


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

	
end architecture rtl;