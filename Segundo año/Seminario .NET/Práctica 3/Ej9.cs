/*¿Qué líneas del siguiente método provocan error de compilación y por qué?*/

var a = 3L;
dynamic b = 32;
object obj = 3;
a = a * 2.0; //El valor de A queda fijo a Long, por lo tanto no se puede hacer una conversión de tipos. 
b = b * 2.0;
b = "hola";
obj = b;
b = b + 11;
obj = obj + 11; //Una variable de tipo object no puede realizar operaciones aritméticas porque no es un tipo numérico
var c = new { Nombre = "Juan" };
var d = new { Nombre = "María" };
var e = new { Nombre = "Maria", Edad = 20 };
var f = new { Edad = 20, Nombre = "Maria" };
f.Edad = 22;  //Los campos de la variable f son solo de lectura, no pueden modificarse.
d = c;
e = d;// No tienen la misma cantidad de elementos
f = e; //No están en el mismo orden, por lo tanto no coinciden en el tipo