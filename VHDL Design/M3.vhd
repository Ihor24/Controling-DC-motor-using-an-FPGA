library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity M3 is
	port (
			CLK : in std_logic;
			RST : in std_logic;
			sw_sel_display : in std_logic;
			sw_Dir : in std_logic;
			vecPWM : in std_logic_vector (7 downto 0);
			velocidad : in std_logic_vector (7 downto 0);
			Seg7_code : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0));
	
end entity M3;

architecture rtl of M3 is

	component hex2bcd is
		port (
			CLK     : in  std_logic;
    		RST     : in  std_logic;
    		hex_in  : in  std_logic_vector (7 downto 0);
   		 	bcd_hun : out std_logic_vector (3 downto 0);
    		bcd_ten : out std_logic_vector (3 downto 0);
    		bcd_uni : out std_logic_vector (3 downto 0));
	end component hex2bcd;

	component hex2bcd2 is
		port (
			CLK     : in  std_logic;
    		RST     : in  std_logic;
    		hex_in2  : in  std_logic_vector (7 downto 0);
   		 	bcd_hun2 : out std_logic_vector (3 downto 0);
    		bcd_ten2 : out std_logic_vector (3 downto 0);
    		bcd_uni2 : out std_logic_vector (3 downto 0));
	end component hex2bcd2;
	
	component reloj is
         port (
             CLK : in std_logic; --Señal de reloj
             RST : in std_logic; --Señal de reset
             En_250Hz : out std_logic);
     end component reloj;

	component bcd2seg is
	     port (
		     bcd : in std_logic_vector (3 downto 0);
		     Display : out std_logic_vector (7 downto 0));
	end component bcd2seg;

	component FSM_modo is
		port (
			CLK : in std_logic;   
   			RST : in std_logic;              
   		    sw_sel_display : in std_logic;        
    		sw_modo : out std_logic);         
	end component FSM_modo;
	
	component FSM_direccion is
            port (
                CLK : in std_logic;                 -- Señal de reloj
                RST : in std_logic;                 -- Sñal de reset
                sw_Dir : in std_logic;               -- Señal para cambiar de direccion
                swDir1 : out std_logic);         -- Señal de salida de direccion
        end component FSM_direccion;



	signal Sel_displays_i : unsigned (3 downto 0);
	signal sw_sel_display_i : std_logic;
	signal En_250Hz_i : std_logic;
	signal bcd_i : std_logic_vector (3 downto 0);
	signal contador_i : unsigned (3 downto 0);
	signal swDir1 : std_logic;

	signal display_0V : std_logic_vector (3 downto 0);
	signal display_1V : std_logic_vector (3 downto 0);
	signal display_2V : std_logic_vector (3 downto 0);

	signal display_0D : std_logic_vector (3 downto 0);
	signal display_1D : std_logic_vector (3 downto 0);
	signal display_2D : std_logic_vector (3 downto 0);


begin

	Conversion1 : hex2bcd
		port map (
			CLK => CLK,
    		RST => RST,  
    		hex_in => velocidad, 
    	    bcd_hun => display_2V,
    		bcd_ten => display_1V,
   			bcd_uni => display_0V);

	Conversion2 : hex2bcd2
		port map (
			CLK => CLK,   
    		RST => RST,  
    		hex_in2 => vecPWM, 
    	    bcd_hun2 => display_2D,
    		bcd_ten2 => display_1D,
   			bcd_uni2 => display_0D);
	
	Clock : reloj
         port map (
             CLK => CLK,
             RST => RST,
             En_250Hz => En_250Hz_i); 
             
	Visualizar_Display : bcd2seg
		port map (
			bcd => bcd_i,
			Display => Seg7_code);

	Modo : FSM_modo
		port map (
			CLK => CLK,
            RST => RST,
            sw_sel_display => sw_sel_display,    
    		sw_modo => sw_sel_display_i);
    		
    FSM : FSM_direccion
         port map (
             CLK => CLK,
             RST => RST,
             sw_Dir => sw_Dir,
              swDir1 => swDir1);


	sw_display : process(RST, CLK) is  --proceso de seleccion del display en el que se va a representar
	begin
		if (RST = '0') then 
			Sel_displays_i <= (others => '0');
            contador_i <= (others => '0');
		elsif (CLK = '1' and En_250Hz_i = '1' and CLK'event) then --cada periodo de la señal
                contador_i <= contador_i + 1;      --lo increment
                      
                  case contador_i is
                       when "0000" =>                   
                         Sel_displays_i <= "1110"; 
                          if (sw_sel_display_i = '0') then         --si no se ha pulsado se mostrara el Duty cycle con el signo de la direccion      
                              bcd_i <= display_0D;                   
                                              
                          elsif (sw_sel_display_i = '1') then        --si se ha pulsado se mostrara la velocidad con el signo de la direccion
                                bcd_i <= display_0V;
                                              end if;
                       when "0001" =>                   
                          Sel_displays_i <= "1101";
                          if (sw_sel_display_i = '0') then         --si no se ha pulsado se mostrara el Duty cycle con el signo de la direccion      
                               bcd_i <= display_1D;                   
                                                                                    
                          elsif (sw_sel_display_i = '1') then        --si se ha pulsado se mostrara la velocidad con el signo de la direccion
                                bcd_i <= display_1V;
                            end if;
                       when "0010" =>                   
                           Sel_displays_i <= "1011";
                            if (sw_sel_display_i = '0') then         --si no se ha pulsado se mostrara el Duty cycle con el signo de la direccion      
                                bcd_i <= display_2D;                   
                                                                                    
                            elsif (sw_sel_display_i = '1') then        --si se ha pulsado se mostrara la velocidad con el signo de la direccion
                                 bcd_i <= display_2V;
                            end if;                                      
                      when "0011" =>                   
                          Sel_displays_i <= "0111";           
                          if(swDir1 = '1') then  --si la direccion es -
                             bcd_i <= "1111";    --se muestra -
                          else
                             bcd_i <= "1010";    --si no no se puestra nada
                          end if;
                          contador_i <= "0000";
                      when others =>                   
                          Sel_displays_i <= "0000";    
                end case;
        end if;
		
	end process; -- sw_display

	Sel_displays <= std_logic_vector(Sel_displays_i); --saco por que display muestreo

end architecture rtl;