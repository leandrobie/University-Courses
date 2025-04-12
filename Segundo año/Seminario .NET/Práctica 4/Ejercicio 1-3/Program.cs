/*Ejercicio 1: Definir una clase Persona con 3 campos públicos: Nombre, Edad y DNI. Escribir un algoritmo que
permita al usuario ingresar en una consola una serie de datos de esta forma:
Nombre,Documento,Edad <ENTER>.

Una vez finalizada la entrada de datos, el programa debe imprimir en la consola un listado con 4
columnas de la siguiente forma:
Nro) Nombre Edad DNI.
NOTA: Se puede utilizar: Console.SetIn(new System.IO.StreamReader(nombreDeArchivo));
para cambiar la entrada estándar de la consola y poder leer directamente desde un archivo de texto.*/

using teoria4;

List<Persona> cantPer=new List<Persona>();

Console.SetIn(new System.IO.StreamReader(@"C:\Users\marce\proyectosDotnet\teoria4\personas.txt"));
string linea;
string[] datos;
while ((linea=Console.ReadLine())!=null)
{
    datos=linea.Split(',');
    Persona p=new Persona();
    p._nombre=datos[0];
    p._edad=int.Parse(datos[1]);
    p._dni=int.Parse(datos[2]);

    cantPer.Add(p);
}

for (int i=0;i<cantPer.Count; i++)
{
    Console.WriteLine($"{i+1}) {cantPer[i]._nombre} {cantPer[i]._edad} {cantPer[i]._dni} ");
}

/*Ejercicio 2:Modificar el programa anterior haciendo privados todos los campos. Definir un constructor adecuado
y un método público Imprimir() que escriba en la consola los campos del objeto con el formato
requerido para el listado.*/
//Se utilizan las mismas variables y lista del ejercicio 1

while ((linea=Console.ReadLine()) != null)
{
    datos=linea.Split(',');
    Persona p= new Persona(datos[0],int.Parse(datos[1]),int.Parse(datos[2]));
    cantPer.Add(p);
}

for (int i=0; i<cantPer.Count;i++)
{
    Console.WriteLine($"{i+1}) " + cantPer[i].Imprimir());
}

/*Ejercicio 3: Agregar a la clase Persona un método EsMayorQue(Persona p) que devuelva verdadero si la
persona que recibe el mensaje tiene más edad que la persona enviada como parámetro. Utilizarlo para
realizar un programa que devuelva la persona más jóven de la lista.*/
Persona perMenor= new Persona("unNombre",999,0); //Inicializo perMenor con edad muy alta para forzarlo a entrar al for
for (int i=0; i<cantPer.Count;i++)
{
    if (perMenor.EsMayorQue(cantPer[i]))
    {
        perMenor=cantPer[i];
    }
}

Console.WriteLine("La persona mas joven de la lista es " + perMenor.Imprimir());

