{Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados}
program ejercicio1;
const
	valorAlto=9999;
type
	empleado=record
		numEmpleado:integer;
		apeYNom:string[30];
		edad:integer;
		dni:integer;
	end;

	archivo_empleados=file of empleado;

	
	procedure leer(var arch:archivo_empleados;var dato:empleado);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.numEmpleado:=valorAlto;
	end;
	
	procedure realizarBaja(var arch:archivo_empleados);
	var
		ult,emp:empleado;
		numEmp:integer;
	begin
		reset(arch);
		writeln('Ingrese el número de empleado que desea dar de baja');
		readln(numEmp);
		seek(arch,filesize(arch)-1); //Me posiciono en el último registro
		read(arch,ult); //Me guardo al último
		seek(arch,0); //Me posiciono en el primer elemento para comenzar a recorrer el archivo
		leer(arch,emp);
		while ((emp.numEmpleado<>valorAlto) and (emp.numEmpleado<>numEmp)) do
			leer(arch,emp);
		if (emp.numEmpleado=numEmp) then //Si encontré el código de empleado ingresado por teclado, escribo el elemento guardado en esa posición
			begin
				seek(arch,filepos(arch)-1);
				write(arch,ult);
				seek(arch,filesize(arch)-1); //Me posiciono en el último elemento 
				truncate(arch); //Doy de baja el registro que ya guardé 
			end
		else
			writeln('No existe un empleado con el número ingresado');
	end;
	
	procedure imprimirArchivo(var arch:archivo_empleados);
	var
		emp:empleado;
	begin
		reset(arch);
		while(not(eof(arch))) do
			begin
				read(arch,emp);
				writeln('Número empleado ',emp.numEmpleado,' ;Edad ',emp.edad,' ; DNI ',emp.dni,' ; Apellido y nombre ',emp.apeYNom);
			end;
		writeln('Archivo finalizado');
		close(arch);
	end;
		
var
	arch:archivo_empleados;
begin
	assign(arch,'emp.dat');
	imprimirArchivo(arch);
	realizarBaja(arch);
	imprimirArchivo(arch);
end.
