{El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}

program ejercicio2;
const
	valorAlto=9999;
type
	prod_mae=record
		cod:integer;
		nomComercial:string[10];
		precioVenta:real;
		stockAct:integer;
		stockMin:integer;
	end;
	
	prod_det=record
		cod:integer;
		cantVendidas: integer;
	end;
	
	maestro=file of prod_mae;
	detalle=file of prod_det;
	
	//Los procedimientos generarDetalle y generarMaestro solo se utilizarán una única vez
	//con el fin de generar los archivos sobre los cuales se trabajará para resolver el ejercicio
	
	procedure generarDetalle(var arch:detalle);
	
		procedure leerProdDet(var p:prod_det);
		begin
			writeln('Ingrese el código del producto o 0 para finalizar');
			readln(p.cod);
			if (p.cod<>0) then
				begin
					writeln('Ingrese la cantidad de unidades vendidas');
					readln(p.cantVendidas);
				end;
		end;
	
	var
		p:prod_det;
		nomArch:string;
	begin
		writeln('Ingrese el nombre del archivo detalle'); //prod_det.dat
		readln(nomArch);
		assign(arch,nomArch);
		rewrite(arch);
		leerProdDet(p);
		while (p.cod<>0) do //Ingresar los datos de manera ordenada, y algunos codigos repetidos
			begin
				write(arch,p);
				leerProdDet(p);
			end;
		writeln('Archivo detalle finalizado');
		close(arch);
	end;
	
	procedure generarMaestro(var arch:maestro);
		
		procedure leerProdMae(var p:prod_mae);
		begin
			writeln('Ingrese el código del producto o 0 para finalizar');
			readln(p.cod);
			if (p.cod<>0) then
				begin
					writeln('Ingrese el nombre comercial');
					readln(p.nomComercial);
					writeln('Ingrese el precio por venta');
					readln(p.precioVenta);
					writeln('Ingrese el stock actual');
					readln(p.stockAct);
					writeln('Ingrese el stock minimo');
					readln(p.stockMin);
				end;
		end;
		
	var
		p:prod_mae;
		nomArch:string;
	begin
		writeln('Ingrese el nombre del archivo maestro'); //prod_mae.dat
		readln(nomArch);
		assign(arch,nomArch);
		rewrite(arch);
		leerProdMae(p);
		while (p.cod<>0) do
			begin
				write(arch,p);
				leerProdMae(p);
			end;
		writeln('Archivo maestro finalizado');
		close(arch);
	end;
{----------------------------------------------------------------------------------------------------------}

	procedure leer(var det:detalle;var dato:prod_det);
	begin
		if (not(eof(det))) then
			read(det,dato)
		else
			dato.cod:=valorAlto;
	end;

//Opción A
	procedure actualizarMaestro(var det:detalle; var mae:maestro);
	var
		regm:prod_mae;
		regd:prod_det;
	begin
		reset(mae);
		reset(det);
		leer(det,regd);
		while (regd.cod<>valorAlto) do
			begin
				read(mae,regm);
				while(regm.cod<>regd.cod) do
					read(mae,regm);
				while (regm.cod=regd.cod) do
					begin
						regm.stockAct:=regm.stockAct-regd.cantVendidas;
						leer(det,regd);
					end;
				seek(mae,filepos(mae)-1);
				write(mae,regm);
			end;
		writeln('Actualización finalizada');
		close(det);
		close(mae);
	end;

//Opcion B
	procedure generarTexto(var arch:maestro;var archTexto:Text);
	var
		p:prod_mae;
	begin
		reset(arch);
		rewrite(archTexto);
		while (not(eof(arch))) do
			begin
				read(arch,p);
				if (p.stockAct<p.stockMin) then //Formato del txt: primera línea: codigo, nombre comercial
					with p do                    //segunda línea: precio por venta, stock actual y stock mínimo
						begin
							write(archTexto,cod,' ');
							writeln(archTexto,nomComercial);
							write(archTexto,' ',precioVenta:0:3,' ',stockAct,' ',stockMin);
							writeln(archTexto);
						end;
			end;
		writeln('Finalizado');
		close(arch);
		close(archTexto);
	end;
	
{--------------------------------------------------------------------------------}
//Los siguientes procedimientos re implementarán con el fin de hacer un seguimiento
//del programa y comprobar que los archivos se carguen/actualicen de la manera esperada.

		procedure imprimirDetalle(var arch:detalle);
		
			procedure imprimirProdDet(var p:prod_det);
			begin
				write('Código ',p.cod,' ;Cant unidades vendidas ',p.cantVendidas);
				writeln();
			end;
		
		var
			p:prod_det;
		begin
			reset(arch);
			while (not(eof(arch))) do
				begin
					read(arch,p);
					imprimirProdDet(p);
				end;
			close(arch);
		end;
		
		procedure imprimirMaestro(var arch:maestro);
		
			procedure imprimirProdMae(var p:prod_mae);
			begin
				write('Código ',p.cod, ' ;Nombre comercial ',p.nomComercial,' ;Precio por venta ',p.precioVenta,' ;Stock actual ',p.stockAct, ' ; Stock minimo ',p.stockMin);
				writeln();
			end;
		var
			p:prod_mae;
		begin
			reset(arch);
			while (not(eof(arch))) do
				begin
					read(arch,p);
					imprimirProdMae(p);
				end;
			close(arch);
		end;
	
var
	det:detalle;
	mae:maestro;
	carga:Text;
	opc:char;
	nomArch:string;
begin
	//generarDetalle(det);
	//generarMaestro(mae);
	writeln('Opciones');
	writeln('a. Actualizar el archivo maestro con el archivo detalle');
	writeln('b.  Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.');
	writeln('Ingrese una opción');
	readln(opc);
	writeln('Ingrese el nombre del archivo maestro');
	readln(nomArch);
	assign(mae,nomArch);
	if (opc='a') then
		begin
			writeln('Ingrese el nombre del archivo detalle');
			readln(nomArch);
			assign(det,nomArch);
			writeln('--------ARCHIVO MAESTRO ANTES DE ACTUALIZARSE---------');
			imprimirMaestro(mae);
			actualizarMaestro(det,mae);
			writeln('------------ARCHIVO DETALLE---------');
			imprimirDetalle(det);
			writeln('------------ARCHIVO MAESTRO LUEGO DE ACTUALIZARSE----------');
			imprimirMaestro(mae);
		end
	else
		if (opc='b') then
			begin
				writeln('Ingrese el nombre del archivo de texto'); //stock_minimo.txt
				readln(nomArch);
				assign(carga,nomArch);
				generarTexto(mae,carga);
			end
		else
			writeln('Opción incorrecta');
end.
