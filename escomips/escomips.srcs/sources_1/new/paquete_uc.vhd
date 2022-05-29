library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package paquete_uc is 
    component bloque_condicion is 
        port(
            flags_alu : in std_logic_vector(3 downto 0);
            -- ov n z c
            flags_primarias : out std_logic_vector(5 downto 0)
            -- eq ne lt le gt ge
        );
    end component;
    component decodificador_instruccion is 
        port(
            codigo_operacion  : in std_logic_vector(4 downto 0);
            tipoR_saltoC : out std_logic_vector(6 downto 0)
            -- tipoR BEQI BNEI BLTI BLETI BGTI BGETI 
        );
    end component;
    component bloque_nivel is 
        port(
            clk, clr: in std_logic;
            na : out std_logic
        );
    end component;
    component bandera_alu is 
        port(
            clk, clr: in std_logic;
            lf: in std_logic;
            flags_alu : in std_logic_vector(3 downto 0);
            flags_alu_out: out std_logic_vector(3 downto 0)
        );
    end component;
    component memoria_funcion is 
        port(
            codigo_funcion: in std_logic_vector(3 downto 0);
            microinstruccion_Inst_R: out std_logic_vector(19 downto 0)
        );
    end component;
    component memoria_operacion is 
        port(
            codigo_operacion: in std_logic_vector(4 downto 0);
            microinstruccion_others_Inst: out std_logic_vector(19 downto 0)
        );
    end component;
    component carta_uc is 
        port(
            clk, clr : in std_logic;
            flags_Bcondicion : in std_logic_vector(5 downto 0);
            --  EQ NE LT LE GT GE
            --  5  4  3  2  1  0
            flags_Bdecoficador : in std_logic_vector(6 downto 0);
            -- TIPOR BEQI BNEI BLTI BLETI BGTI BGETI
            --   6    5    4    3     2     1    0
            na: in std_logic;
            sdopc, sm : out std_logic
        );
    end component;
end package;