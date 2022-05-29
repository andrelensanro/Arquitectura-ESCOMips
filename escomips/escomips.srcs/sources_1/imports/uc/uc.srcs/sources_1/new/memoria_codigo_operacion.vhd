library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity memoria_codigo_operacion is
    port (
        codigo_operacion: in std_logic_vector(4 downto 0);
        microinstruccion_others_Inst: out std_logic_vector(19 downto 0) 
    ) ;
end memoria_codigo_operacion;

architecture behavioral of memoria_codigo_operacion is

constant stack : std_logic_vector(3 downto 0) := "0000";
constant stack_b : std_logic_vector(3 downto 0) := "0001";
constant stack_call : std_logic_vector(3 downto 0) := "0101";
constant stack_ret : std_logic_vector(3 downto 0) := "0010";
constant stack_jump : std_logic_vector(3 downto 0) := "1001";

constant reg_verif_c: std_logic_vector(5 downto 0) := "100000";
constant reg_zero: std_logic_vector(5 downto 0) := "000000";
constant reg_ope: std_logic_vector(5 downto 0) := "010001";
constant reg_li: std_logic_vector(5 downto 0) := "000001";
constant reg_lwi: std_logic_vector(5 downto 0) := "010001";
constant reg_lw: std_logic_vector(5 downto 0) := "011001";
constant reg_swi: std_logic_vector(5 downto 0) := "100000";
constant reg_sw: std_logic_vector(5 downto 0) := "101000";
constant reg_jump_c: std_logic_vector(5 downto 0) := "000000";

constant alu_verif_c : std_logic_vector(5 downto 0) := "000111";
constant alu_jump : std_logic_vector(5 downto 0) := "110011";
constant alu_zero : std_logic_vector(5 downto 0) := "000000";
constant alu_xw_addi : std_logic_vector(5 downto 0) := "010011";
constant alu_subi : std_logic_vector(5 downto 0) := "010111";
constant alu_andi : std_logic_vector(5 downto 0) := "010000";
constant alu_ori : std_logic_vector(5 downto 0) := "010001";
constant alu_xori : std_logic_vector(5 downto 0) := "010010";
constant alu_nandi : std_logic_vector(5 downto 0) := "011101";
constant alu_nori : std_logic_vector(5 downto 0) := "011100";
constant alu_xnori : std_logic_vector(5 downto 0) := "011010";

constant two_ones: std_logic_vector(1 downto 0) := "11";
constant two_zeros: std_logic_vector(1 downto 0) := "00";
constant zero_one: std_logic_vector(1 downto 0) := "01";
constant one_zero: std_logic_vector(1 downto 0) := "10";

type memoria is array (0 to 2**5-1) of std_logic_vector(19 downto 0);
constant memoria_cod_oper : memoria :=(
    stack & reg_verif_c & alu_verif_c & two_zeros & zero_one, -- verificacion de BEQI, BNEI, BLTI, BLETI, BGTI, BGETI
    stack & reg_li & alu_zero & two_zeros & two_zeros,
    stack & reg_lwi & alu_zero & one_zero & two_zeros,
    stack & reg_swi & alu_zero & two_ones & two_zeros,
    stack & reg_sw & alu_xw_addi & zero_one & zero_one,
    stack & reg_ope & alu_xw_addi & two_zeros & two_ones,
    stack & reg_ope & alu_subi & two_zeros & two_ones,
    stack & reg_ope & alu_andi & two_zeros & two_ones,
    stack & reg_ope & alu_ori & two_zeros & two_ones,
    stack & reg_ope & alu_xori & two_zeros & two_ones,
    stack & reg_ope & alu_nandi & two_zeros & two_ones,
    stack & reg_ope & alu_nori & two_zeros & two_ones,
    stack & reg_ope & alu_xnori & two_zeros & two_ones,
    stack_jump & reg_jump_c & alu_jump & two_zeros & two_ones, -- salto de BEQI
    stack_jump & reg_jump_c & alu_jump & two_zeros & two_ones, -- salto de BNEI
    stack_jump & reg_jump_c & alu_jump & two_zeros & two_ones, -- salto de BLTI
    stack_jump & reg_jump_c & alu_jump & two_zeros & two_ones, -- salto de BLETI
    stack_jump & reg_jump_c & alu_jump & two_zeros & two_ones, -- salto de BGTI
    stack_jump & reg_jump_c & alu_jump & two_zeros & two_ones, -- salto de BGETI
    stack_b & reg_zero & alu_zero & two_zeros & two_zeros,
    stack_call & reg_zero & alu_zero & two_zeros & two_zeros,
    stack_ret & reg_zero & alu_zero & two_zeros & two_zeros,
    stack & reg_zero & alu_zero & two_zeros & two_zeros,
    stack & reg_lw & alu_xw_addi & two_zeros & zero_one,
    others => (others => '0')
);
begin
    microinstruccion_others_Inst <= memoria_cod_oper(conv_integer(codigo_operacion));
end architecture ; -- arch