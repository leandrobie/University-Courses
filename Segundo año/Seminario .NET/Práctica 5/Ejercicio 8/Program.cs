/*Dada la siguiente definición incompleta de clase:

class ListaDePersonas
{
public void Agregar(Persona p)
{
. . .
}
. . .
}

Completarla y agregar dos indizadores de sólo lectura
Un índice entero que permite acceder a las personas de la lista por número de documento. Por ejemplo
p=lista[30456345] devuelve el objeto Persona que tiene DNI=30456345 o null en caso que no
exista en la lista.
Un índice de tipo char que devuelve un List<string> con todos los nombres de las personas de la
lista que comienzan con el carácter pasado como índice*/

using teoria5;
ListaDePersonas listPer=new ListaDePersonas();
Persona p1= new Persona("Leandro",'m',44006926,DateTime.Now);
Persona p2= new Persona("Leonel",'m',37386533,DateTime.Today);
Persona p3= new Persona("Alejo",'m',25486302,DateTime.Now);
listPer.Agregar(p1);
listPer.Agregar(p2);
listPer.Agregar(p3);

Persona? p= listPer[44006926];

if (p!=null) Console.WriteLine($"El nombre de la persona es {p._nombre}");
else Console.WriteLine("No existe una persona con el dni ingresado");

List<string> listaNom=listPer['L'];

for (int i=0;i<listaNom.Count;i++)
{
    Console.WriteLine($"Nombre {listaNom[i]}");
}



