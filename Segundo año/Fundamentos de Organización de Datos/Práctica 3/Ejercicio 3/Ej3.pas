program ejercicio3;
const
	valorAlto=9999;
type
	novela=record
		cod:integer;
		genero:string[10];
		nombre:string[30];
		duracion:integer;
		director:string[15];
		precio:real;
	end;
	
	archivo_novelas=file of novela;
{-----------------------GENERACIÓN DEL ARCHIVO---------------------------------}
	
	procedure leerNovela(var n:novela);
	begin
		writeln('Ingrese el codigo de la novela: '); readln(n.cod);
		if (n.cod<>0) then
			begin
				writeln('Ingrese el genero de la novela: '); readln(n.genero);
				writeln('Ingrese el nombre de la novela: '); readln(n.nombre);
				writeln('Ingrese le duracion de la novela: '); readln(n.duracion);
				writeln('Ingrese el director de la novela: '); readln(n.director);
				writeln('Ingrese el precio de la novela: '); readln(n.precio);
			end;
	end;

	procedure generarArchivo(var arch:archivo_novelas);
	var
		n:novela;
	begin
		rewrite(arch);
		{--------Se crea el registro cabecera y se agrega como primer registro--------}
		n.cod:=0;
		n.genero:='';
		n.nombre:='';
		n.duracion:=0;
		n.director:='';
		n.precio:=0;
		write(arch,n);
		{---------Comienzo a leer las novelas y las agrego al archivo--------}
		leerNovela(n);
		while (n.cod<>0) do
			begin
				write(arch,n);
				leerNovela(n);
			end;
		writeln('Archivo cargado');
		close(arch);
	end;
	
{-------------MANTENIMIENTO DEL ARCHIVO CON LA TÉCNICA DE LISTA INVERTIDA-------------}

	procedure leer (var arch:archivo_novelas;var dato:novela);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.cod:=valorAlto;
	end;

	procedure darAltaNovela(var arch:archivo_novelas);
	var
		pos:integer;
		cabecera,nov:novela;
	begin
		reset(arch);
		leerNovela(nov);
		leer(arch,cabecera);
		{-----Verifico en el registro cabecera si hay algún espacio para recuperar-----}
		if (cabecera.cod=0) then {si cabecera.cod=0 significa que no hay ningún espacio para recuperar}
			begin
				seek(arch,filesize(arch)); {me voy al final del archivo}
				write(arch,nov); {escribo la novela leída}
			end
		else {si no es 0, significa que hay al menos un espacio para recuperar}
			begin
				pos:=cabecera.cod*-1; {paso a positivo el codigo de la cabecera}
				seek(arch,pos); {voy a esa posición}
				read(arch,cabecera); {me guardo el registro dado de baja en la cabecera para actualizarla posteriormente}
				seek(arch,filepos(arch)-1); {vuelvo una posición atras para posicionarme en el registro dado de baja}
				write(arch,nov); {escribo la novela en el espacio que se dió de baja}
				seek(arch,0); {voy al comienzo del archivo}
				write(arch,cabecera); {actualizo la cabecera}
			end;
		writeln('Novela agregada con exito');
		close(arch);
	end;
	
	procedure darBajaNovela(var arch:archivo_novelas);
	var
		posABorrar,codNovela:integer;
		cabecera,nov:novela;
	begin
		reset(arch);
		writeln('Ingrese el codigo de la novela que desea borrar');
		readln(codNovela);
		leer(arch,cabecera); {leo la cabecera}
		leer(arch,nov); 
		while ((nov.cod<>valorAlto) and (nov.cod<>codNovela)) do {recorro el archivo buscando el codigo de novela} 
			leer(arch,nov);
		if (nov.cod=codNovela) then
			begin
				posABorrar:=filepos(arch)-1; {me guardo el indice}
				seek(arch,posABorrar); {me posiciono en esa posición}
				write(arch,cabecera); {escribo la cabecera en la posición dada de baja}
				nov.cod:=nov.cod*-1; {vuelvo el codigo de la novela negativa}
				seek(arch,0); {voy al comienzo del archivo}
				write(arch,nov); {actualizo la cabecera}
				writeln('Novela dada de baja con exito');
			end
		else
			writeln('No existe una novela con el codigo ingresado');
		close(arch);
	end;

	procedure modificarNovela (var arch:archivo_novelas);
	var
		novNue,novArch:novela;
	begin
		reset(arch);
		leerNovela(novNue);
		leer(arch,novArch);
		while ((novArch.cod<>valorAlto) and (novArch.cod<>novNue.cod)) do
			leer(arch,novArch);
		if (novArch.cod=novNue.cod) then
			begin {actualizo los campos del registro}
				novArch.genero:=novNue.genero;
				novArch.nombre:=novNue.nombre;
				novArch.duracion:=novNue.duracion;
				novArch.director:=novNue.director;
				novArch.precio:=novNue.precio;
				seek(arch,filepos(arch)-1); {voy una posición atrás para posicionarme en el registro que modifiqué}
				write(arch,novArch); {lo actualizo en el archivo}
				writeln('Novela modificada con exito');
			end
		else
			writeln('No existe una novela con el codigo ingresado');
		close(arch);
	end;
	
{-------------------------------LISTADO DE LAS NOVELAS EN ARCHIVO TXT----------------------------------}

	procedure listarNovelas(var arch:archivo_novelas;var carga:Text);
	var
		nov:novela;
	begin
		reset(arch);
		rewrite(carga);
		leer(arch,nov);
		while (nov.cod<>valorAlto) do
			begin
				with nov do
					writeln(carga,cod,' ',genero,' ',nombre,' ',duracion,' ',director,' ',precio:0:3);
				leer(arch,nov);
			end;
		writeln('Archivo listado');
		close(arch);
		close(carga);
	end;
var
	arch:archivo_novelas;
	carga:Text;
	opc:string;
	nomArch:string;
begin
	writeln('OPCIONES');
	writeln('a. Crear el archivo y cargarlo a partir de datos ingresados por teclado');
	writeln('b. abrir el archivo y permitir su mantenimiento: ');
	writeln('c.Listar en un archivo de texto todas las novelas, incluso las eliminadas');
	writeln('Ingrese una opción');
	readln(opc);
	writeln('Ingrese el nombre del archivo binario'); {archNov.dat}
	readln(nomArch);
	assign(arch,nomArch);
	if (opc='a') then
		generarArchivo(arch)
	else 
		if (opc='b') then
			begin
				writeln('b.i:Dar de alta una novela');
				writeln('b.ii:Modificar los datos de una novela');
				writeln('b.iii:Eliminar una novela por codigo');
				writeln('Ingrese una opcion');
				readln(opc);
				if (opc='i') then
					darAltaNovela(arch)
				else
					if (opc='ii') then
						modificarNovela(arch)
					else
						if (opc='iii') then
							darBajaNovela(arch)
						else
							writeln('Opción invalida');
			end
		else 
			if (opc='c') then
				begin
					writeln('Ingrese el nombre del archivo de texto');
					readln(nomArch);
					assign(carga,nomArch); {novelas.txt}
					listarNovelas(arch,carga);
				end
			else
				writeln('Opción inválida');
end.
