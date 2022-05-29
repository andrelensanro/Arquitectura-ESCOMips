
library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.paquete_alu.all;

entity alu_bits is
    generic(d : integer := 16);
    Port(
        aN : in std_logic_vector (d-1 downto 0);
        bN : in std_logic_vector (d-1 downto 0);
        alu_op : in std_logic_vector (3 downto 0);
        sN : out std_logic_vector (d-1 downto 0);
        --c : out std_logic;
        flag : out std_logic_vector (3 downto 0)
    );
end alu_bits;

architecture Behavioral of alu_bits is
    component alu_bit is port (
        a, b, sa, sb: in std_logic;
        op : in std_logic_vector(1 downto 0);
        cin : in std_logic;
        c : out std_logic;
        s : out std_logic
        );
    end component;
    signal c_i : std_logic_vector (d downto 0);
    signal s_i : std_logic_vector (d-1 downto 0);
    signal aux_z : std_logic_vector(d-1 downto 0);
    signal aux_c : std_logic;
begin

    c_i(0) <= alu_op(2);--cin
    
    alu_components : for i in 0 to d-1 generate
        alu_1: alu_bit
            port map(
                a=>aN(i),
                b=>bN(i),
                sa=>alu_op(3), --
                sb=>alu_op(2), --
                cin=>c_i(i),
                op(1)=>alu_op(1), --
                op(0)=>alu_op(0), --
                c=>c_i(i+1),
                s=>s_i(i)
            );
    end generate;
    
    sN <= s_i;
    
    aux_z(0) <= s_i(0);
    
    suma: for i in 1 to d-1 generate
            aux_z(i) <= aux_z(i-1) or s_i(i);
          end generate;
    
--    sN(3) <= s_i(3);
--    sN(2) <= s_i(2);
--    sN(1) <= s_i(1);
--    sN(0) <= s_i(0);
    
    flag(3) <= c_i(d) xor c_i(d-1); --OV
    flag(2) <= s_i(d-1);--N
    flag(1) <= not aux_z(d-1);--Z
    flag(0) <= c_i(d);--C
    
end Behavioral;
