library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity archivoRegistros is
    Port ( clk, clr: in std_logic;--el clr se ocupa aquí porque los registros para ser ms rapidos usan flip-flops y éstos tienen que inicializarse porque pueden estar en un estado que no usemos nosotros para estos casos distintos de 0 y 1 
           writeRegWhere : in STD_LOGIC_VECTOR (3 downto 0);
           writeDataWhat : in STD_LOGIC_VECTOR (15 downto 0);
           readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
           readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           ctrl_WR : in STD_LOGIC;
           ctrl_SHE : in STD_LOGIC;
           ctrl_DIR : in STD_LOGIC;
           readData1 : inout STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0));
end archivoRegistros;

architecture Behavioral of archivoRegistros is
type banco is array (0 to 15) of std_logic_vector(15 downto 0);
signal registros : banco; -- como señal porque hasta que no termine el proceso, no tendra algo fijo
begin
    --haciendo las lecturas de manera asincrona
    readData1 <= registros(conv_integer(readReg1));
    readData2 <= registros(conv_integer(readReg2));
    process(clr, clk, readData1)--al momento de que cambien los estados de estas variables se ejecutara el process
    variable shifting: std_logic_vector(15 downto 0);
    begin
        shifting := readData1;
        if(clr = '1') then -- operacion de reset 
            for i in 0 to 15 loop --inicializo todos los registros del archivo
                registros(i) <= (OTHERS => '0');
            end loop;
        elsif(clk'event and clk = '1') then -- el resto de las operaciones
            if( ctrl_WR = '1' and ctrl_SHE = '0')then --cargar el registro de writeData en writeReg
                registros(conv_integer(writeRegWhere)) <= writeDataWhat; 
            elsif(ctrl_WR = '1' and ctrL_SHE ='1')then
                if(ctrl_DIR = '0') then --corrimiento a la derecha
                    shifting := to_stdlogicvector(to_bitvector(shifting) srl conv_integer(shamt));
                    registros(conv_integer(writeRegWhere)) <= shifting;
                else 
                    shifting := to_stdlogicvector(to_bitvector(shifting) sll conv_integer(shamt));
                    registros(conv_integer(writeRegWhere)) <= shifting;
                end if;    
            end if;
        end if;
    end process;

end Behavioral;
