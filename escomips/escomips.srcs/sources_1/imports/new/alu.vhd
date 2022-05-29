library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    generic(d : integer := 16);
    Port(
        aN : in std_logic_vector (d-1 downto 0);
        bN : in std_logic_vector (d-1 downto 0);
        alu_op : in std_logic_vector (3 downto 0);
        sN : out std_logic_vector (d-1 downto 0);
        --c : out std_logic;
        flag : out std_logic_vector (3 downto 0)
    );
end alu;
architecture Behavioral of alu is 
--instanciar componentes
component aluUnBit is port (
    a, b, sa, sb: in std_logic;
    op : in std_logic_vector(1 downto 0);
    cin : in std_logic;
    c : out std_logic;
    s : out std_logic
    );
end component;
signal c_i : std_logic_vector (d downto 0);
signal s_i : std_logic_vector (d-1 downto 0);
begin
    c_i(0)<=alu_op(2);--cin
    
    alu_components : for i in 0 to d-1 generate
        alu_1: aluUnBit
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
    
    
--    u1: aluUnBit
--    port map(
--        a=>aN(0),
--        b=>bN(0),
--        sa=>alu_op(3),
--        sb=>alu_op(2),
--        cin=>c_i(0),
--        op(1)=>alu_op(1),
--        op(0)=>alu_op(0),
--        c=>c_i(1),
--        s=>s_i(0)
--    );
--    u2: aluUnBit
--    port map(
--        a=>aN(1),
--        b=>bN(1),
--        sa=>alu_op(3),
--        sb=>alu_op(2),
--        cin=>c_i(1),
--        op(1)=>alu_op(1),
--        op(0)=>alu_op(0),
--        c=>c_i(2),
--        s=>s_i(1)
--    );
--    u3: aluUnBit
--    port map(
--        a=>aN(2),
--        b=>bN(2),
--        sa=>alu_op(3),
--        sb=>alu_op(2),
--        cin=>c_i(2),
--        op(1)=>alu_op(1),
--        op(0)=>alu_op(0),
--        c=>c_i(3),
--        s=>s_i(2)
--    );
--    u4: aluUnBit
--    port map(
--        a=>aN(3),
--        b=>bN(3),
--        sa=>alu_op(3),
--        sb=>alu_op(2),
--        cin=>c_i(3),
--        op(1)=>alu_op(1),
--        op(0)=>alu_op(0),
--        c=>c_i(4),
--        s=>s_i(3)
--    );
    --c <= c_i(4);
    sN(3) <= s_i(3);
    sN(2) <= s_i(2);
    sN(1) <= s_i(1);
    sN(0) <= s_i(0);

    flag(3) <= c_i(4) xor c_i(3); --OV
    flag(2) <= s_i(3);--N
    flag(1) <= not (((s_i(3) or s_i(2)) or s_i(1)) or s_i(0));--Z
    flag(0) <= c_i(4);--C
  
end Behavioral;

