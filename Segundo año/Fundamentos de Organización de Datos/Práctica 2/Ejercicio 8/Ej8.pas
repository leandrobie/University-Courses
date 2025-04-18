{Se quiere optimizar la gestión del consumo de yerba mate en distintas provincias de
Argentina. Para ello, se cuenta con un archivo maestro que contiene la siguiente
información: código de provincia, nombre de la provincia, cantidad de habitantes y cantidad
total de kilos de yerba consumidos históricamente.
Cada mes, se reciben 16 archivos de relevamiento con información sobre el consumo de
yerba en los distintos puntos del país. Cada archivo contiene: código de provincia y cantidad
de kilos de yerba consumidos en ese relevamiento. Un archivo de relevamiento puede
contener información de una o varias provincias, y una misma provincia puede aparecer
cero, una o más veces en distintos archivos de relevamiento.
Tanto el archivo maestro como los archivos de relevamiento están ordenados por código de
provincia.
Se desea realizar un programa que actualice el archivo maestro en base a la nueva
información de consumo de yerba. Además, se debe informar en pantalla aquellas
provincias (código y nombre) donde la cantidad total de yerba consumida supere los 10.000
kilos históricamente, junto con el promedio consumido de yerba por habitante. Es importante
tener en cuenta tanto las provincias actualizadas como las que no fueron actualizadas.
Nota: cada archivo debe recorrerse una única vez.}

program ejercicio8;
uses SysUtils;
const
	valorAlto=9999;
	dimF=3;
	//dimF=16;
type
	infoMae=record
		cod_provincia:integer;
		nom_provincia:string[15];
		cant_habitantes:integer;
		cantTotalKgYerbaConsumidos:integer;
	end;
	
	infoDet=record
		cod_provincia:integer;
		cantKgYerbaConsumidos:integer;
	end;
	
	detalle= file of infoDet;
	maestro= file of infoMae;
	vector_detalles= array [1..dimF] of detalle;
	vector_regDetalles=array[1..dimF] of infoDet;
		
//Los procedimientos generarUnDetalle, generarDetalles y generarMaestro se utilizarán una única vez
//con el fin de crear los arhivos sobre los cuales se trabajará para resolver el ejercicio

	procedure generarUnDetalle(var det:detalle);
	var
		carga:Text;
		regd:infoDet;
		nomArch:string;
	begin
		rewrite(det);
		writeln('Ingrese el nombre del archivo de texto');
		readln(nomArch);
		assign(carga,nomArch);
		reset(carga);
		while (not(eof(carga))) do
			begin
				with regd do
					readln(carga,cod_provincia,cantKgYerbaConsumidos);
				write(det,regd);
			end;
		writeln('Archivo detalle binario creado');
		close(det);
		close(carga);
	end;
  
	
	procedure generarDetalles(var vecDet:vector_detalles);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			begin
				assign(vecDet[i],'det'+IntToStr(i)+'.dat');
				generarUnDetalle(vecDet[i]);
			end;
	
	end;
	
	procedure generarMaestro(var mae:maestro);
	var
		regm:infoMae;
		carga:Text;
	begin
		assign(mae,'mae.dat');
		assign(carga,'infoProvincias.txt');
		rewrite(mae);
		reset(carga);
		while (not(eof(carga))) do
			begin
				with regm do
					readln(carga,cod_provincia,cant_habitantes,cantTotalKgYerbaConsumidos,nom_provincia);
				write(mae,regm);
			end;
		writeln('Archivo maestro binario cargado');
		close(mae);
		close(carga);
	end;
	
