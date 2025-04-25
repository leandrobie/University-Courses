/*Definir la clase Persona con las siguientes propiedades de lectura y escritura: Nombre de tipo
string, Sexo de tipo char, DNI de tipo int, y FechaNacimiento de tipo DateTime. Además
definir una propiedad de sólo lectura (calculada) Edad de tipo int. Definir un indizador de
lectura/escritura que permita acceder a las propiedades a través de un índice entero. Así, si p es un
objeto Persona, con p[0] se accede al nombre, p[1] al sexo p[2] al DNI, p[3] a la fecha de
nacimiento y p[4] a la edad. En caso de asignar p[4] simplemente el valor es descartado. Observar
que el tipo del indizador debe ser capaz almacenar valores de tipo int, char, DateTime y string.*/

using teoria5;
Persona per= new Persona("Leandro",'m',44006926,DateTime.Now);
Console.WriteLine($"El nombre de la persona es {per[0]}, sexo {per[1]}, DNI {per[2]}, fecha de nacimiento {per[3]}, edad {per[4]}");
Console.WriteLine($"El nombre de la persona es {per._nombre}"); 



