library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
entity memoriaPrograma is
    generic(
        tamMem : integer:= 9;
        tamInst: integer:= 25
    );
    Port ( pc : in STD_LOGIC_VECTOR (tamMem-1 downto 0);
           instruc : out STD_LOGIC_VECTOR (tamInst-1 downto 0)
    );
end memoriaPrograma;
architecture Behavioral of memoriaPrograma is
--PRIMEROS 5 BITS 
--instrucciones de carga y almacenamiento
constant li  : std_logic_vector(4 downto 0) := "00001";
constant lwi : std_logic_vector(4 downto 0) := "00010";
constant lw  : std_logic_vector(4 downto 0) := "10111";
constant swi : std_logic_vector(4 downto 0) := "00011";
constant sw  : std_logic_vector(4 downto 0) := "00100";
--instrucciones aritmeticas
constant add : std_logic_vector(4 downto 0) := "00000";
constant sub : std_logic_vector(4 downto 0) := "00000";
constant addi: std_logic_vector(4 downto 0) := "00101";
constant subi: std_logic_vector(4 downto 0) := "00110";
--instrucciones logicas                    
constant op_and : std_logic_vector(4 downto 0) := "00000";
constant op_or  : std_logic_vector(4 downto 0) := "00000";
constant op_xor : std_logic_vector(4 downto 0) := "00000";
constant op_nand: std_logic_vector(4 downto 0) := "00000";
constant op_nor : std_logic_vector(4 downto 0) := "00000";
constant op_xnor: std_logic_vector(4 downto 0) := "00000";
constant op_not : std_logic_vector(4 downto 0) := "00000";
constant andi: std_logic_vector(4 downto 0) := "00111";
constant ori : std_logic_vector(4 downto 0) := "01000";
constant xori: std_logic_vector(4 downto 0) := "01001";
constant nandi:std_logic_vector(4 downto 0) := "01010";
constant nori: std_logic_vector(4 downto 0) := "01011";
constant xnori:std_logic_vector(4 downto 0) := "01100";
--instrucciones corrimiento                    16-8-4-2-1
constant c_sll  : std_logic_vector(4 downto 0) := "00000";
constant c_srl  : std_logic_vector(4 downto 0) := "00000";
--instrucciones de saltos condicionales e incondicionales 
constant beqi : std_logic_vector(4 downto 0) := "01101"; --==
constant bnei : std_logic_vector(4 downto 0) := "01110"; --!=
constant blti : std_logic_vector(4 downto 0) := "01111"; --<
constant bleti: std_logic_vector(4 downto 0) := "10000"; --<=
constant bgti : std_logic_vector(4 downto 0) := "10001"; -->
constant bgeti: std_logic_vector(4 downto 0) := "10010"; -->=
constant b    : std_logic_vector(4 downto 0) := "10011"; 
--instrucciones de manejo de subrutinas
constant call : std_logic_vector(4 downto 0) := "10100";
constant ret  : std_logic_vector(4 downto 0) := "10101";
--otras instrucciones
constant nop  : std_logic_vector(4 downto 0) := "10110";
constant s_u : std_logic_vector(3 downto 0) := "0000";
constant r0  : std_logic_vector(3 downto 0) := "0000";
constant r1  : std_logic_vector(3 downto 0) := "0001";
constant r2  : std_logic_vector(3 downto 0) := "0010";
constant r3  : std_logic_vector(3 downto 0) := "0011";
constant r4  : std_logic_vector(3 downto 0) := "0100";
constant r5  : std_logic_vector(3 downto 0) := "0101";
constant r6  : std_logic_vector(3 downto 0) := "0110";
constant r7  : std_logic_vector(3 downto 0) := "0111";
constant r8  : std_logic_vector(3 downto 0) := "1000";
constant r9  : std_logic_vector(3 downto 0) := "1001";
constant r10 : std_logic_vector(3 downto 0) := "1010";
constant r11 : std_logic_vector(3 downto 0) := "1011";
constant r12 : std_logic_vector(3 downto 0) := "1100";
constant r13 : std_logic_vector(3 downto 0) := "1101";
constant r14 : std_logic_vector(3 downto 0) := "1110";
constant r15 : std_logic_vector(3 downto 0) := "1111";

constant id0 : std_logic_vector(3 downto 0) := "0000";
constant id1: std_logic_vector(3 downto 0) := "0001";
constant id2: std_logic_vector(3 downto 0) := "0010";
constant id3: std_logic_vector(3 downto 0) := "0011";
constant id4: std_logic_vector(3 downto 0) := "0100";
constant id5: std_logic_vector(3 downto 0) := "0101";
constant id6: std_logic_vector(3 downto 0) := "0110";
constant id7: std_logic_vector(3 downto 0) := "0111";
constant id8: std_logic_vector(3 downto 0) := "1000";
constant id9: std_logic_vector(3 downto 0) := "1001";
constant id10: std_logic_vector(3 downto 0) := "1010";
constant id11 : std_logic_vector(3 downto 0) := "1011";
constant id12 : std_logic_vector(3 downto 0) := "1100";
constant id13 : std_logic_vector(3 downto 0) := "1101";
constant id14 : std_logic_vector(3 downto 0) := "1110";
constant id15 : std_logic_vector(3 downto 0) := "1111";

type mi_memPrograma is array (0 to (2**tamMem)-1) of std_logic_vector(tamInst-1 downto 0);
constant mi_programa : mi_memPrograma :=(
    li & r0 & id0 & id0 & id0 & id0,
    li & r1 & id0 & id0 & id0 & id1,
    li & r2 & id0 & id0 & id0 & id0,
    li & r3 & id0 & id0 & id0 & id12,
    add & r4 & r0 & r1 & id0 & id0,
    swi & r4 & id0 & id0 & id7 & id2,
    addi & r0 & r1 & id0 & id0 & id0, 
    addi & r1 & r4 & id0 & id0 & id0, 
    addi & r2 & r2 & id0 & id0 & id1,
    bnei & r3 & r2 & id15 & id15 & id11,
    nop & id0 & id0 & id0 & id0 & id0,
    b & id0 & id0 & id0 & id0 & id9,
    others => (others => '0')
);
begin
    instruc <= mi_programa(conv_integer(pc));
end Behavioral;
