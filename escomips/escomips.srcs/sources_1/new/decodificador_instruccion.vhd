library ieee;
use ieee.std_logic_1164.all;

entity decodificador_instruccion is
  port (
    codigo_operacion  : in std_logic_vector(4 downto 0);
    tipoR_saltoC : out std_logic_vector(6 downto 0)
    -- tipoR BEQI BNEI BLTI BLETI BGTI BGETI 
  ) ;
end decodificador_instruccion;

architecture behavioral of decodificador_instruccion is
begin
    if_process : process(codigo_operacion)
        begin
            if codigo_operacion = "00000" then -- 0 tipo R
                tipoR_saltoC <= "1000000";
            elsif codigo_operacion = "01101" then -- 13 BEQI
                tipoR_saltoC <= "0100000";
            elsif codigo_operacion = "01110" then -- 14 BNEI
                tipoR_saltoC <= "0010000";
            elsif codigo_operacion = "01111" then -- 15 BLTI
                tipoR_saltoC <= "0001000";
            elsif codigo_operacion = "10000" then -- 16 BLETI
                tipoR_saltoC <= "0000100";
            elsif codigo_operacion = "10001" then -- 17 BGTI
                tipoR_saltoC <= "0000010";
            elsif codigo_operacion = "10010" then -- 18 BGETI
                tipoR_saltoC <= "0000001";
            else
                tipoR_saltoC <= "0000000";
            end if;
        end process;
end behavioral ; -- behavioral