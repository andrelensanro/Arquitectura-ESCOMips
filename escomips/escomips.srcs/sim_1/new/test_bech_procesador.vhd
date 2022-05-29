library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_procesador is
end test_bench_procesador;

architecture Behavioral of test_bench_procesador is
    component procesador is 
        port(
            clk, clr : in std_logic;
            sp: out std_logic_vector(2 downto 0);
            pc: out std_logic_vector(15 downto 0);
            instruccion: out std_logic_vector(24 downto 0);
            readData1, readData2, resAlu, bussr: out std_logic_vector(15 downto 0)
        );
    end component;
    signal clk, clr: std_logic;
    signal sp: std_logic_vector(2 downto 0);
    signal pc: std_logic_vector(15 downto 0);
    signal instruccion : std_logic_vector(24 downto 0);
    signal readData1, readData2, resAlu, bussr: std_logic_vector(15 downto 0);
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
            bussr => bussr
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
        wait for 20 ns;
        clr <= '0';
        wait;
    end process;
--    stim_clr : process
--        begin
--             if falling_edge(CLK) then
--                CLR <= RCLR;
--            end if;
--        end process;
    
end Behavioral;
