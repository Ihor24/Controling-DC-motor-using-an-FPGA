library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity FSM_modo is --declaro estructura FSM
  
  port (
    CLK : in std_logic;                 -- Señal de reloj
    RST : in std_logic;                 -- Sñal de reset
    sw_sel_display : in std_logic;               -- Señal para cambiar de direccion
    sw_modo : out std_logic);         -- Señal de salida de direccion
  
end entity FSM_modo;

architecture secuencial of FSM_modo is

  type stateFSM is (S1,S2,S3,S4); --Creaccion de estados
  signal state : stateFSM ;  -- estado de la maquina secuencial

begin  
  
  -- Control de cambio de estado
  process (CLK, RST) is
  begin  -- process
    if (RST = '0') then         -- Si el reset se activa vuelvo al estado 1
      state <= S1;
    elsif (CLK 'event and CLK = '1') then --Cada vez que haya flanco de subida de CLK y flanco
      case state is
        when S1 =>
        if (sw_sel_display='1')then --Si el pulsador esta pulsado paso al siguiente estado
          state <= S2;
        end if;
        when S2 =>
        if (sw_sel_display='0')then --Si dejo de pulsar
          state <= S3;
        end if;
        when S3 =>
        if (sw_sel_display='1')then
          state <= S4;
        end if;
        when S4 =>
        if (sw_sel_display='0')then
          state <= S1;
        end if;
      end case ;
    end if;
  end process;

 --Control salida segun los estados
 process (state)
 begin
  case state is --Si estoy en algunos de estos estados la salida actualizar:
    when S2|S3 =>
     sw_modo <= '1';
    when S1|S4 =>
     sw_modo <= '0';
  end case;
  end process;
  
end architecture secuencial;