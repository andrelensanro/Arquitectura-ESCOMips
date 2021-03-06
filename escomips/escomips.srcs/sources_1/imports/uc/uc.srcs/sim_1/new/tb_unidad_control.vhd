-- nueva simulacion

library ieee;
library std;
use std.TEXTIO.all;
use ieee.std_logic_TEXTIO.all;	

use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;
use ieee.std_logic_ARITH.all;

 
entity tb_main_unidad_control is
end tb_main_unidad_control;
 
architecture behavior of tb_main_unidad_control is 

    component main
		port(
			funCode, banderas : in std_logic_vector(3 downto 0);
			opCode : in std_logic_vector(4 downto 0);
			clk, rclr, lf: in std_logic;
			microinstruccion: out std_logic_vector(19 downto 0)
		);
	end component;

    signal funCode, banderas : std_logic_vector(3 downto 0);
	signal opCode : std_logic_vector(4 downto 0);
	signal clk, rclr, lf: std_logic;
	signal microinstruccion: std_logic_vector(19 downto 0);

    constant reloj : time := 10 ns;
 
begin

	obj_uc: main port map (
		clk => clk, 
		rclr => rclr, 
		lf => lf, 
		funCode => funCode,
		banderas => banderas,
		opCode => opCode,
		microinstruccion => microinstruccion
	);

	reloj_process :process
	begin
			clk <= '0';
			wait for reloj;
			clk <= '1';
			wait for reloj;
	end process;
																
   	stim_proc: process

		file file_out : text;																					
		variable line_out : line;
		variable vmicro : std_logic_vector(19 downto 0);
	
		file file_in : text;
		variable line_in : line;
		variable vfuncode : std_logic_vector(3 downto 0);
		variable vopcode : std_logic_vector(4 downto 0);
		variable vbanderas : std_logic_vector(3 downto 0);
		variable vclr : std_logic;
		variable vlf : std_logic;

		variable str_long: string(1 to 17);
		variable str_short: string (1 to 7);
		variable bajo: string(1 to 4);
		variable alto: string(1 to 4);
		variable instruccion: string(1 to 40);
		variable aux_clr: std_logic;
		
   begin		
		file_open(file_in, "C:\Users\sel19\Documents\desktop\arquitecturaComputadoras\vivado\unidad_control_process_reloj_correcto\unidad_control_components.srcs\sources_1\inputs\input_saltos.txt", READ_MODE); 	
		file_open(file_out, "C:\Users\sel19\Documents\desktop\arquitecturaComputadoras\vivado\unidad_control_process_reloj_correcto\unidad_control_components.srcs\sources_1\outputs\output_saltos.txt", WRITE_MODE); 	
        bajo := "bajo";
        alto := "alto";
        instruccion := "----------------------------------------";
		str_long := " codigo operacion";
		write(line_out, str_long, right, str_long'length+1);
		str_long := "   codigo funcion";
		write(line_out, str_long, right, str_long'length+1);
		str_long := "     banderas alu";
		write(line_out, str_long, right, str_long'length+1);
		str_short := "    clr";
		write(line_out, str_short, right, str_short'length+1);
		str_short := "     lf";
		write(line_out, str_short, right, str_short'length+1);
		str_long := " microinstruccion";
		write(line_out, str_long, right, str_long'length+1);
		str_short := "  nivel";
		write(line_out, str_short, right, str_short'length+5);
        writeline(file_out,line_out);-- escribe la linea en el archivo
		
		for i in 0 to 11 loop
		    readline(file_in, line_in); 
		    read(line_in, vopcode);
		    read(line_in, vfuncode);
		    read(line_in, vbanderas); 
		    read(line_in, vclr);
		    read(line_in, vlf);
		    wait for 9 ns;
		    rclr <= vclr;
		    --wait for 2 ns;
		    opcode <= vopcode;
			funCode <= vfuncode;		
			banderas <= vbanderas;
			lf <= vlf;
		    vmicro := microinstruccion;
		    wait for 1 ns;
			write(line_out, opcode, right, 17);	
			write(line_out, funcode, right, 17);	
			write(line_out, banderas, right, 17);	
			write(line_out, rclr, right, 9);	
			write(line_out, lf, right, 10);	
			write(line_out, vmicro, right, 22);	
		    if clk = '1' then 
		      write(line_out, alto, right, 8);	
		    else
              write(line_out, bajo, right, 8);	
            end if;
			writeline(file_out,line_out);
            wait for 4 ns;
			write(line_out, opcode, right, 17);	
			write(line_out, funcode, right, 17);	
			write(line_out, banderas, right, 17);	
			write(line_out, rclr, right, 9);	
			write(line_out, lf, right, 10);	
			write(line_out, microinstruccion, right, 22);
			if clk = '1' then 
		      write(line_out, alto, right, 8);	
		    else
              write(line_out, bajo, right, 8);	
            end if;
			writeline(file_out,line_out);
		end loop;
		file_close(file_in);  -- cierra el archivo
		file_close(file_out);  -- cierra el archivo

      wait;
   end process;
	
end;
