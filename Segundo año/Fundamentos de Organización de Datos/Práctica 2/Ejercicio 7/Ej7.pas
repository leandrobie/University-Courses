{Se dispone de un archivo maestro con información de los alumnos de la Facultad de
Informática. Cada registro del archivo maestro contiene: código de alumno, apellido, nombre,
cantidad de cursadas aprobadas y cantidad de materias con final aprobado. El archivo
maestro está ordenado por código de alumno.
Además, se tienen dos archivos detalle con información sobre el desempeño académico de
los alumnos: un archivo de cursadas y un archivo de exámenes finales. El archivo de
cursadas contiene información sobre las materias cursadas por los alumnos. Cada registro
incluye: código de alumno, código de materia, año de cursada y resultado (solo interesa si la
cursada fue aprobada o desaprobada). Por su parte, el archivo de exámenes finales
contiene información sobre los exámenes finales rendidos. Cada registro incluye: código de
alumno, código de materia, fecha del examen y nota obtenida. Ambos archivos detalle
están ordenados por código de alumno y código de materia, y pueden contener 0, 1 o
más registros por alumno en el archivo maestro. Un alumno podría cursar una materia
muchas veces, así como también podría rendir el final de una materia en múltiples
ocasiones.
Se debe desarrollar un programa que actualice el archivo maestro, ajustando la cantidad
de cursadas aprobadas y la cantidad de materias con final aprobado, utilizando la
información de los archivos detalle. Las reglas de actualización son las siguientes:
● Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas
aprobadas.
● Si un alumno aprueba un examen final (nota >= 4), se incrementa en uno la cantidad
de materias con final aprobado.
Notas:
● Los archivos deben procesarse en un único recorrido.
● No es necesario comprobar que no haya inconsistencias en la información de los
archivos detalles. Esto es, no puede suceder que un alumno apruebe más de una
vez la cursada de una misma materia (a lo sumo la aprueba una vez), algo similar
ocurre con los exámenes finales.}

program ejercicio7;
const
	valorAlto=9999;
type
	infoMae=record
		cod_alu:integer;
		apeYNom:string[30];
		cant_cursadas_aprobadas:integer;
		cant_finales_aprobados:integer;
	end;
	
	infoDetCursada=record
		cod_alu:integer;
		cod_materia:integer;
		anio_cursada:integer;
		resultado:string[11];
	end;
	
	infoDetFinal=record
		cod_alu:integer;
		cod_materia:integer;
		fecha:string[15];
		nota:integer;
	end;
	
	maestro=file of infoMae;
	detalle_cursadas= file of infoDetCursada;
	detalle_finales= file of infoDetFinal;
	
//Los procedimientos generarMaestro, generarDetalleCursadas y generarDetalleFinales se utilizarán una única
//vez con el fin de crear los archivos sobre los cuales se trabajará para resolver el ejercicio.

	procedure generarDetalleCursadas(var detCursadas:detalle_cursadas);
	var
		carga:Text;
		cursada:infoDetCursada;
	begin
		assign(detCursadas,'detCursadas.dat');
		rewrite(detCursadas);
		assign(carga,'cursadas.txt');
		reset(carga);
		while (not(eof(carga))) do
			begin
				with cursada do
					readln(carga,cod_alu,cod_materia,anio_cursada,resultado);
				write(detCursadas,cursada);
			end;
		writeln('Archivo detalle de cursadas cargado');
		close(carga);
		close(detCursadas);
	end;
		
	procedure generarDetalleFinales(var detFinales:detalle_finales);
	var
		carga:Text;
		examenFinal:infoDetFinal;
	begin
		assign(detFinales,'detFinales.dat');
		rewrite(detFinales);
		assign(carga,'finales.txt');
		reset(carga);
		while (not(eof(carga))) do
			begin
				with examenFinal do
					readln(carga,cod_alu,cod_materia,nota,fecha);
				write(detFinales,examenFinal);
			end;
		writeln('Archivo detalle finales cargado');
		close(carga);
		close(detFinales);
	end;
	
	procedure generarMaestro(var mae:maestro);
	var
		alu:infoMae;
		carga:Text;
	begin
		assign(carga,'maestro.txt');
		reset(carga);
		assign(mae,'mae.dat');
		rewrite(mae);
		while (not(eof(carga))) do
			begin
				with alu do
					readln(carga,cod_alu,cant_cursadas_aprobadas,cant_finales_aprobados,apeYNom);
				write(mae,alu);
			end;
		writeln('Archivo maestro cargado');
		close(carga);
		close(mae);
	end;
	
