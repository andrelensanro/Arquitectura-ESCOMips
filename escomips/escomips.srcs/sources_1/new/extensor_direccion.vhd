library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity extensor_direccion is
  Port (
    lit12: in std_logic_vector(11 downto 0);
    lit16 :  out std_logic_vector(15 downto 0)
  );
end extensor_direccion;
architecture Behavioral of extensor_direccion is
begin
    lit16 <= "0000" & lit12;
end Behavioral;