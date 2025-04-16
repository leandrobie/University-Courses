{Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de
casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}

program ejercicio6;
uses SysUtils;
const
	dimF=3;
	//dimF=10;
	valorAlto=9999;
type
	str10=string[10];
	reg_mae=record
		cod_localidad:integer;
		nombre_localidad:str10;
		cod_cepa:integer;
		nombre_cepa:str10;
		cant_casos_activos:integer;
		cant_casos_nuevos:integer;
		cant_casos_recuperados:integer;
		cant_casos_fallecidos:integer;
	end;
	
	reg_det=record
		cod_localidad:integer;
		cod_cepa:integer;
		cant_casos_activos:integer;
		cant_casos_nuevos:integer;
		cant_casos_recuperados:integer;
		cant_casos_fallecidos:integer;
	end;
	
	maestro=file of reg_mae;
	detalle=file of reg_det;
	vector_detalles=array [1..dimF] of detalle;
	vector_regDetalles=array[1..dimF] of reg_det;
	
	
 //Los procedimientos generarUnDetalle, generarDetalles y generarMaestro se invocarán una única vez
 //con el fin de trabajar sobre dichos archivos para resolver el ejercicio
	procedure generarUnDetalle(var det:detalle);
	
		procedure leerRegDet(var r:reg_det);
		begin
			writeln('Ingrese el codigo de localidad o 0 para finalizar');
			readln(r.cod_localidad);
			if (r.cod_localidad<>0) then
				begin
					writeln('Ingrese el codigo de cepa');
					readln(r.cod_cepa);
					writeln('Ingrese la cantidad de casos activos');
					readln(r.cant_casos_activos);
					writeln('Ingrese la cantidad de casos nuevos');
					readln(r.cant_casos_nuevos);
					writeln('Ingrese la cantidad de casos recuperados');
					readln(r.cant_casos_recuperados);
					writeln('Ingrese la cantidad de casos fallecidos');
					readln(r.cant_casos_fallecidos);
				end;
		end;
	
	var
		r:reg_det;
	begin
		rewrite(det);
		leerRegDet(r);
		while (r.cod_localidad<>0) do
			begin
				write(det,r);
				leerRegDet(r);
			end;
		writeln('Archivo detalle cargado');
		close(det);
	end;
	
	procedure generarDetalles(var vecDet:vector_detalles);
	var
		i:integer;
	begin
		for i:= 1 to dimF do
			begin
				writeln('Entro');
				assign(vecDet[i],'det'+IntToStr(i)+'.dat');
				generarUnDetalle(vecDet[i]);
			end;
	end;
	
	procedure generarMaestro(var mae:maestro);
		
		procedure leerRegMae(var r:reg_mae);
		begin
			writeln('Ingrese el codigo de localidad o 0 para finalizar');
			readln(r.cod_localidad);
			if (r.cod_localidad<>0) then
				begin
					writeln('Ingrese el nombre de la localidad');
					readln(r.nombre_localidad);
					writeln('Ingrese el codigo de cepa');
					readln(r.cod_cepa);
					writeln('Ingrese el nombre de la cepa');
					readln(r.nombre_cepa);
					writeln('Ingrese la cantidad de casos activos');
					readln(r.cant_casos_activos);
					writeln('Ingrese la cantidad de casos nuevos');
					readln(r.cant_casos_nuevos);
					writeln('Ingrese la cantidad de casos recuperados');
					readln(r.cant_casos_recuperados);
					writeln('Ingrese la cantidad de casos fallecidos');
					readln(r.cant_casos_fallecidos);
				end;
		end;	
		
	var
		r:reg_mae;
	begin
		assign(mae,'mae.dat');
		rewrite(mae);
		leerRegMae(r);
		while(r.cod_localidad<>0) do
			begin
				write(mae,r);
				leerRegMae(r);
			end;
		writeln('Archivo maestro cargado');
		close(mae);
	end;
{-----------------------------------------------------------------------------------------------------------------------------}

	procedure leer(var det:detalle;var dato:reg_det);
	begin
		if (not(eof(det))) then
			read(det,dato)
		else
			dato.cod_localidad:=valorAlto;
	end;
	
	procedure minimo(var vecDet:vector_detalles;var vecRegDet:vector_regDetalles;var min:reg_det);
	var
		i,pos:integer;
	begin
		min.cod_localidad:=valorAlto;
		min.cod_cepa:=valorAlto;
		for i:=1 to dimF do
			begin
				if ((vecRegDet[i].cod_localidad<min.cod_localidad) or ((vecRegDet[i].cod_localidad=min.cod_localidad) and (vecRegDet[i].cod_cepa<min.cod_cepa))) then
					begin
						min:=vecRegDet[i];
						pos:=i;
					end;
			end;
		//Avanzo sobre el detalle que saqué el minimo
		if (min.cod_localidad<>valorAlto) then
			leer(vecDet[pos],vecRegDet[pos]);
	end;
	
	procedure actualizarMaestro(var mae:maestro; var vecDet:vector_detalles;var vecRegDet:vector_regDetalles);
	var
		min:reg_det;
		i,cantLocalidadesCasosActivos:integer;
		regMae:reg_mae;
	begin
		cantLocalidadesCasosActivos:=0;
		reset(mae);
		for i:=1 to dimF do
			begin
				reset(vecDet[i]);
				leer(vecDet[i],vecRegDet[i]);
			end;
		minimo(vecDet,vecRegDet,min);
		while (min.cod_localidad<>valorAlto) do
			begin
				read(mae,regMae);
				while (regMae.cod_localidad<>min.cod_localidad) do //Busco la misma localidad
					read(mae,regMae);
				while (regMae.cod_localidad=min.cod_localidad) do
					begin
						while (regMae.cod_cepa<>min.cod_cepa) do //Busco el mismo cod cepa
							read(mae,regMae);
						while (((regMae.cod_localidad=min.cod_localidad) and (regMae.cod_cepa=min.cod_cepa))) do //Una vez que tengo el mismo cod_localidad y cod_cepa, sumo y actualizo
							begin
								regMae.cant_casos_fallecidos:=regMae.cant_casos_fallecidos + min.cant_casos_fallecidos;
								regMae.cant_casos_recuperados:=regMae.cant_casos_recuperados + min.cant_casos_recuperados;
								regMae.cant_casos_activos:=min.cant_casos_activos;
								regMae.cant_casos_nuevos:=min.cant_casos_nuevos;
								minimo(vecDet,vecRegDet,min);
							end;
					end;
						seek(mae,filepos(mae)-1);
						if (regMae.cant_casos_activos>50) then
							cantLocalidadesCasosActivos:=cantLocalidadesCasosActivos + 1;
						write(mae,regMae);
			end;
		writeln('La cantidad de localidades que tienen mas de 50 casos activos es de ',cantLocalidadesCasosActivos);
		close(mae);
		for i:=1 to dimF do
			close(vecDet[i]);
	end;
	
var
	vecDet:vector_detalles;
	vecRegDet:vector_regDetalles;
	mae:maestro;
	i:integer;
begin
	//generarDetalles(vecDet);
	//generarMaestro(mae);
	assign(mae,'mae.dat');
	for i:=1 to dimF do
		assign(vecDet[i],'det'+IntToStr(i)+'.dat');
	actualizarMaestro(mae,vecDet,vecRegDet);
end.
