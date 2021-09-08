library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity M4 is
	port (
			CLK : in std_logic;
			RST : in std_logic;
			pinSA : in std_logic;
			pinSB : in std_logic;
			velocidad : out std_logic_vector(7 downto 0));
	
end entity M4;

architecture rtl of M4 is

	component reloj is
		port (
			CLK : in std_logic;
      		RST : in std_logic;
     		En_4Hz :out std_logic);
	end component reloj;

	component multiplicador is
		port (
			CLK : in std_logic;
      		RST : in std_logic;
      		dato_A   : in  std_logic_vector (8 downto 0);
   		    dato_B   : in  std_logic_vector (2 downto 0);
    		producto : out std_logic_vector (11 downto 0));
	end component multiplicador;



	signal velocidad_i : unsigned (11 downto 0);
	signal sentido_i : std_logic;
	signal En_4Hz_i : std_logic;
	signal n_pulsos : unsigned (8 downto 0);
	signal n_pulsos2 : std_logic;
	signal dato_A_i : std_logic_vector (8 downto 0);
	signal dato_B_i : std_logic_vector (2 downto 0);
	signal producto_i : std_logic_vector (11 downto 0);
	signal cont : std_logic;

begin
	Clock : reloj
        port map (
            CLK => CLK,
            RST => RST,
            En_4Hz => En_4Hz_i); 

    Multiplicacion : multiplicador
    	port map (
    		CLK => CLK,
            RST => RST,
            dato_A => dato_A_i,
   		    dato_B => dato_B_i,
    		producto => producto_i);



	cont_velocidad : process(RST, CLK, pinSA) is  --calculo de la velocidad
	begin
		if (RST = '0') then
			n_pulsos <= (others => '0');
			n_pulsos2 <= '0';
			cont <= '0';
			n_pulsos2 <= '0';
		elsif (CLK = '1' and CLK'event) then        --se detecto el pinSA
			if (En_4Hz_i = '1') then                    --cada 4Hz 0,25s recalculo la velocidad
				dato_A_i <= std_logic_vector(n_pulsos); --paso el numero de cuentas
				dato_B_i <= "011";                      --paso el numero 3
				velocidad_i <= unsigned(producto_i);    --guardo el producto de n_cuentas*3
				velocidad_i <= velocidad_i srl 1;       --desplazo a la derecha, seria como dividir por 2
	            n_pulsos2 <= '1';
			elsif (n_pulsos2 = '1') then
			    n_pulsos2 <= '0';
			    n_pulsos <= (others => '0');
			end if;
			if (pinSA = '1' and cont = '0') then                                 --si no ha llegado a 0,25s
				n_pulsos <= n_pulsos + 1;               --incremento el contador
				cont <= '1';
			elsif (pinSA = '0') then
			    cont <= '0';
			end if;

		end if;
		
	end process; -- cont_velocidad
	
    
	velocidad <= std_logic_vector(velocidad_i(7 downto 0)); --saco la velocidad por el pin

end architecture rtl;