{Se tiene información en un archivo de las horas extras realizadas por los empleados de una
empresa en un mes. Para cada empleado se tiene la siguiente información: departamento,
división, número de empleado, categoría y cantidad de horas extras realizadas por el
empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por
división y, por último, por número de empleado. Presentar en pantalla un listado con el
siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}

program ejercicio11;
const
	dimF=15;
	valorAlto=9999;
type
	sub_cate=1..15;
	empleado=record
		departamento:integer;
		division:integer;
		numEmpleado:integer;
		categoria:sub_cate;
		cantHorasExtraRealizadas:integer;
	end;
	
	archivo_empleados=file of empleado;
	
	vectorHorasExtra=array [sub_cate] of real;
	
//El procedimiento generarArchivo se utilizará una única vez con el fin de 
//crear el archivo sobre el cual se trabajará para resolver el ejercicio
	
	procedure generarArchivo(var arch:archivo_empleados);
	var
		emp:empleado;
		carga:Text;
	begin
		assign(carga,'infoEmpleados.txt');
		assign(arch,'infoEmp.dat');
		reset(carga);
		rewrite(arch);
		while (not(eof(carga))) do
			begin
				with emp do
					readln(carga,departamento,division,numEmpleado,categoria,cantHorasExtraRealizadas);
				write(arch,emp);
			end;
		writeln('Archivo binario cargado');
		close(carga);
		close(arch);
	end;
	
{-----------------------------------------------------------------------------------------------------------------------------------}
	
	procedure cargarVector(var v:vectorHorasExtra);
	var
		i:integer;
		valorHora:real;
	begin
		valorHora:=500.32;
		for i:= 1 to dimF do
			begin
				v[i]:=valorHora;
				valorHora:=valorHora + 120.50;
			end;
	end;
	
	
	procedure leer(var arch:archivo_empleados;var dato:empleado);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.departamento:=valorAlto;
	end;
	
	
	procedure generarReporte(var arch:archivo_empleados;vec:vectorHorasExtra);
	var
		depAct,divAct,numEmp,totalDep,totalDiv,totalHs,cate:integer;
		importeACobrar,montoTotalDiv,montoTotalDep:real;
		reg:empleado;
	begin
		reset(arch);
		leer(arch,reg);
		while (reg.departamento<>valorAlto) do
			begin
				totalDep:=0;
				montoTotalDep:=0;
				depAct:=reg.departamento;
				writeln('Departamento');
				writeln('    ',depAct);
				writeln();
				while(depAct=reg.departamento) do
					begin
						totalDiv:=0;
						montoTotalDiv:=0;
						divAct:=reg.division;
						writeln('División');
						writeln('       ',divAct);
						writeln();
						writeln('Número de empleado     Total de Hs.     Importe a cobrar');
						while ((depAct=reg.departamento) and (divAct=reg.division)) do
							begin
								totalHs:=0;
								numEmp:=reg.numEmpleado;
								while ((depAct=reg.departamento) and (divAct=reg.division) and (numEmp=reg.numEmpleado)) do
									begin
										cate:=reg.categoria;
										totalHs:=totalHs + reg.cantHorasExtraRealizadas;
										leer(arch,reg);
									end;
								importeAcobrar:=totalHs*vec[cate];
								writeln('        ',numEmp,'                 ',totalHs,'                 ',importeAcobrar:0:2);
								totalDiv:=totalDiv + totalHs;
								montoTotalDiv:=montoTotalDiv + importeACobrar;
							end; //depAct=reg.departamento and divAct=reg.division
						writeln();
						writeln('Total de horas división: ',totalDiv);
						writeln('Monto total por división: ',montoTotalDiv:0:2);
						writeln();
						totalDep:=totalDep + totalDiv;
						montoTotalDep:=montoTotalDep + montoTotalDiv;
					end; //depAct=reg.departamento
				writeln('Total horas departamento ',totalDep);
				writeln('Monto total departamento ',montoTotalDep:0:2); 
				writeln();
			end; //reg.departamento<>valorAlto
		close(arch);
	end;

var
	arch:archivo_empleados;
	vectorHoras: vectorHorasExtra;
begin
	//generarArchivo(arch);
	cargarVector(vectorHoras);
	assign(arch,'infoEmp.dat');
	generarReporte(arch,vectorHoras);
end.
