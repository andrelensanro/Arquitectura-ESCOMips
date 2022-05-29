Library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity test_b is
end test_b;

architecture Behavioral of test_b is
    component procesador is 
        port(
            clk, clr: in std_logic;
            aux_rn: out std_logic_vector(8 downto 0);
            sp: out std_logic_vector(2 downto 0);
            pc, aux_ro: out std_logic_vector(15 downto 0);
            instruccion: out std_logic_vector(24 downto 0);
            readData1, readData2, resAlu, bussr: out std_logic_vector(15 downto 0);
            aux_z3, aux_z2: out std_logic;
            m: out std_logic_vector(19 downto 0);
            aux_rq : out std_logic_vector(15 downto 0)
        );
    end component;
    signal clk, clr, rclr, aux_z3, aux_z2: std_logic;
    signal sp: std_logic_vector(2 downto 0);
    signal aux_rn:  std_logic_vector(8 downto 0);
    signal pc, aux_ro: std_logic_vector(15 downto 0);
    signal instruccion : std_logic_vector(24 downto 0);
    signal readData1, readData2, resAlu, bussr: std_logic_vector(15 downto 0);
    signal m: std_logic_vector(19 downto 0);
    signal aux_rq: std_logic_vector(15 downto 0);
begin
    unidad_procesador: procesador 
        port map(
            clk => clk,
            clr => clr,
            sp => sp,
            pc => pc,
            instruccion => instruccion,
            readData1 => readData1,
            readData2 => readData2,
            resAlu => resAlu, 
            bussr => bussr, 
            aux_ro => aux_ro,
            aux_rn =>aux_rn,
            aux_z3 => aux_z3,
            aux_z2 => aux_z2,
            m => m,
            aux_rq => aux_rq
        );
    clk_process: process
        begin
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end process;
        
    proceso_main : process
    begin
        clr <= '1';
        wait for 23 ns;
        clr <= '0';
        wait;
    end process;
    
end Behavioral;
