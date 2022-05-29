library ieee;
use ieee.std_logic_1164.all;

entity bandera_alu is
    port (
        clk, clr: in std_logic;
        lf: in std_logic;
        flags_alu : in std_logic_vector(3 downto 0);
        flags_alu_out: out std_logic_vector(3 downto 0)
    ) ;
end bandera_alu;

architecture behavioral of bandera_alu is
begin
    carga_banderas: process(clk, clr)
    begin
        if clr = '1' then 
            flags_alu_out <= "0000";
        elsif falling_edge(clk) then 
            if(lf = '1') then 
                flags_alu_out <= flags_alu;
            end if;
        end if;
    end process;

end behavioral ; -- behavioral
