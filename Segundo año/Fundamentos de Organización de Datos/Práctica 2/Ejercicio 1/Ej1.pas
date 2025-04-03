{Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}

program ejercicio1;
const
	valorAlto=9999;
type
	empleado=record
		cod:integer;
		nombre:string[10];
		montoComision:real;
	end;
	
	archivo_empleados=file of empleado;
	
	//El siguiente procedimiento se utiliza solo una vez para generar el archivo
	// donde se trabajará para resolver el ejercicio
	procedure generarArhivo(var arch:archivo_empleados);
	
		procedure leerEmpleado(var e:empleado); //Ingresar empleados con mismo codigo y en orden
		begin
			writeln('Ingrese el código del empleado, o 0 para salir');
			readln(e.cod);
			if (e.cod<>0) then
				begin
					writeln('Ingrese el nombre:');
					readln(e.nombre);
					writeln('Ingrese el monto de la comisión:');
					readln(e.montoComision);
				end;
		end;
		
	var
		e:empleado;
		nomArch:string;
	begin
		writeln('Ingrese el nombre del archivo');
		readln(nomArch);
		assign(arch,nomArch); //empleados.dat
		rewrite(arch);
		leerEmpleado(e);
		while (e.cod<>0) do
			begin
				write(arch,e);
				leerEmpleado(e);
			end;
		writeln('Archivo generado');
		close(arch);
	end;
	
	
	
	procedure leer( var arch:archivo_empleados; var dato:empleado);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.cod:=valorAlto;
	end;
	
	procedure recorrerArchivo(var arch,archNue:archivo_empleados); 
	var															
		emp,empAct:empleado;
		montoTotal:real;
	begin
		reset(arch);
		rewrite(archNue);
		leer(arch,emp);
		while (emp.cod<>valorAlto) do
			begin
				empAct.cod:=emp.cod;
				empAct.nombre:=emp.nombre;
				montoTotal:=0; //Inicializo el monto total para cada empleado distinto
				while (empAct.cod=emp.cod) do 
					begin
						montoTotal:=montoTotal + emp.montoComision; //Acumulo las comisiones del mismo cod de empleado
						leer(arch,emp); //Leo sig empleado
					end;
				empAct.montoComision:=montoTotal; //Asigno el monto total al empleado correspondiente
				write(archNue,empAct); //Escribo el archivo nuevo
			end;
		writeln('Operación finalizada');
		close(arch);
		close(archNue);
	end;
	
	procedure imprimirArchivo(var arch:archivo_empleados);
	
		procedure imprimirEmpleado(e:empleado);
		begin
			if (e.cod<>valorAlto) then
				begin
					writeln('Codigo de empleado ',e.cod);
					writeln('Nombre: ',e.nombre);
					writeln('Monto de comisión: ',e.montoComision:0:3);
				end;
		end;
		
	var
		e:empleado;
	begin
		reset(arch);
		while (not(eof(arch))) do
			begin
				read(arch,e);
				imprimirEmpleado(e);
			end;
		writeln('fin');
		close(arch);
	end;
	
var
	arch,archNue:archivo_empleados;
	nomArch,nomArchNue:string;
begin
	//generarArhivo(arch);
	writeln('Ingrese el nombre del archivo existente'); //empleados.dat
	readln(nomArch);
	writeln('Ingrese el nombre del archivo nuevo'); //empleadosAct.dat
	readln(nomArchNue);
	assign(arch,nomArch);
	assign(archNue,nomArchNue);
	//Las sentencias write y procedimiento imprimirArchivo se utilizan con el fin de hacer un seguimiento del programa y comprobar que cumple lo pedido
	writeln('-------ARCHIVO EXISTENTE-------');
	imprimirArchivo(arch); 
	recorrerArchivo(arch,archNue);
	writeln('-----ARCHIVO NUEVO-----');
	imprimirArchivo(archNue);
end.
