{A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.}

program ejercicio3;
const
	valorAlto='9999';
type
	str10=string[10];
	prov=record
		nombre:str10;
		cantPerAlfabetizadas:integer;
		totalEncuestados:integer;
	end;
	
	prov_det=record
		nombre:str10;
		codLocalidad:integer;
		cantPerAlfabetizadas:integer;
		totalEncuestados:integer;
	end;
	
	maestro=file of prov;
	detalle=file of prov_det;
	
	//Los procedimientos generarDetalle y generarMaestro se utilizarán una única vez
	//con el fin de generar los archivos necesarios sobre los cuales
	//se trabajará para resolver el ejercicio.
	
	procedure generarDetalle(var arch:detalle);
		
		procedure leerProvDet(var p:prov_det);
		begin
			writeln('Ingrese el nombre de la provincia o ZZZ para salir');
			readln(p.nombre);
			if (p.nombre<>'ZZZ') then
				begin
					writeln('Ingrese el código de localidad');
					readln(p.codLocalidad);
					writeln('Ingrese la cantidad de personas alfabetizadas');
					readln(p.cantPerAlfabetizadas);
					writeln('Ingrese el total de encuestados');
					readln(p.totalEncuestados);
				end;
		end;
		
	var
		p:prov_det;
		nomArch:string;
	begin
		writeln('Ingrese el nombre del archivo detalle');
		readln(nomArch);
		assign(arch,nomArch);
		rewrite(arch);
		leerProvDet(p);
		while(p.nombre<>'ZZZ') do
			begin
				write(arch,p);
				leerProvDet(p);
			end;
		writeln('Archivo cargado');
		close(arch);
	end;
	
	procedure generarMaestro(var arch:maestro);
		
		procedure leerProvMae(var p:prov);
		begin
			writeln('Ingrese el nombre de la provincia o ZZZ para finalizar');
			readln(p.nombre);
			if (p.nombre<>'ZZZ') then
				begin
					writeln('Ingrese la cantidad de personas alfabetizadas');
					readln(p.cantPerAlfabetizadas);
					writeln('Ingrese el total de encuestados');
					readln(p.totalEncuestados);
				end;
		end;	
		
	var
		p:prov;
		nomArch:string;
	begin
		writeln('Ingrese el nombre del archivo maestro');
		readln(nomArch);
		assign(arch,nomArch);
		rewrite(arch);
		leerProvMae(p);
		while (p.nombre<>'ZZZ') do
			begin
				write(arch,p);
				leerProvMae(p);
			end;
		writeln('Archivo cargado');
		close(arch);
	end;

{----------------------------------------------------------------------------------------------------}

	procedure leer(var det:detalle;var dato:prov_det);
	begin
		if (not(eof(det))) then
			read(det,dato)
		else
			dato.nombre:=valorAlto;
	end;

	procedure minimo(var r1,r2,min:prov_det;var det1,det2:detalle); //Busca el minimo por nombre
	begin
		if (r1.nombre<r2.nombre) then
			begin
				min:=r1;
				leer(det1,r1);
			end
		else
			begin
				min:=r2;
				leer(det2,r2);
			end;
	end;

	procedure actualizarMaestro(var mae:maestro;var det1,det2:detalle);
	var
		min,regd1,regd2:prov_det;
		regm:prov;
	begin
		reset(mae);
		reset(det1);
		reset(det2);
		leer(det1,regd1);
		leer(det2,regd2);
		minimo(regd1,regd2,min,det1,det2);
		while(min.nombre<>valorAlto) do
			begin
				read(mae,regm);
				while (regm.nombre<>min.nombre) do
					read(mae,regm);
				while (regm.nombre=min.nombre) do
					begin
						regm.cantPerAlfabetizadas:= regm.cantPerAlfabetizadas + min.cantPerAlfabetizadas;
						regm.totalEncuestados:=regm.totalEncuestados + min.totalEncuestados;
						minimo(regd1,regd2,min,det1,det2);
					end;
				seek(mae,filepos(mae)-1);
				write(mae,regm);
			end;
		writeln('Actualización finalizada');
		close(det1);
		close(det2);
		close(mae);
	end;
{-------------------------------------------------------------------------------------------------------------------------}
//Procedimientos auxiliares de impresión para hacer un seguimiento del programa

	procedure imprimirDetalle(var arch:detalle);
		
		procedure imprimirRegDet(p:prov_det);
		begin
			write('Nombre de provincia ',p.nombre,' ;Código de localidad ',p.codLocalidad,' ;Cantidad de personas alfabetizadas ',p.cantPerAlfabetizadas,' ;Total encuestados ',p.totalEncuestados);
			writeln();
		end;
		
	var
		p:prov_det;
	begin
		reset(arch);
		while (not(eof(arch))) do
			begin
				read(arch,p);
				imprimirRegDet(p);
			end;
		close(arch);
	end;
	
	procedure imprimirMaestro(var arch:maestro);
		
		procedure imprimirRegMae(p:prov);
		begin
			write('Nombre provincia ',p.nombre,' ;Cantidad de personas alfabetizadas ',p.cantPerAlfabetizadas, ' ;Total encuestados ',p.totalEncuestados);
			writeln();
		end;
		
	var
		p:prov;
	begin
		reset(arch);
		while (not(eof(arch))) do
			begin
				read(arch,p);
				imprimirRegMae(p);
			end;
		close(arch);
	end;

var
	det1,det2:detalle;
	mae:maestro;
	nomArch:string;
begin
	//generarDetalle(det1); //prov_det1.dat
	//generarDetalle(det2); //prov_det2.dat
	//generarMaestro(mae); //prov_mae.dat
	writeln('Ingrese el nombre del archivo maestro');
	readln(nomArch);
	assign(mae,nomArch);
	writeln('Ingrese el nombre del archivo detalle 1');
	readln(nomArch);
	assign(det1,nomArch);
	writeln('Ingrese el nombre del archivo detalle 2');
	readln(nomArch);
	assign(det2,nomArch);
	writeln('----------ARCHIVO MAESTRO ANTES DE ACTUALIZAR-----------');
	imprimirMaestro(mae);
	writeln('----------ARCHIVO DETALLE 1--------');
	imprimirDetalle(det1);
	writeln('-----------ARCHIVO DETALLE 2----------');
	imprimirDetalle(det2);
	actualizarMaestro(mae,det1,det2);
	writeln('----------ARCHIVO MAESTRO LUEGO DE ACTUALIZAR--------');
	imprimirMaestro(mae);
end.
