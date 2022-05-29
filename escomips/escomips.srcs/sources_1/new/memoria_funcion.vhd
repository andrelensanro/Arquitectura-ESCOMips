-- nota: esta memoria solo contendra las microinstrucciones de las instrucciones 
-- de tipo R, decir, las que tienen codigo de operacion --/--> 5 en 0 y su codigo
-- de funcion va del 0 al 10. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity memoria_funcion is
    port (
        codigo_funcion: in std_logic_vector(3 downto 0);
        microinstruccion_Inst_R: out std_logic_vector(19 downto 0) 
    ) ;
end memoria_funcion;

architecture behavioral of memoria_funcion is

constant stack : std_logic_vector(3 downto 0) := "0000";
constant reg: std_logic_vector(5 downto 0) := "010001";
constant alu_shift : std_logic_vector(5 downto 0) := "000000";
constant memData: std_logic_vector(1 downto 0) := "00";
constant two_ones: std_logic_vector(1 downto 0) := "11";
constant two_zeros: std_logic_vector(1 downto 0) := "00";
constant reg_sll: std_logic_vector(5 downto 0) := "000111";
constant reg_srl: std_logic_vector(5 downto 0) := "000101";
constant alu_add: std_logic_vector(5 downto 0) := "000011";
constant alu_sub: std_logic_vector(5 downto 0) := "000111";
constant alu_and: std_logic_vector(5 downto 0) := "000000";
constant alu_or: std_logic_vector(5 downto 0) := "000001";
constant alu_xor: std_logic_vector(5 downto 0) := "000010";
constant alu_nand: std_logic_vector(5 downto 0) := "001101";
constant alu_nor: std_logic_vector(5 downto 0) := "001100";
constant alu_xnor: std_logic_vector(5 downto 0) := "001010";
constant alu_not: std_logic_vector(5 downto 0) := "001101";

type memoria is array (0 to 2**4-1) of std_logic_vector(19 downto 0);
constant memoria_cod_fun: memoria :=(
    stack & reg & alu_add & memData & two_ones,
    stack & reg & alu_sub & memData & two_ones,
    stack & reg & alu_and & memData & two_ones,
    stack & reg & alu_or & memData & two_ones,
    stack & reg & alu_xor & memData & two_ones,
    stack & reg & alu_nand & memData & two_ones,
    stack & reg & alu_nor & memData & two_ones,
    stack & reg & alu_xnor & memData & two_ones,
    stack & reg & alu_not & memData & two_zeros,
    stack & reg_sll & alu_shift & memData & two_zeros,
    stack & reg_srl & alu_shift & memData & two_zeros,
    others => (others => '0')
);
begin
    microinstruccion_Inst_R <= memoria_cod_fun(conv_integer(codigo_funcion));
end behavioral ; -- arch