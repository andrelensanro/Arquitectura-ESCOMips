library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package paquete_alu is 
    component alu_bit is 
        port(
            a: in std_logic;
            b: in std_logic;
            cin : in std_logic;
            op : in std_logic_vector(1 downto 0);
            sa : in std_logic;
            sb : in std_logic;
            s : out std_logic;
            c : out std_logic
        );
    end component;
end package;