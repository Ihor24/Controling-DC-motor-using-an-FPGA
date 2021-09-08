library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity M5 is
	port (
			CLK : in std_logic;
			RST : in std_logic;
			PWM_vec : in std_logic_vector (7 downto 0);
			velocidad : in std_logic_vector (7 downto 0);
			vec_PWM : out std_logic_vector (7 downto 0));

end entity M5;

architecture rtl of M5 is

	component reloj is
		port (
			CLK : in std_logic;
      		RST : in std_logic;
     		En_4Hz :out std_logic);
	end component reloj;

	component multiplicador2 is
		port (
			CLK : in std_logic;
      		RST : in std_logic;
      		dato_A   : in  std_logic_vector (8 downto 0);
   		    dato_B   : in  std_logic_vector (2 downto 0);
    		producto : out std_logic_vector (11 downto 0));
	end component multiplicador2;



	signal vec_PWM_i : unsigned (7 downto 0);
	signal rpm_i : unsigned (7 downto 0);
	signal aumento : std_logic;
	signal decremento : std_logic;
	signal En_4Hz_i : std_logic;
	signal dato_A_i : std_logic_vector (8 downto 0);
	signal dato_B_i : std_logic_vector (2 downto 0);
	signal producto_i : std_logic_vector (11 downto 0);

begin

	Clock : reloj
        port map (
            CLK => CLK,
            RST => RST,
            En_4Hz => En_4Hz_i); 

    Multiplicacion : multiplicador2
    	port map (
    		CLK => CLK,
            RST => RST,
            dato_A => dato_A_i,
   		    dato_B => dato_B_i,
    		producto => producto_i);
    		

    Velocidad_rpm : process(RST, CLK, velocidad) is --conversion de velocidad a rpm
    begin
    	if (RST = '0') then
    		dato_A_i <= (others => '0');
    		dato_B_i <= (others => '0');
    	elsif (CLK = '1' and CLK'event) then  --en cada flanco de reloj hago una regla de 3 para la conversion	
    		dato_A_i <= '0' & velocidad(7 downto 0);            --paso la velocidad
		    dato_B_i <= "101";                --paso el numero 5
			producto_i <= std_logic_vector(unsigned(producto_i) srl 4);             --lo desplazo 4 veces a la derecha, seria como dividir entre 1
		    rpm_i <= unsigned(producto_i(7 downto 0));
		end if;
    	
    end process; -- Velocidad-rpm

    calculo_error : process(RST, CLK, PWM_vec) is
    begin
        if (RST = '0') then
           vec_PWM_i <= (others => '0');
    	elsif (CLK = '1' and CLK'event) then 
    	   vec_PWM_i <= unsigned(PWM_vec);
            if (En_4Hz_i = '1') then          --cada 0,25s actualizo
               if (PWM_vec > std_logic_vector(rpm_i)) then --si es positivo
                  vec_PWM_i <= vec_PWM_i + 1;
               elsif (PWM_vec < std_logic_vector(rpm_i)) then --si el resultado es negativo
                  vec_PWM_i <= vec_PWM_i - 1;
               end if;
            end if;
    	end if;

    end process; -- calculo_error

    vec_PWM <= std_logic_vector(vec_PWM_i);
    
	
end architecture rtl;