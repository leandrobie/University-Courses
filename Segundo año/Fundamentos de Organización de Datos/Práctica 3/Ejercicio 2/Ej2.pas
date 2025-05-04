{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.
}
program ejercicio2;
const
	valorAlto=9999;
type
	asistente=record
		nroAsistente:integer;
		apeYNom:string[30];
		email:string[15];
		tel:integer;
		dni:integer;
	end;
	
	archivo_asistentes=file of asistente;
	
//Se genera el archivo	

	procedure generarArchivo(var arch:archivo_asistentes);
	var
		carga:Text;
		a:asistente;
	begin
		assign(arch,'arch.dat');
		assign(carga,'info_asistentes.txt');
		rewrite(arch);
		reset(carga);
		while (not(eof(carga))) do
			begin
				with a do
					begin
						readln(carga,nroAsistente,tel,dni,apeYNom);
						readln(carga,email);
					end;
				write(arch,a);
			end;
		writeln('Archivo cargado');
		close(arch);
		close(carga);
	end;
	
{------------------------------------------------------------------------------------------------------------------------------------------------}

	procedure leer(var arch:archivo_asistentes;var dato:asistente);
	begin
		if (not(eof(arch))) then
			read(arch,dato)
		else
			dato.nroAsistente:=valorAlto;
	end;
	
	
	procedure generarBajasLogicas(var arch:archivo_asistentes);
	var
		a:asistente;
	begin
		reset(arch);
		leer(arch,a);
		while(a.nroAsistente<>valorAlto) do
			begin
				if (a.nroAsistente<1000) then //Si el nro de asistente es menor a 1000,se le agrega una marca de borrado adelante del apellido
					begin
						a.apeYNom:='@' + a.apeYNom;
						seek(arch,filepos(arch)-1);
						write(arch,a);
					end;
				leer(arch,a);
			end;
		writeln('Finalizado');
		close(arch);
	end;
	
	
	procedure imprimirArchivoBinario(var arch:archivo_asistentes);
	var
		a:asistente;
	begin
		reset(arch);
		while (not(eof(arch))) do
			begin
				read(arch,a);
				writeln('Número de asistente: ',a.nroAsistente,'; Apellido y nombre: ',a.apeYNom,'; Email: ',a.email,'; Telefono ',a.tel,'; DNI ',a.dni);
			end;
		writeln('Finalizado');
		close(arch);
	end;
	
var
	arch:archivo_asistentes;
begin
	assign(arch,'arch.dat');
	generarBajasLogicas(arch);
	imprimirArchivoBinario(arch);
end.
