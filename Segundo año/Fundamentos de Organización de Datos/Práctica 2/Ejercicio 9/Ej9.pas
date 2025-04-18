{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido
por la empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras. No es necesario que informe tales meses en el reporte.}

program ejercicio9;
const
	valorAlto=9999;
type
	
	venta=record
		cod_cli:integer;
		nomYApeCli:string[30];
		anio:integer;
		mes:integer;
		dia:integer;
		montoVenta:real;
	end;
	
	archivo_ventas=file of venta;
	
//El procedimiento generarArchivo se utilizará una única vez con el fin de crear el archivo 
//sobre el cual es trabajará para resolver el ejercicio.
	
	procedure generarArchivo(var arch:archivo_ventas);
	var
		v:venta;
		carga:Text;
	begin
		assign(carga,'infoVentas.txt');
		assign(arch,'archVentas.dat');
		reset(carga);
		rewrite(arch);
		while (not(eof(carga))) do
			begin
				with v do
					begin
						readln(carga,cod_cli,nomYApeCli);
						readln(carga,anio,mes,dia,montoVenta);
					end;
				write(arch,v);
			end;
		writeln('Archivo binario cargado');
		close(carga);
		close(arch);
	end;
	
{--------------------------------------------------------------------------------------------------------}
	
	procedure leer(var arch:archivo_ventas;var dato:venta);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.cod_cli:=valorAlto;
	end;
	
	procedure generarReporte(var arch:archivo_ventas);
	var
		reg:venta;
		codCli,anio,mes:integer;
		totalAnio,totalMes,totalEmpresa:real;
		nomYApeCli:string[30];
	begin
		reset(arch);
		leer(arch,reg);
		totalEmpresa:=0;
		while (reg.cod_cli<>valorAlto) do
			begin
				codCli:=reg.cod_cli;
				nomYApeCli:=reg.nomYApeCli;
				writeln('DATOS DEL CLIENTE');
				writeln('Codigo de cliente: ',codCli,'; Nombre y apellido: ',nomYApeCli);
				writeln();
				writeln();
				while (codCli=reg.cod_cli) do
					begin
						writeln('Anio ',reg.anio);
						writeln();
						totalAnio:=0;
						anio:=reg.anio;
						while ((codCli=reg.cod_cli) and (anio=reg.anio)) do
							begin
								writeln('Mes ',reg.mes);
								writeln();
								mes:=reg.mes;
								totalMes:=0;
								while ((codCli=reg.cod_cli) and (anio=reg.anio) and (mes=reg.mes)) do
									begin
										totalMes:=totalMes + reg.montoVenta;
										leer(arch,reg);
									end;
								writeln('Total mes ',totalMes:0:2);
								totalAnio:=totalAnio + totalMes;
							end; //codCli=reg.codCli and anio=reg.anio
						writeln('Total año vendido al cliente ',totalAnio:0:2);
						totalEmpresa:=totalEmpresa + totalAnio;
					end; // codCli=reg.codCli
			end;//reg.cod_cli<>valorAlto
		writeln('Total vendido por la empresa ',totalEmpresa:0:2);
		close(arch);
	end;

var
	arch:archivo_ventas;
begin
	//generarArchivo(arch);
	assign(arch,'archVentas.dat');
	generarReporte(arch);
end.
