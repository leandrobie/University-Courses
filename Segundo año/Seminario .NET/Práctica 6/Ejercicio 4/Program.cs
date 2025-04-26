/* Contestar sobre el siguiente programa:
Taxi t = new Taxi(3);
Console.WriteLine($"Un {t.Marca} con {t.Pasajeros} pasajeros");
class Auto
{
public string Marca { get; private set; } = "Ford";
public Auto(string marca) => this.Marca = marca;
public Auto() { }
}
class Taxi : Auto
{
public int Pasajeros { get; private set; }
public Taxi(int pasajeros) => this.Pasajeros = pasajeros;
}
¿Por qué no es necesario agregar :base en el constructor de Taxi? Eliminar el segundo constructor de
la clase Auto y modificar la clase Taxi para el programa siga funcionando.

RTA: No es necesario agregar :base en el constructor de Taxi debido a que, en la clase Auto, se cuenta con un constructor 
"por defecto" (es decir, que no recibe parámetros). Lo que permite a la clase Taxi no tener que llamar al constructor de
la superclase de manera explícita (con el :base).
Al eliminar el segundo constructor de la clase Auto, hay que modificar el constructor de la clase Taxi añadiéndole :base.
*/

