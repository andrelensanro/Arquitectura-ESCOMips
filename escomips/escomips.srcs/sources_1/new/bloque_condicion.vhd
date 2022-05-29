library ieee;
use ieee.std_logic_1164.all;

entity bloque_condicion is
    port (
        flags_alu : in std_logic_vector(3 downto 0);
        -- ov n z c
        flags_primarias : out std_logic_vector(5 downto 0)
        -- eq ne lt le gt ge
    ) ;
end bloque_condicion;
architecture bahevioral of bloque_condicion is
begin
    flags_primarias(5) <= flags_alu(1);
    flags_primarias(4) <= not flags_alu(1);
    flags_primarias(3) <= not flags_alu(0);
    flags_primarias(2) <= flags_alu(1) or not flags_alu(0);
    flags_primarias(1) <= not flags_alu(1) and flags_alu(0);
    flags_primarias(0) <= flags_alu(0);
end bahevioral ; -- bahevioral