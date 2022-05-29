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
    -- programa que calcula una serie de uno en uno comenzando en 8
--    li & r0 & id0 & id0 & id0 & id1,--0
--    li & r1 & id0 & id0 & id0 & id7,--1
--    add & r1 & r1 & r0 & id0 & id0,--2
--    swi & r1 & id0 & id0 & id0 & id5,--3
--    b & id0 & id0 & id0 & id0 & id2,--4
--    others => (others => '0')
    --programa de 20 terminos de Fibonacci guadados en localidades secuenciales de la memoria de datos 
--    li & r0 & id0 & id0 & id0 & id0, --0
--    li & r1 & id0 & id0 & id0 & id1, --1
--    li & r2 & id0 & id0 & id0 & id0, --2
--    li & r3 & id0 & id0 & id1 & id4, --3
--    sw & r0 & r2 & id0 & id0 & id0,  --4
--    addi & r2 & r2 & id0 & id0 & id1,--5
--    sw & r1 & r2 & id0 & id0 & id0,  --6
--    addi & r2 & r2 & id0 & id0 & id1,--7
--    blti & r3 & r2 & id0 & id0 & id3,--8
--    nop & id0 & id0 & id0 & id0 & id0,--9
--    b & id0 & id0 & id0 & id0 & id9,  --10
--    add & r4 & r0 & r1 & id0 & id0,  --11
--    sw & r4 & r2 & id0 & id0 & id0,  --12
--    addi & r0 & r1 & id0 & id0 & id0,--13
--    addi & r1 & r4 & id0 & id0 & id0,--14
--    addi & r2 & r2 & id0 & id0 & id1,--15
--    b & id0 & id0 & id0 & id0 & id8, --16
--    others => (others => '0')
    -- producto punto de 2 vectores de N dimensiones 
li & r0 & id0 & id0 & id0 & id3, 
li & r1 & id0 & id0 & id0 & id4,    
li & r2 & id0 & id0 & id0 & id3,
li & r3 & id0 & id0 & id0 & id1,
li & r4 & id0 & id0 & id0 & id5,
li & r5 & id0 & id0 & id0 & id2,
li & r6 & id0 & id0 & id0 & id7,
swi & r1 & id0 & id0 & id0 & id1,
swi & r2 & id0 & id0 & id0 & id2,
swi & r3 & id0 & id0 & id0 & id3,
swi & r4 & id0 & id0 & id0 & id4,
swi & r5 & id0 & id0 & id0 & id5,
swi & r6 & id0 & id0 & id0 & id6,
li & r1 & id0 & id0 & id0 & id1,
c_sll & r3 & r0 & id0 & id1 & id9,
bleti & r0 & r1 & id0 & id0 & id6,
li & r2 & id0 & id0 & id0 & id1,
li & r10 & id0 & id0 & id0 & id0,
bleti & r0 & r2 & id0 & id0 & id6,
lw & r8 & r10 & id0 & id0 & id0,
b & id0 & id0 & id0 & id1 & id3,
call & id0 & id0 & id0 & id1 & id11,
addi & r1 & r1 & id0 & id0 & id1,
b & id0 & id0 & id0 & id0 & id15,
call & id0 & id0 & id0 & id2 & id2,
addi & r2 & r2 & id0 & id0 & id1,
b & id0 & id0 & id0 & id1 & id2,
lw & r6 & r1 & id0 & id0 & id0, -- multiplicar
add & r5 & r0 & r1 & id0 & id0,
li & r15 & id0 & id0 & id0 & id0, --bucle para encontrar el valor que quiero sumar
bleti & r5 & r15 & id0 & id0 & id5,
op_and & r8 & r6 & r9 & id0 & id2,
add & r7 & r3 & r1 & id0 & id0,
sw & r8 & r7 & id0 & id0 & id0,
ret & id0 & id0 & id0 & id0 & id0, 
addi & r10 & r10 & id0 & id0 & id1,
lw & r9 & r10 & id0 & id0 & id0,
b & id0 & id0 & id0 & id1 & id14,
add & r6 & r3 & r2 & id0 & id0,-- sumar
lw & r6 & r6 & id0 & id0 & id0,
add & r10 & r10 & r6 & id0 & id0,
ret & id0 & id0 & id0 & id0 & id0,
others => (others => '0')
--lw & r9 & r5 & id0 & id0 & id0,------------------aqui falla
);
begin
    instruc <= mi_programa(conv_integer(pc));
end Behavioral;