{------------------------------------------------------------------------------------------------------------------}

	procedure leer(var det:detalle;var dato:infoDet);
	begin
		if (not(eof(det))) then
			read(det,dato)
		else
			dato.cod_provincia:=valorAlto;
	end;
	
	procedure minimo(var vecDet:vector_detalles;var vecRegDetalles:vector_regDetalles;var min:infoDet);
	var
		i,pos:integer;
	begin
		min.cod_provincia:=valorAlto;
		
		//Busco la provincia con el menor codigo
		for i:=1 to dimF do
				if (vecRegDetalles[i].cod_provincia<min.cod_provincia) then
					begin
						min:=vecRegDetalles[i];
						pos:=i;
					end;
					
		//Sigo leyendo del detalle que saqué el minimo
		if (min.cod_provincia<>valorAlto) then
			leer(vecDet[pos],vecRegDetalles[pos]);
	end;
	
	procedure actualizarMaestro(var mae:maestro; var vecDetalles:vector_detalles;var vecRegDetalles:vector_regDetalles);
	var
		min:infoDet;
		i:integer;
		regm:infoMae;
		prom:real;
	begin
		for i:=1 to dimF do
			begin
				reset(vecDetalles[i]);
				leer(vecDetalles[i],vecRegDetalles[i]);
			end;
		reset(mae);
		minimo(vecDetalles,vecRegDetalles,min);
		while (min.cod_provincia<>valorAlto) do
			begin
				read(mae,regm);
				
				//Recorro el maestro hasta llegar al codigo del minimo
				while (regm.cod_provincia<>min.cod_provincia) do
					read(mae,regm);
				
				//Una vez que llego al mismo codigo de provincia, actualizo el maestro y sigo sacando el minimo en los detalles
				while ((min.cod_provincia<>valorAlto) and (regm.cod_provincia=min.cod_provincia)) do
					begin
						regm.cantTotalKgYerbaConsumidos:=regm.cantTotalKgYerbaConsumidos + min.cantKgYerbaConsumidos;
						minimo(vecDetalles,vecRegDetalles,min);
					end;
				
				//Una vez que salgo del while, me muevo una posición atras en el maestro y escribo
				seek(mae,filepos(mae)-1);
				write(mae,regm);
				
				//Verifico si la cantidad de yerba del maestro supera los 10.000 y en caso de que lo haga, informo
				//el código de provincia, nombre y promedio consumido de yerba por habitante
				if (regm.cantTotalKgYerbaConsumidos>10000) then
					begin
						prom:=regm.cantTotalKgYerbaConsumidos/regm.cant_habitantes;
						writeln('El código de provincia es ',regm.cod_provincia,'; el nombre de la provincia es ',regm.nom_provincia,'; el promedio consumido de yerba por habitante es ',prom:0:2);
					end;
			end;
		writeln('Actualización finalizada');
		close(mae);
		for i:=1 to dimF do
			close(vecDetalles[i]);
	end;
{----------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

//Procedimientos auxiliares de impresión
	
	procedure imprimirMaestro(var mae:maestro);
			
		procedure imprimirRegMae(prov:infoMae);
		begin
			writeln('Codigo de provincia ',prov.cod_provincia,'; Nombre de la provincia ',prov.nom_provincia,'; Cantidad de habitantes ',prov.cant_habitantes,'; Cantidad total de KG de yerba consumidos históricamente ',prov.cantTotalKgYerbaConsumidos);
		end;
			
	var
		prov:infoMae;
	begin
		reset(mae);
		while(not(eof(mae))) do
			begin
				read(mae,prov);
				imprimirRegMae(prov);
			end;
		writeln('Archivo maestro finalizado');
		close(mae);
	end;
	
	
	procedure imprimirUnDetalle(var det:detalle);
	
		procedure imprimirRegDet(provDet:infoDet);
		begin
			writeln('Código de provincia ',provDet.cod_provincia,'; Kg de yerba consumidos ',provDet.cantKgYerbaConsumidos);
		end;
		
	var
		provDet:infoDet;
	begin
		reset(det);
		while(not(eof(det))) do
			begin
				read(det,provDet);
				imprimirRegDet(provDet);
			end;
		writeln('Archivo detalle finalizado');
		close(det);
	end;
	
	procedure imprimirDetalles(var vecDetalles:vector_detalles);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			begin
				writeln('-------IMPRESION DEL DETALLE ',i,'-------------');
				imprimirUnDetalle(vecDetalles[i]);
			end;
	end;
	
var
	vecDetalles:vector_detalles;
	vecRegDetalles:vector_regDetalles;
	mae:maestro;
	i:integer;
begin
	//generarDetalles(vecDetalles);
	//generarMaestro(mae);
	for i:=1 to dimF do
		assign(vecDetalles[i],'det'+IntToStr(i)+'.dat');
	assign(mae,'mae.dat');
	writeln('-------IMPRESION DEL MAESTRO ANTES DE ACTUALIZAR-------------');
	imprimirMaestro(mae);
	actualizarMaestro(mae,vecDetalles,vecRegDetalles);
	writeln('---------IMPRESION DEL MAESTRO LUEGO DE ACTUALIZAR------------');
	imprimirMaestro(mae);
end.
