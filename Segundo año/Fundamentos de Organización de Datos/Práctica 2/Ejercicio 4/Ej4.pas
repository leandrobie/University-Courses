{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}

program ejercicio4;
uses SysUtils;
const
	valorAlto=9999;
	dimF=3;
	//dimF=30;
type
	producto=record
		cod:integer;
		nombre:string[10];
		descripcion:string[30];
		stockDisp:integer;
		stockMin:integer;
		precio:real;
	end;
	
	prod_det=record
		cod:integer;
		cantVendidas:integer;
	end;
	
	maestro=file of producto;
	detalle=file of prod_det;
	
	arch_det= array [1..dimF] of  detalle; //Hago 3 detalles pq alta paja hacer 30
	reg_det=array [1..dimF] of prod_det;
	
	
	//Los procedimientos generarDetalles, generarUnDetalle y generarMaestro se utilizarán una única vez
	//con el fin de crear los archivos sobre los cuales se trabajará para resolver el ejercicio.
	
	
	procedure generarUnDetalle(var arch:detalle);
	
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
		writeln('Ingrese el nombre del archivo detalle');
		readln(nomArch);
		assign(arch,nomArch);
		rewrite(arch);
		leerProdDet(p);
		while (p.cod<>0) do
			begin
				write(arch,p);
				leerProdDet(p);
			end;
		writeln('Archivo cargado');
		close(arch);
	end;
	
	procedure generarDetalles(var arch:arch_det);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			generarUnDetalle(arch[i]);
		writeln('Todos los detalles cargados');
	end;
	
	procedure generarMaestro(var arch:maestro);
	
		procedure leerProdMae(var p:producto);
		begin
			writeln('Ingrese el codigo del producto o 0 para finalizar');
			readln(p.cod);
			if (p.cod<>0) then
				begin
					writeln('Ingrese el nombre del producto');
					readln(p.nombre);
					writeln('Ingrese la descripcion del producto');
					readln(p.descripcion);
					writeln('Ingrese el stock disponible');
					readln(p.stockDisp);
					writeln('Ingrese el stock mínimo');
					readln(p.stockMin);
					writeln('Ingrese el precio');
					readln(p.precio);
				end;	
				
		end;
	
	var
		p:producto;
		nomArch:string;
	begin
		writeln('Ingrese el nombre del archivo maestro');
		readln(nomArch);
		assign(arch,nomArch);
		rewrite(arch);
		leerProdMae(p);
		while (p.cod<>0) do
			begin
				write(arch,p);
				leerProdMae(p);
			end;
		writeln('Archivo maestro cargado');
		close(arch);
	end;
	 
{----------------------------------------------------------------------------------------------}	


	procedure leer(var arch:detalle;var dato:prod_det);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.cod:=valorAlto;
	end;
	
	procedure minimo (var vecReg:reg_det;var vecDet:arch_det;var minimo:prod_det); //Saco el minimo del vecReg que contiene el primer registro
	var																				//de todos los vectores, entonces al finalizar, me quedo con el
		i,pos:integer;																//minimo registro, y el índice (pos) correspondiente al detalle (archivo)
	begin																			//de dicho registro
		minimo.cod:=valorAlto;
		for i:=1 to dimF do
			if (vecReg[i].cod<minimo.cod) then
				begin
					minimo:=vecReg[i];
					pos:=i;
				end;
		if (minimo.cod<>valorAlto) then
			leer(vecDet[pos],vecReg[pos]);
	end;
	
	procedure generarReporte(var mae:maestro;var archTexto:Text);
	var
		p:producto;
	begin
		reset(mae);
		assign(archTexto,'sinStock.txt');
		rewrite(archTexto);
		while (not(eof(mae))) do
			begin
				read(mae,p);
				if (p.stockDisp<p.stockMin) then
					with p do
							writeln(archTexto,nombre,' ',descripcion,' ',stockDisp,' ',precio);
			end;
		writeln('Operación finalizada');
		close(archTexto);
		close(mae);
	end;
	
	procedure actualizarMaestro(var vecDet:arch_det;var mae:maestro);
	var
		vecReg:reg_det;
		i:integer;
		min:prod_det;
		regm:producto;
		carga:Text;
	begin
		for i:=1 to dimF do
			begin
				reset(vecDet[i]);
				leer(vecDet[i],vecReg[i]);
			end;
		reset(mae);
		minimo(vecReg,vecDet,min);
		while (min.cod<>valorAlto) do
			begin
				read(mae,regm);
				while (regm.cod<>min.cod) do
					read(mae,regm);
				while ((min.cod<>valorAlto) and (min.cod=regm.cod)) do
					begin
						regm.stockDisp:=regm.stockDisp - min.cantVendidas;
						minimo(vecReg,vecDet,min);
					end;
				seek(mae,filepos(mae)-1);
				write(mae,regm);
			end; //Fin actualizacion archivo
		close(mae);
		generarReporte(mae,carga);
		for i:=1 to dimF do
			close(vecDet[i]);
	end;
	
 //Procedimientos auxiliares de impresión
 
	procedure imprimirMaestro(var mae:maestro);
	
		procedure imprimirProducto(p:producto);
		begin
			writeln('Código: ',p.cod,' ;Nombre producto: ',p.nombre,'; Descripción: ',p.descripcion,' ; Stock disponible ',p.stockDisp,'; Stock minimo: ',p.stockMin,' ;Precio: ',p.precio:0:2);
		end;
	
	var
		p:producto;
	begin
		reset(mae);
		while (not(eof(mae))) do
			begin
				read(mae,p);
				imprimirProducto(p);
			end;
		close(mae);
	end;
	
	procedure imprimirDetalle(var det:detalle);
	
		procedure imprimirProdDet(p:prod_det);
		begin
			writeln('Cod prod ',p.cod,'; Cant ',p.cantVendidas);
		end;
	
	var
		p:prod_det;
	begin
		reset(det);
		while (not(eof(det))) do
			begin
				read(det,p);
				imprimirProdDet(p);
			end;
		close(det);
	end;

var
	mae:maestro;
	det:arch_det;
	i:integer;	
begin
	//generarDetalles(det);} //det1.dat,det2.dat,det3.dat
	//generarMaestro(mae);
	for i:=1 to dimF do
			assign(det[i],('det' + IntToStr(i) +'.dat'));
	assign(mae,'mae.dat');
	writeln('--------IMPRESION DE MAESTRO ANTES DE ACTUALIZAR---------');
	imprimirMaestro(mae);
	actualizarMaestro(det,mae);
	writeln('--------IMPRESION DEL MAESTRO LUEGO DE ACTUALIZAR--------');
	imprimirMaestro(mae);
end.
