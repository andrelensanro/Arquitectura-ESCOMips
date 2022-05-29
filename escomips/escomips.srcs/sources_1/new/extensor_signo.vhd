library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extensor_signo is
  Port (
    lit12 : in std_logic_vector(11 downto 0);
    ext16 : out std_logic_vector(15 downto 0)
  );
end extensor_signo;

architecture Behavioral of extensor_signo is

begin
    extender: process(lit12)
    begin 
        if lit12(11) = '1' then 
            ext16 <= "1111" & lit12;
        else
            ext16 <= "0000" & lit12;
        end if; 
    end process;

end Behavioral;
