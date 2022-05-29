--unidad de control
library ieee;
use ieee.std_logic_1164.all;

entity carta_uc is
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
end entity;

architecture behavioral of carta_uc is

type state is (state_zero);
signal state_current, state_next : state;
begin
    state_transition : process (clk, clr)
        begin 
            if (clr = '1') then 
                state_current <= state_zero;
            elsif (clk'event and clk = '1') then
                state_current <= state_next;
            end if;
        end process; 
        
    automata : process(flags_Bcondicion, flags_Bdecoficador, na, state_current)
    begin
        sdopc <= '0'; 
        sm <= '0';
        case state_current is 
            when state_zero => 
            
            if flags_Bdecoficador(6) = '1' then -- TIPOR
                sdopc <= '0'; sm <= '0'; -- sdopc X
            elsif flags_Bdecoficador(5) = '1' then -- BEQI
               if na = '1' then -- ESTAMOS ARRIBA EN NIVEL, I.E. VERIFICACION
                    sdopc <= '0'; sm <= '1';
                    --regreso al estado 0
                else -- ESTAMOS ABAJ0 EN NIVEL, I.E. POSIBLE SALTO
                    if flags_Bcondicion(5) = '1' then
                        sdopc <= '1'; sm <= '1';
                    else 
                        sdopc <= '0'; sm <= '1';
                    end if;
                end if;
            elsif flags_Bdecoficador(4) = '1' then -- BNEI  
                if na = '1' then -- ESTAMOS ARRIBA EN NIVEL, I.E. VERIFICACION
                    sdopc <= '0'; sm <= '1';
                    --regreso al estado 0
                else -- ESTAMOS ABAJ0 EN NIVEL, I.E. POSIBLE SALTO
                    if flags_Bcondicion(4) = '1' then
                        sdopc <= '1'; sm <= '1';
                    else 
                        sdopc <= '0'; sm <= '1';
                    end if;
                end if;
            elsif flags_Bdecoficador(3) = '1' then -- BLTI  
                if na = '1' then -- ESTAMOS ARRIBA EN NIVEL, I.E. VERIFICACION
                    sdopc <= '0'; sm <= '1';
                    --regreso al estado 0
                else -- ESTAMOS ABAJ0 EN NIVEL, I.E. POSIBLE SALTO
                    if flags_Bcondicion(3) = '1' then
                        sdopc <= '1'; sm <= '1';
                    else 
                        sdopc <= '0'; sm <= '1';
                    end if;
                end if;
            elsif flags_Bdecoficador(2) = '1' then -- BLETI  
                if na = '1' then -- ESTAMOS ARRIBA EN NIVEL, I.E. VERIFICACION
                    sdopc <= '0'; sm <= '1';
                    --regreso al estado 0
                else -- ESTAMOS ABAJ0 EN NIVEL, I.E. POSIBLE SALTO
                    if flags_Bcondicion(2) = '1' then
                        sdopc <= '1'; sm <= '1';
                    else 
                        sdopc <= '0'; sm <= '1';
                    end if;
                end if;
            elsif flags_Bdecoficador(1) = '1' then -- BGTI  
                if na = '1' then -- ESTAMOS ARRIBA EN NIVEL, I.E. VERIFICACION
                    sdopc <= '0'; sm <= '1';
                    --regreso al estado 0
                else -- ESTAMOS ABAJ0 EN NIVEL, I.E. POSIBLE SALTO
                    if flags_Bcondicion(1) = '1' then
                        sdopc <= '1'; sm <= '1';
                    else 
                        sdopc <= '0'; sm <= '1';
                    end if;
                end if;
            elsif flags_Bdecoficador(0) = '1' then -- BGETI  
                if na = '1' then -- ESTAMOS ARRIBA EN NIVEL, I.E. VERIFICACION
                    sdopc <= '0'; sm <= '1';
                    --regreso al estado 0
                else -- ESTAMOS ABAJ0 EN NIVEL, I.E. POSIBLE SALTO
                    if flags_Bcondicion(0) = '1' then
                        sdopc <= '1'; sm <= '1';
                    else 
                        sdopc <= '0'; sm <= '1';
                    end if;
                end if;
            else
                sdopc <= '1'; sm <= '1';
            end if;
            state_next <= state_zero;
        end case;
    end process;
end architecture;