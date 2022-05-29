library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity pila is
    generic(
        n : integer := 3;
        m : integer := 16
    );
    port(
        clk, clr, wpc, up, down: in std_logic; -- wpc indicara cuando se tenga que escribir, up incrementa a sp, down decremeneta sp 
        pc_in: in std_logic_vector(m-1 downto 0); -- es el valor que se carga al contador que diga sp
        pc_out: out std_logic_vector(m-1 downto 0); -- es el valor de Q que contenga stack(sp)
        sp: inout std_logic_vector(n-1 downto 0)-- contará de 0 a 7  
    );
end pila;
architecture behavioral of pila is 
type pila is array (0 to (2**n)-1) of std_logic_vector(m-1 downto 0); -- tenemos 8 "registros" o contadores en total de 16 bits 
begin 
    process(clk, clr, sp)
        variable stack: pila;
        variable i_sp: integer range 0 to (2**n)-1 ;
        begin 
            if (clr = '1') then -- RESET 
                i_sp := 0;
                for i in 0 to (2**n)-1 loop
                    stack(i) := (others=>'0');
                end loop;
            elsif (rising_edge(clk)) then 
                if(wpc = '0' and up = '0' and down = '0') then -- AUMENTO DE UNO EN UNO sp = 0 
                    stack(i_sp) := stack(i_sp) + 1; -- pasa de 0 a 1
                                                    -- pasa de 1 a 2
                    --stack(conv_integer(sp)) := stack(conv_integer(sp)) + 1;
                elsif(wpc = '1' and up = '0' and down = '0')then -- CARGA
                    stack(i_sp) := pc_in;
                    --stack(conv_integer(sp)) := pc_in;
                elsif(wpc = '1' and up = '1' and down = '0')then -- AUMENTO SP Y HAGO CARGA
                    i_sp := i_sp + 1;
                    stack(i_sp) := pc_in;
                    --stack(conv_integer(sp)) := pc_in;
                elsif(wpc = '0' and up = '0' and down = '1')then -- AUMENTO DE UNO EN UNO 
                    i_sp := i_sp - 1;
                    stack(i_sp) := stack(i_sp) + 1; 
                    --sp <= sp - 1;
                    --stack(conv_integer(sp)) := stack(conv_integer(sp)) + 1;
                end if;
            end if;
            sp <= std_logic_vector(to_unsigned(i_sp, sp'length));
            pc_out <= stack(conv_integer(sp));
        end process;
end behavioral;
