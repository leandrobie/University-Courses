program ejercicio6;
const
	valorAlto=9999;
type
	str30=string[30];
	prenda=record
		cod_prenda:integer;
		descripcion:str30;
		color:str30;
		tipo_prenda:str30;
		stock:integer;
		precio_unitario:real;
	end;
	
	archivo_datos=file of prenda;
	archivo_indice=file of integer;
	
//El procedimiento generarArchivoBinario y generarArchivoIndice se utilizará una única vez con el fin
//de crear el archivo sobre el cual se trabajará para resolver el ejercicio

	procedure generarArchivoBinario (var arch:archivo_datos);
	var
		p:prenda;
		carga:Text;
	begin
		assign(arch,'archivo_prendas.dat');
		assign(carga,'prendas.txt');
		rewrite(arch);
		reset(carga);
		while(not(eof(carga))) do
			begin
				with p do
					begin
						readln(carga,cod_prenda,descripcion);
						readln(carga,stock,color);
						readln(carga,precio_unitario,tipo_prenda);
					end;
				write(arch,p);	
			end;
		writeln('Archivo binario cargado');
		close(arch);
		close(carga);
	end;
	
	
	procedure generarArchivoIndice(var arch:archivo_indice);
	var
		carga:Text;
		num:integer;
	begin
		assign(arch,'archivo_indice.dat');
		assign(carga,'indice.txt');
		rewrite(arch);
		reset(carga);
		while (not(eof(carga))) do
			begin
				read(carga,num);
				write(arch,num);
			end;
		writeln('Archivo indice cargado');
		close(carga);
		close(arch);
	end;
	
{-----------------------------------------------------------------------------------------------------------------------------------------}
	
	procedure leerIndice(var arch_indice:archivo_indice;var dato:integer);
	begin
		if (not(eof(arch_indice))) then
			read(arch_indice,dato)
		else
			dato:=valorAlto;
	end;
	
	procedure leerArchDatos(var arch_datos:archivo_datos;var dato:prenda);
	begin
		if (not(eof(arch_datos))) then
			read(arch_datos,dato)
		else
			dato.cod_prenda:=valorAlto;
	end;
	
{procedimiento de bajas}

	procedure darBajas(var arch_datos:archivo_datos;var arch_indice:archivo_indice);
	var
		cod:integer;
		p:prenda;
	begin
		reset(arch_datos);
		reset(arch_indice);
		leerIndice(arch_indice,cod);
		while (cod<>valorAlto) do {si el codigo está en el indice, entonces está en el maestro}
			begin
				leerArchDatos(arch_datos,p);
				while ((p.cod_prenda<>valorAlto) and (p.cod_prenda<>cod)) do {mientras el codigo de prenda del arch de datos<>al cod indice, sigo leyendo}
					leerArchDatos(arch_datos,p);
				p.stock:=p.stock*-1; {paso el stock a negativo}
				seek(arch_datos,filepos(arch_datos)-1); {me muevo una posición atrás para posicionarme dentro del registro que modifiqué}
				write(arch_datos,p); {actualizo el registro}
				seek(arch_datos,0); {me voy al comienzo del archivo de datos para recorrer denuevo}
				leerIndice(arch_indice,cod); {leo el siguiente codigo del archivo indice}
			end;
		writeln('Finalizado');
		close(arch_indice);
		close(arch_datos);
	end;
	
{procedimiento para generar la estructura auxiliar}

	procedure generarArchivoNuevo(var arch_nue:archivo_datos;var arch_datos:archivo_datos);
	var
		p:prenda;
	begin
		reset(arch_datos);
		rewrite(arch_nue);
		leerArchDatos(arch_datos,p);
		while (p.cod_prenda<>valorAlto) do {mientras no llegue al fin del archivo de datos, recorro}
			begin
				if (p.stock>0) then {si el stock es >0 significa que no es negativo, por lo tanto no fue dado de baja}
					write(arch_nue,p); {escribo el registro en el archivo nuevo}
				leerArchDatos(arch_datos,p);
			end;
		writeln('Archivo nuevo cargado');
		close(arch_datos);
		close(arch_nue);
		erase(arch_datos);
		rename(arch_nue,'archivo_prendas.dat');
	end;
	
{procedimiento auxiliar de impresion}

	procedure imprimirArchivo(var arch:archivo_datos);
	var
		p:prenda;
	begin
		reset(arch);
		leerArchDatos(arch,p);
		while (p.cod_prenda<>valorAlto) do
			begin
				writeln('Codigo de prenda ',p.cod_prenda,'; Descripcion ',p.descripcion,'; Color ',p.color,'; Tipo de prenda ',p.tipo_prenda,'; Stock ',p.stock,'; Precio unitario ',p.precio_unitario:0:2);
				leerArchDatos(arch,p);
			end;
		writeln('Finalizado');
		close(arch);
	end;
	
	
var
	arch_datos,arch_nue:archivo_datos;
	arch_indice:archivo_indice;
begin
	//generarArchivoBinario(arch_datos);
	//generarArchivoIndice(arch_indice);
	assign(arch_datos,'archivo_prendas.dat');
	assign(arch_indice,'archivo_indice.dat');
	assign(arch_nue,'archivo_datos_nuevo.dat');
	darBajas(arch_datos,arch_indice);
	generarArchivoNuevo(arch_nue,arch_datos);
	imprimirArchivo(arch_nue);
end.
