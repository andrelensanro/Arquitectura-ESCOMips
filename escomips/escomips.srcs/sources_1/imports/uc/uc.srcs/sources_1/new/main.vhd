library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; -- por lo regular se usa 
use work.components.all;

entity main is
    port(
        funCode, banderas : in std_logic_vector(3 downto 0);
        opCode : in std_logic_vector(4 downto 0);
        clk, rclr: std_logic;
        --lf: in std_logic;
        microinstruccion: out std_logic_vector(19 downto 0)
    );
end main;
architecture Behavioral of main is
signal micro_R: std_logic_vector(19 downto 0);
signal micro_O: std_logic_vector(19 downto 0);
signal sel_sdopc : std_logic;
signal sel_sm : std_logic;
signal mux_opcode: std_logic_vector(4 downto 0);
signal flags_deco : std_logic_vector(6 downto 0);
signal flags_alu_desc : std_logic_vector(3 downto 0);
signal flags_condicion: std_logic_vector(5 downto 0);
signal level: std_logic;
signal clr : std_logic;
signal lf: std_logic;
signal micro: std_logic_vector(19 downto 0);
begin
    
--    process(clk)
--    begin
--        if falling_edge(clk) then
--            clr <= rclr; 
--        end if;
--    end process;
    mux_opcode <= opCode when (sel_sdopc='1') else
                  "00000";
    micro <= micro_R when (sel_sm = '0') else
                  micro_O;
    microinstruccion <= micro;
    lf <= micro(0);
    
    obj_memoriaFuncion: memoria_codigo_funcion port map(
        -- COMPONENT => THIS
        codigo_funcion => funCode,
        microinstruccion_Inst_R => micro_R -- guarde el resultado de la memoria de funcion 
    );
    obj_memoriaOperacion: memoria_codigo_operacion port map(
        -- COMPONENT => THIS
        codigo_operacion => mux_opcode,
        microinstruccion_Others_Inst => micro_O
    );
    obj_decodificador: decodificador_instruccion port map(
        -- COMPONENT => THIS
        codigo_operacion => opCode,
        tipoR_saltoC => flags_deco
    );
    
    obj_flags_alu : bandera_alu port map(
        -- COMPONENT => THIS
        flags_alu => banderas,
        flags_alu_out => flags_alu_desc,
        lf => lf, 
        clk => clk,
        clr => clr
    );
    
    obj_bloque_condicion: bloque_condicion port map(
        -- COMPONENT => THIS
        flags_alu => flags_alu_desc,
        flags_primarias => flags_condicion
    );
    obj_nivel: bloque_nivel port map(
        -- COMPONENT => THIS
        clk => clk, 
        clr => clr,
        na => level
    );
    obj_carta: carta_asm_uc port map(
        -- COMPONENT => THIS
        clk => clk,
        clr => clr,
        na => level,
        flags_Bcondicion => flags_condicion,
        flags_Bdecoficador => flags_deco,
        sdopc => sel_sdopc,
        sm => sel_sm
    );
end Behavioral;
