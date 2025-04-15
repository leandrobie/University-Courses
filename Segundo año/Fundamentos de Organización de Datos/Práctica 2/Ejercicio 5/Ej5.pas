{Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program ejercicio5;
uses SysUtils;
const
	dimF=5;
	valorAlto=9999;
type

	sesion=record
		cod_usuario:integer;
		fecha:string;
		tiempo_sesion:real; //El tiempo se cuenta en minutos
	end;
	
	archivo=file of sesion; //Como tienen los mismos datos, solo declaro un tipo de archivo
	vector_detalles= array [1..dimF] of archivo; //Vector que corresponde a la cantidad de maquinas
	vector_regDetalles= array [1..dimF] of sesion;

//El procedimiento generarUnDetalle y generarDetalles se utilizará una única vez con el fin de 
//crear los archivos detalle sobre los cuales se trabajará para resolver el
//ejercicio
	
	procedure generarUnDetalle(var arch:archivo);
			
		procedure leerSesion(var s:sesion);
		begin
			writeln('Ingrese el codigo de usuario o 0 para finalizar');
			readln(s.cod_usuario);
			if (s.cod_usuario<>0) then
			begin
				writeln('Ingrese la fecha');
				readln(s.fecha);
				writeln('Ingrese el tiempo de sesión');
				readln(s.tiempo_sesion);
			end;
		end;
	
	var
		s:sesion;
	begin
		rewrite(arch);
		leerSesion(s);
		while (s.cod_usuario<>0) do
			begin
				write(arch,s);
				leerSesion(s);
			end;
		writeln('Archivo cargado');
		close(arch);
	end;
	
	
	procedure generarDetalles(var vecArch:vector_detalles);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			begin
				assign(vecArch[i],'det'+IntToStr(i)+'.dat');
				generarUnDetalle(vecArch[i]);
			end;
	end;
	
{-------------------------------------------------------------------------------------------------}

procedure leer (var arch:archivo;var dato:sesion);
begin
	if (not(eof(arch))) then
		read(arch,dato)
	else
		dato.cod_usuario:=valorAlto;
end;

procedure minimo (var vecDet:vector_detalles; var vecReg:vector_regDetalles; var min:sesion);
var
	i,pos:integer;
begin
	min.cod_usuario:=valorAlto;
	for i:=1 to dimF do
		if (vecReg[i].cod_usuario<min.cod_usuario) then
			begin
				min:=vecReg[i];
				pos:=i;
			end;
	if (min.cod_usuario<>valorAlto) then
		leer(vecDet[pos],vecReg[pos]);
end;

procedure generarMaestro(var mae:archivo;var vecDet:vector_detalles;var vecRegDet:vector_regDetalles);
var
	min,aux:sesion;
	i:integer;
	tiempo_total_sesion:real;
begin
	rewrite(mae);
	for i:=1 to dimF do
		begin
			reset(vecDet[i]);
			leer(vecDet[i],vecRegDet[i]);
		end;
	minimo(vecDet,vecRegDet,min);
	while (min.cod_usuario<>valorAlto) do
		begin
			aux:=min;
			tiempo_total_sesion:=0;
			while (min.cod_usuario=aux.cod_usuario) do
				begin
					tiempo_total_sesion:=tiempo_total_sesion + min.tiempo_sesion;
					minimo(vecDet,vecRegDet,min);
				end;
			aux.tiempo_sesion:=tiempo_total_sesion;
			write(mae,aux);
		end;
	close(mae);
	for i:=1 to dimF do
		close(vecDet[i]);
end;

{------------------------------------------------------------------------------------------------------------------}

//Procedimientos auxiliares de impresión

procedure imprimirSesion(s:sesion);
begin
	writeln('Codigo de usuario ',s.cod_usuario,'; Fecha ',s.fecha,' ; tiempo total de sesiones abiertas ',s.tiempo_sesion:0:2);
end;


procedure imprimirMaestro(var arch:archivo);
var
	s:sesion;
begin
	reset(arch);
	while (not(eof(arch))) do
		begin
			read(arch,s);
			imprimirSesion(s);
		end;
	writeln('Finalizado');
	close(arch);
end;

procedure imprimirUnDetalle(var det:archivo);
var
	s:sesion;
begin
	reset(det);
	while (not(eof(det))) do
		begin
			read(det,s);
			imprimirSesion(s);
		end;
	writeln('Arch detalle finalizado');
	close(det);
end;

procedure imprimirDetalles(var vecDet:vector_detalles);
var
	i:integer;
begin
	for i:=1 to dimF do
		imprimirUnDetalle(vecDet[i]);
end;
		
var
	vecDetalles:vector_detalles;
	vecRegDet:vector_regDetalles;
	mae:archivo;
	i:integer;
begin
	//generarDetalles(vecDetalles);
	for i:= 1 to dimF do
		assign(vecDetalles[i],'det'+IntToStr(i)+'.dat');
	assign(mae,'C:\Users\marce\OneDrive\Escritorio\FOD\Práctica 2\Ejercicio 5\var\log\mae.dat');
	imprimirDetalles(vecDetalles);
	generarMaestro(mae,vecDetalles,vecRegDet);
	imprimirMaestro(mae);
end.
