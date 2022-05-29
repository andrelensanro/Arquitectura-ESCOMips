library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package paquete_procesador is
    component pila is 
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
    end component;
    component memoriaPrograma is 
        generic(
            tamMem : integer:= 9;
            tamInst: integer:= 25
        );
        port ( 
            pc : in std_logic_vector (tamMem-1 downto 0);
            instruc : out std_logic_vector (tamInst-1 downto 0)
        );
    end component;
    component archivoRegistros is 
        port (
            clk, clr: in std_logic;--el clr se ocupa aquí porque los registros para ser ms rapidos usan flip-flops y éstos tienen que inicializarse porque pueden estar en un estado que no usemos nosotros para estos casos distintos de 0 y 1 
            writeRegWhere : in STD_LOGIC_VECTOR (3 downto 0);
            writeDataWhat : in STD_LOGIC_VECTOR (15 downto 0);
            readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
            readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
            shamt : in STD_LOGIC_VECTOR (3 downto 0);
            ctrl_WR : in STD_LOGIC;
            ctrl_SHE : in STD_LOGIC;
            ctrl_DIR : in STD_LOGIC;
            readData1 : inout STD_LOGIC_VECTOR (15 downto 0);
            readData2 : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    component alu_bits is
        generic(d : integer := 16);
        Port(
            aN : in std_logic_vector (d-1 downto 0);
            bN : in std_logic_vector (d-1 downto 0);
            alu_op : in std_logic_vector (3 downto 0);
            sN : out std_logic_vector (d-1 downto 0);
            --c : out std_logic;
            flag : out std_logic_vector (3 downto 0)
        );
    end component;
    component memoriaDatos is
        generic (
            tamMem : integer := 9;
            tamDato : integer :=16
        );
        Port ( 
            clk : in STD_LOGIC;
            WD : in STD_LOGIC;
            sel : in STD_LOGIC_VECTOR (tamMem-1 downto 0);
            dataIn : in STD_LOGIC_VECTOR (tamDato-1 downto 0);
            dataOut : out STD_LOGIC_VECTOR (tamDato-1 downto 0)
        );
    end component;
    component uc is
        port(
            funCode, banderas : in std_logic_vector(3 downto 0);
            opCode : in std_logic_vector(4 downto 0);
            clk, clr: std_logic;
            --lf: in std_logic;
            microinstruccion: out std_logic_vector(19 downto 0)
        );
    end component;
    component extensor_signo is
      port (
        lit12 : in std_logic_vector(11 downto 0);
        ext16 : out std_logic_vector(15 downto 0)
      );
    end component;
    component extensor_direccion is
      port (
        lit12: in std_logic_vector(11 downto 0);
        lit16 :  out std_logic_vector(15 downto 0)
      );
    end component;
end package;










