{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información está ordenada por código de provincia y código de localidad.}
program ejercicio10;
const
	valorAlto=9999;
type
	mesa_electoral=record
		cod_prov:integer;
		cod_localidad:integer;
		num_mesa:integer;
		cant_votos:integer;
	end;
	
archivo_votos=file of mesa_electoral;

//El procedimiento generarArchivo se utilizará una única vez con el fin de 
// creal el archivo sobre el cual se trabajará para resolver el ejercicio

	procedure generarArchivo(var arch:archivo_votos);
	var
		carga:Text;
		mesa:mesa_electoral;
	begin
		assign(carga,'infoMesas.txt');
		assign(arch,'infoMesasBinario.dat');
		reset(carga);
		rewrite(arch);
		while (not (eof (carga))) do
			begin
				with mesa do
					readln(carga,cod_prov,cod_localidad,num_mesa,cant_votos);
				write(arch,mesa);
			end;
		writeln('Archivo binario cargado');
		close(arch);
		close(carga);
	end;
	
{-----------------------------------------------------------------------------------------------------------------------------------}

	procedure leer(var arch:archivo_votos;var dato:mesa_electoral);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.cod_prov:=valorAlto;
	end;
	

	procedure generarReporte(var arch:archivo_votos);
	var
		codProv,codLoc,totalVotosLoc,totalVotosProv,totalGeneralVotos:integer;
		reg:mesa_electoral;
	begin
		reset(arch);
		leer(arch,reg);
		totalGeneralVotos:=0;
		while (reg.cod_prov<>valorAlto) do
			begin
				codProv:=reg.cod_prov;
				totalVotosProv:=0;
				writeln('Código de provincia ');
				writeln('           ',codProv);
				writeln();
				writeln('Código de localidad    Total de votos');
				while (codProv=reg.cod_prov) do
					begin
						totalVotosLoc:=0;
						codLoc:=reg.cod_localidad;
						write('           ',codLoc);
					while ((codProv=reg.cod_prov) and (codLoc=reg.cod_localidad)) do
						begin
							totalVotosLoc:=totalVotosLoc + reg.cant_votos;
							leer(arch,reg);
						end;
					totalVotosProv:=totalVotosProv + totalVotosLoc;
					write('                ',totalVotosLoc);
					writeln();
					end;//codProv=reg.cod_prov
				totalGeneralVotos:=totalGeneralVotos + totalVotosProv;
				writeln();
				writeln('Total de votos Provincia: ',totalVotosProv);
				writeln();
				writeln();
			end; //reg.cod_prov<>valorAlto
		writeln('Total general de votos: ',totalGeneralVotos);
	end;

var
	arch:archivo_votos;
begin
	
	//enerarArchivo(arch);
	assign(arch,'infoMesasBinario.dat');
	generarReporte(arch);
end.
