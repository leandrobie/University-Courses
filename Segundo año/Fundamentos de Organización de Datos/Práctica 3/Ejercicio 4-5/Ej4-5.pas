program ejercicio4y5;
const
	valorAlto=9999;
type
	reg_flor=record
		nombre:string[45];
		codigo:integer;
	end;
	
	tArchFlores=file of reg_flor;
	
//El procedimiento generarArchivoBinario se utilizará una única vez con el fin
//de crear el archivo sobre el cual se trabajará para resolver el ejercicio

	procedure generarArchivoBinario(var arch:tArchFlores);
	var
		flor:reg_flor;
		carga:Text;
	begin
		assign(arch,'archFlo.dat');
		assign(carga,'flores.txt');
		rewrite(arch);
		reset(carga);
		while (not(eof(carga))) do
			begin
				with flor do
					readln(carga,codigo,nombre);
				write(arch,flor);
			end;
		writeln('Archivo binario generado');
	end;
	
{-------------------------------------------------------------------------------------}

{procedimiento de dar de alta una flor}

	procedure agregarFlor(var a:tArchFlores; nombre:string;codigo:integer);
	var
		flor,cabecera:reg_flor;
		pos:integer;
	begin
		reset(a); {abro el archivo}
		flor.nombre:=nombre; {almaceno los datos en la variable flor}
		flor.codigo:=codigo;
		read(a,cabecera); {leo la cabecera}
		if (cabecera.codigo=0) then {si cabecera=0, no hay espacios para reutilizar}
			begin
				seek(a,filesize(a)); {me voy al final del archivo}
				write(a,flor); {escribo en el archivo}
				writeln('Registro agregado al final del archivo');
			end
		else
			begin
				pos:=cabecera.codigo*-1; {paso el codigo de la cabecera a positivo}
				seek(a,pos); {me posiciono en esa posicion}
				read(a,cabecera); {me guardo el registro borrado en la cabecera para actualizarlo posteriormente}
				seek(a,filepos(a)-1); {me voy una posicion antes para posicionarme en el registro que fue dado de baja}
				write(a,flor); {escribo el nuevo registro en esa posición}
				seek(a,0); {voy al comienzo del archivo}
				write(a,cabecera); {actualizo la cabecera}
				writeln('Registro agregado en el NRR ', pos);
			end;
		close(a);
	end;
	
{listar el contenido del archivo omitiendo las flores eliminadas}

	procedure leer(var a:tArchFlores;var dato:reg_flor);
	begin
		if (not(eof(a))) then
			read(a,dato)
		else
			dato.codigo:=valorAlto;
	end;

	procedure listarContenido(var a:tArchFlores);
	var
		flor,cabecera:reg_flor;
	begin
		reset(a);
		read(a,cabecera);
		leer(a,flor);
		while (flor.codigo<>valorAlto) do
			begin
				if (flor.codigo>0) then {si el codigo es mayor a 0 quiere decir que no es negativo. Por lo tanto, es un registro que no fue dado de baja}
					writeln('Nombre de flor ',flor.nombre,'; Codigo: ',flor.codigo); {imprimo el registro si cumple}
				leer(a,flor); {leo el sig}
			end;
		writeln('Listado Finalizado');
	end;
	
{procedimiento de dar de baja una flor}

	procedure eliminarFlor (var a:tArchFlores;flor:reg_flor);
	var
		cabecera,florReg:reg_flor;
	begin
		reset(a);
		read(a,cabecera); {leo la cabecera}
		leer(a,florReg);
		while ((florReg.codigo<>valorAlto) and (florReg.codigo<>flor.codigo)) do {mientras no llegué al final del archivo y no encontré el codigo de flor, sigo recorriendo}
			leer(a,florReg);
		if (florReg.codigo=flor.codigo) then {si encontré la flor}
			begin
				florReg.codigo:=florReg.codigo*-1; {multiplico el codigo por -1 para pasarlo a negativo}
				seek(a,0); {voy al comienzo del archivo}
				cabecera:=florReg; {asigno a la cabecera el registro que di de baja}
				write(a,cabecera); {actualizo la cabecera}
			end
		else
			writeln('No existe una flor con el codigo ingresado');
		close(a);
	end;
	
var
	a:tArchFlores;
	flor:reg_flor;
begin
	//generarArchivoBinario(a);
	assign(a,'archFlo.dat');
	flor.nombre:='Flor cuatro';
	flor.codigo:=4;
	eliminarFlor(a,flor);
	agregarFlor(a,'Flor cinco',5);
	flor.nombre:='Flor cinco';
	flor.codigo:=5;
	eliminarFlor(a,flor);
	listarContenido(a);
end.
