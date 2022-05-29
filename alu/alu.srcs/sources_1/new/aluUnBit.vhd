library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aluUnBit is
    Port ( 
            a: in std_logic;
            b: in std_logic;
            cin : in std_logic;
            op : in std_logic_vector(1 downto 0);
            sa : in std_logic;
            sb : in std_logic;
            s : out std_logic;
            c : out std_logic
        );
    end aluUnBit;
    
architecture Behavioral of aluUnBit is
signal p_neg_a: std_logic;
signal p_neg_b: std_logic;
signal op_and, op_or, op_xor, op_plus: std_logic;
begin
    p_neg_a <= a xor sa;
    p_neg_b <= b xor sb;
    op_and <= p_neg_a and p_neg_b;
    op_or <= p_neg_a or p_neg_b;
    op_xor <= p_neg_a xor p_neg_b;
    op_plus <= p_neg_a xor p_neg_b xor cin;
    process(op, p_neg_a, p_neg_b, cin)
    begin
        if (op = "11") then
            c <= (p_neg_a and cin) or (p_neg_b and cin) or (p_neg_a and p_neg_b);
        else
            c <= '0';
        end if;
    end process;
    s <= op_and when op = "00" else
         op_or when op = "01" else
         op_xor when op = "10" else
         op_plus;
end Behavioral;
