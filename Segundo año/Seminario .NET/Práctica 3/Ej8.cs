/*Señalar errores de compilación y/o ejecución en el siguiente código*/

object obj = new int[10]; //Para declarar un vector se debe utilizar corchetes ([]) en el tipo de dato al comienzo. 
                            //Además, se está declarando una variable de tipo objeto como vector de enteros, lo que es incorrecto 
                            //ya que un int no puede convertirse en un object.
dynamic dyna = 13;
Console.WriteLine(obj.Length);
Console.WriteLine(dyna.Length);