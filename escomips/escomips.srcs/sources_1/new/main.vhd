library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.paquete_procesador.all;

entity procesador is
  Port ( 
    clk, clr : in std_logic;
    pc: out std_logic_vector(15 downto 0);
    sp: out std_logic_vector(2 downto 0);
    instruccion: out std_logic_vector(24 downto 0);
    readData1, readData2, resAlu, bussr: out std_logic_vector(15 downto 0);
    aux_rn : out std_logic_vector(8 downto 0);
    aux_ro: out std_logic_vector(15 downto 0);
    aux_z3, aux_z2: out std_logic;
    m: out std_logic_vector(19 downto 0);
    aux_rq : out std_logic_vector(15 downto 0)
  );
end procesador;
architecture Behavioral of procesador is

signal rn: std_logic_vector(8 downto 0);
signal rz : std_logic_vector(19 downto 0);
signal ra, rb, re, rf, rg, rh, ri, rj, rk, rl, rm, ro, rq: std_logic_vector(15 downto 0);
signal rc : std_logic_vector(24 downto 0);
signal rd, rp: std_logic_vector(3 downto 0);
signal stackPointer: std_logic_vector(2 downto 0);
signal rclr: std_logic;


begin
    process(clk)
    begin
        if falling_edge(CLK) then
            RCLR <= CLR;
        end if;
    end process;
    -- component -> this
    unidad_programa: memoriaPrograma port map(
        pc => rb(8 downto 0),
        instruc => rc
    );
    unidad_uc: uc port map(
        clk => clk,
        clr => clr, --********************************************
        funCode => rc(3 downto 0),
        banderas => rp,
        opCode => rc(24 downto 20),
        microinstruccion => rz
    );
    unidad_pila: pila port map(
        clk => clk,
        clr => clr, --********************************************
        wpc => rz(16),
        down => rz(17),
        up => rz(18),
        pc_in => ra,
        pc_out => rb,
        sp => stackPointer
    );
    
    unidad_registros: archivoRegistros port map(
        clk => clk,
        clr => clr, --********************************************
        writeRegWhere => rc(19 downto 16),
        writeDataWhat => re,
        readReg1 => rc(15 downto 12),
        readReg2 => rd,
        shamt => rc(7 downto 4),
        ctrl_WR => rz(10),
        ctrl_SHE => rz(12),
        ctrl_DIR => rz(11),
        readData1 => rk,
        readData2 => rl
    );
    unidad_alu: alu_bits port map(
        aN => rf,
        bN => rg,
        alu_op => rz(7 downto 4),
        sN => rm,
        flag => rp
    );
    unidad_datos: memoriaDatos port map(
        clk => clk,
        WD => rz(2),
        sel => rn,
        dataIn => rl,
        dataOut => ro
    );
    unidad_extSigno: extensor_signo port map(
        lit12 => rc(11 downto 0),
        ext16 => ri
    );
    unidad_extDirec: extensor_direccion port map(
        lit12 => rc(11 downto 0),
        lit16 => rj
    ); 
    A : process(rz(19), rc(15 downto 0), rq)
    begin 
        if rz(19) = '0' then 
            ra <= rc(15 downto 0);
        else
            ra <= rq;
        end if;
        -- mux A
        --ra <= rc(15 downto 0) when (rz(19) = '0') else
        --      rq;
    end process; 
    B : process(rz(15), rc(11 downto 8), rc(19 downto 16))
    begin 
        if rz(15) = '0' then 
            rd <= rc(11 downto 8);
        else
            rd <= rc(19 downto 16);
        end if;
    -- mux B
--    rd <= rc(11 downto 8) when (rz(15) = '0') else
--          rc(19 downto 16);
    end process;
    
    C : process(rz(14),rc(15 downto 0), rq)
    begin 
        if rz(14) = '0' then 
            re <= rc(15 downto 0);
        else
            re <= rq;
        end if;
--    -- mux C
--    re <= rc(15 downto 0) when (rz(14) = '0') else
--          rq;
    end process;

    D : process(rz(9), rk, rb)
    begin 
        if rz(9) = '0' then 
            rf <= rk;
        else
            rf <= rb;
        end if;
--    -- mux D
--    rf <= rk when (rz(9) = '0') else
--          rb;
    end process;
    E: process(rz(8), rl, rh)
    begin
        if rz(8) = '0' then 
            rg <= rl;
        else
            rg <= rh;
        end if;
--    -- mux E
--    rg <= rl when (rz(8) = '0') else
--          rh;
    end process;
    
    F: process(rz(13), ri, rj)
    begin
        if rz(13) = '0' then 
            rh <= ri;
        else 
            rh <= rj;
        end if;
--    -- mux F
--    rh <= ri when (rz(13) = '0') else
--          rj;
    end process;
    
    G: process(rz(3), rm, rc(15 downto 0))
    begin
        if rz(3) = '0' then 
            rn <= rm(8 downto 0);
        else
            rn <= rc(8 downto 0);
        end if;
--    mux G
--    rn <= rm when (rz(3) = '0') else
--          rc(15 downto 0);
    end process;

    H: process(rz, ro, rm)
    begin
        if rz(1) = '0' then 
            rq <= ro;
        else
            rq <= rm;
        end if;
--    -- mux H
--    rq <= ro when (rz(1) = '0') else 
--          rm;
    end process;

    -- para monitoreo sacar salidas que no estan en el diagrama del escomips
    pc <= rb;
    instruccion <= rc;
    readData1 <= rk; 
    readData2 <= rl;
    resAlu <= rm;
    bussr <= rq;
    sp <= stackPointer;
    aux_rn <= rn;
    aux_ro <= ro;
    aux_z3 <= rz(3);
    aux_z2 <= rz(2);
    m <= rz;
    aux_rq <= rq;
end Behavioral;
