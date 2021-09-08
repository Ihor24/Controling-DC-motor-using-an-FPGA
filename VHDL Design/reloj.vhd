library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reloj is --Estructura reloj

    port(
      CLK : in std_logic; --Señal de reloj
      RST : in std_logic; --Señal de reset
      En_200KHz : out std_logic; --Frecuencia contador
      En_2KHz : out std_logic; --Frecuencia MR0
      En_250Hz : out std_logic; --Frecuencia displays
      En_10Hz : out std_logic;
      En_4Hz :out std_logic);

end entity reloj;

architecture rtl of reloj is

--Declaracion de constantes A, B, C y D
constant Fin_cuenta_1 : integer :=499; --200KHz
constant Fin_cuenta_2 : integer :=99; --2KHz
constant Fin_cuenta_3 : integer :=199; --10Hz
constant Fin_cuenta_4 : integer :=499; --4Hz
constant Fin_cuenta_5 : integer :=9; --250Hz
--Declaracion de constantes para simulacion
--constant Fin_cuenta_1 : integer :=10; 
--constant Fin_cuenta_2 : integer :=15;
--constant Fin_cuenta_3 : integer :=30; 
--constant Fin_cuenta_4 : integer :=35;
--constant Fin_cuenta_5 : integer :=20;



--Señales de reloj iternas
  signal En_2KHz_i : std_logic;
  signal En_200KHz_i : std_logic;
  signal En_250Hz_i : std_logic;
  signal En_10Hz_i : std_logic;
  signal En_4Hz_i : std_logic;
  signal conta_200KHz : unsigned (8 downto 0);
  signal conta_2KHz : unsigned (6 downto 0);
  signal conta_250Hz : unsigned (5 downto 0);
  signal conta_10Hz : unsigned (7 downto 0);
  signal conta_4Hz : unsigned (8 downto 0);



begin

    --Contador 1
    cnt100M_200K : process (CLK, RST) is
        begin
        if (RST = '0') then
            conta_200KHz <= (others => '0');
            En_200KHz_i <= '0';
        elsif (CLK'event and CLK = '1') then
            En_200KHz_i <= '0';
            if (conta_200KHz = Fin_cuenta_1) then
                  En_200KHz_i <= '1';
                  conta_200KHz <= (others => '0');

            else
                conta_200KHz <= conta_200KHz + 1;
            end if;
        end if;
    end process cnt100M_200K;

    En_200KHz <= En_200KHz_i;

    --Contador 2
    cnt1M_2K : process (CLK, RST) is
        begin
        if (RST = '0') then
            conta_2KHz <= (others => '0');
            En_2KHz_i <= '0';
        elsif (CLK'event and CLK = '1') then
            En_2KHz_i <= '0';
            if (En_200KHz_i = '1') then
                En_2KHz_i <= '0';
                if (conta_2KHz = Fin_cuenta_2) then
                    En_2KHz_i <= '1';
                    conta_2KHz <= (others => '0');
                    
                else
                    conta_2KHz <= conta_2KHz + 1;
                end if;
            end if;
        end if;
    end process cnt1M_2K;

    En_2KHz <= En_2KHz_i; --Saco el valor de la señal interna a la salida

    cnt2K_250 : process(CLK, RST) is
    begin
      if (RST = '0') then
          conta_250Hz <= (others => '0');
          En_250Hz_i <= '0';
      elsif (CLK'event and CLK = '1') then
          En_250Hz_i <= '0';
          if (En_2KHz_i = '1') then
             En_250Hz_i <= '0';
             if (conta_250Hz = Fin_cuenta_5) then
                 En_250Hz_i <= '1';
                 conta_250Hz <= (others => '0');
                    
              else
                 conta_250Hz <= conta_250Hz + 1;
              end if;
           end if;
      end if;
    end process; -- cnt2K_250
    
    En_250Hz <= En_250Hz_i;

    cnt2K_10 : process(CLK, RST) is
    begin
      if (RST = '0') then
          conta_10Hz <= (others => '0');
          En_10Hz_i <= '0';
      elsif (CLK'event and CLK = '1') then
          En_10Hz_i <= '0';
          if (En_2KHz_i = '1') then
             En_10Hz_i <= '0';
             if (conta_10Hz = Fin_cuenta_3) then
                 En_10Hz_i <= '1';
                 conta_10Hz <= (others => '0');
                    
              else
                 conta_10Hz <= conta_10Hz + 1;
              end if;
           end if;
      end if;
    end process; -- cnt2K_10
    
    En_10Hz <= En_10Hz_i;


    cnt2K_4 : process(CLK, RST) is
    begin
      if (RST = '0') then
        conta_4Hz <= (others => '0');
        En_4Hz_i <= '0';
    elsif (CLK'event and CLK = '1') then
        En_4Hz_i <= '0';
        if (En_2KHz_i = '1') then
           En_4Hz_i <= '0';
           if (conta_4Hz = Fin_cuenta_4) then
               En_4Hz_i <= '1';
               conta_4Hz <= (others => '0');
                  
            else
               conta_4Hz <= conta_4Hz + 1;
            end if;
         end if;
    end if;
    end process; -- cnt20_10

    En_4Hz <= En_4Hz_i;



end architecture rtl;