--esta es la memoria de datos, me equivoque en el nombre
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memoriaDatos is
    generic (
        tamMem : integer := 9;
        tamDato : integer :=16
    );
    Port ( clk : in STD_LOGIC;
           WD : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (tamMem-1 downto 0);
           dataIn : in STD_LOGIC_VECTOR (tamDato-1 downto 0);
           dataOut : out STD_LOGIC_VECTOR (tamDato-1 downto 0)
    );
end memoriaDatos;

architecture Behavioral of memoriaDatos is
type memoria is array (0 to (2**tamMem)-1) of std_logic_vector(tamDato-1 downto 0);

signal memDatos : memoria;
begin
    --lectura asincrona 
    dataOut <= memDatos(conv_integer(sel));
    process(clk)
        begin
            if(clk'event and clk = '1') then
                if(WD = '1') then
                    --escritura
                    memDatos(conv_integer(sel)) <= dataIn;
                end if;
            end if;
        end process;
end Behavioral;
