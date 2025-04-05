/*¿De qué tipo quedan definidas las variables x, y, z en el siguiente código?*/

int i = 10;
var x = i * 1.0;
var y = 1f;
var z = i * y;

//x= double
//y= float
//z=float

//Para comprobar
Console.WriteLine(x.GetType());
Console.WriteLine(y.GetType());
Console.WriteLine(z.GetType());