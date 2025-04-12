/*Ejercicio 4:Codificar la clase Hora de tal forma que el siguiente código produzca la siguiente salida por consola:
Hora h = new Hora(23,30,15);
h.Imprimir()
SALIDA: 23 horas, 30 minutos y 15 segundos
*/
using teoria4;

/*Hora unaHora= new Hora(23,30,15);
Console.WriteLine(unaHora.Imprimir());*/

/*Ejercicio 5: Agregar un segundo constructor a la clase Hora para que pueda especificarse la hora por medio de
un único valor que admita decimales. Por ejemplo 3,5 indica la hora 3 y 30 minutos. Si se utiliza este
segundo constructor, el método imprimir debe mostrar los segundos con tres dígitos decimales.*/

Hora unaHora= new Hora(23,30,15);
Console.WriteLine(unaHora.Imprimir());

unaHora=new Hora(14.43);
Console.WriteLine(unaHora.Imprimir());

unaHora=new Hora(14.45);
Console.WriteLine(unaHora.Imprimir());

unaHora=new Hora(14.45114);
Console.WriteLine(unaHora.Imprimir());