{----------------------------------------------------------------------------------------------------------------------}
	
	procedure leerDetCursada(var detCursada:detalle_cursadas;var dato:infoDetCursada);
	begin
		if (not(eof(detCursada))) then
			read(detCursada,dato)
		else
			dato.cod_alu:=valorAlto;
	end;
	
	procedure leerDetFinal(var detFinal:detalle_finales;var dato:infoDetFinal);
	begin
		if (not(eof(detFinal))) then
			read(detFinal,dato)
		else
			dato.cod_alu:=valorAlto;
	end;
		
	
	procedure actualizarMaestro(var mae:maestro; var detCursada:detalle_cursadas; var detFinales:detalle_finales);
	var
		regm:infoMae;
		regdCursada:infoDetCursada;
		regdFinal:infoDetFinal;
	begin
		reset(mae);
		reset(detCursada);
		reset(detFinales);
		leerDetCursada(detCursada,regdCursada);
		leerDetFinal(detFinales,regdFinal);
		while ((regdCursada.cod_alu<>valorAlto) or (regdFinal.cod_alu<>valorAlto)) do
			begin
				read(mae,regm);
				
				//Busco en el detalle de cursadas el cod alu del maestro
				while ((regdCursada.cod_alu<>valorAlto) and (regdCursada.cod_alu<regm.cod_alu)) do
			    begin 
					leerDetCursada(detCursada,regdCursada);
				end;
					
				//Una vez que encuentro el mismo codigo, actualizo de ser necesario
				while (regdCursada.cod_alu=regm.cod_alu) do
					begin
						if (regdCursada.resultado=' Aprobado') then
							regm.cant_cursadas_aprobadas:=regm.cant_cursadas_aprobadas + 1;
						leerDetCursada(detCursada,regdCursada);
					end;
				
				//Busco en el detalle de finales el cod alu del maestro
				while ((regdFinal.cod_alu<>valorAlto) and (regdFinal.cod_alu<regm.cod_alu)) do begin 
					leerDetFinal(detFinales,regdFinal);
				end;
				
				//Una vez que encuentro el mismo cod, le incremento a la cantidad de finales si cumple la condición
				while (regdFinal.cod_alu=regm.cod_alu) do
					begin
						if (regdFinal.nota>=4) then
							regm.cant_finales_aprobados:=regm.cant_finales_aprobados + 1;
						leerDetFinal(detFinales,regdFinal);
					end;
				seek(mae,filepos(mae)-1);
				write(mae,regm);
			end;
		writeln('Archivo maestro actualizado');
		close(mae);
		close(detCursada);
		close(detFinales);
	end;

{------------------------------------------------------------------------------------------------------------------}


	procedure imprimirMaestro(var mae:maestro);
	
		procedure imprimirAlumno(alu:infoMae);
		begin
			writeln('Codigo de alumno ',alu.cod_alu,' ; Nombre y apellido ',alu.apeYNom,'; Cantidad de cursadas aprobadas ',alu.cant_cursadas_aprobadas,' ; Cantidad de finales aprobados ',alu.cant_finales_aprobados);
		end;
	var
		alu:infoMae;
	begin
		reset(mae);
		while (not(eof(mae))) do
			begin
				read(mae,alu);
				imprimirAlumno(alu);
			end;
		writeln('Archivo maestro finalizado');
		close(mae);
	end;
	
	procedure imprimirDetalleCursada(var detCursada:detalle_cursadas);
	
		procedure imprimirAluCursada(alu:infoDetCursada);
		begin
			writeln('Codigo de alumno ',alu.cod_alu,'; Codigo de materia ',alu.cod_materia,' ;Año de cursada ',alu.anio_cursada,'; resultado ',alu.resultado);
		end;
		
	var
		alu:infoDetCursada;
	begin
		reset(detCursada);
		while (not(eof(detCursada))) do
			begin
				read(detCursada,alu);
				imprimirAluCursada(alu);
			end;
		close(detCursada);
	end;
	
	procedure imprimirDetalleFinal(var detFinal:detalle_finales);
	
		procedure imprimirAluFinal(alu:infoDetFinal);
		begin
			writeln('Codigo de alumno ',alu.cod_alu,'; Codigo de materia ',alu.cod_materia,'; Fecha ',alu.fecha,'; Nota ',alu.nota);
		end;
	
	var
		alu:infoDetFinal;
	begin
		reset(detFinal);
		while (not(eof(detFinal))) do
			begin
				read(detFinal,alu);
				imprimirAluFinal(alu);
			end;
		close(detFinal);
	end;
	
var
	detCursadas:detalle_cursadas;
	detFinales:detalle_finales;
	mae:maestro;
begin
	//generarDetalleCursadas(detCursadas);
	//generarDetalleFinales(detFinales);
	//generarMaestro(mae);
	assign(detCursadas,'detCursadas.dat');
	assign(detFinales,'detFinales.dat');
	assign(mae,'mae.dat');
	actualizarMaestro(mae,detCursadas,detFinales);
	imprimirMaestro(mae);
end.
