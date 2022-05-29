library ieee;
use ieee.std_logic_1164.all;

entity  bloque_nivel is
    port (
        clk, clr: in std_logic;
        na : out std_logic
    ) ;
end  bloque_nivel;

architecture behavioral of bloque_nivel is
signal pclk,nclk : std_logic;
begin 
    alto: process( clk, clr)
    begin
        if clr = '1'then 
            pclk <= '0';
        elsif(rising_edge(clk)) then 
            pclk <= not pclk;
        end if;
    end process; -- alto
    bajo : process( clk, clr)
    begin
        if clr = '1'then 
            nclk <= '0';
        elsif(falling_edge(clk)) then 
            nclk <= not nclk;
        end if;
    end process ; -- bajo
    na <= nclk xor pclk;
end behavioral ; -- behavioral