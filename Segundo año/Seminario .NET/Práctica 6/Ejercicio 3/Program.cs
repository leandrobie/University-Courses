/*¿Por qué no funciona el siguiente código? ¿Cómo se puede solucionar fácilmente?

class Auto
{
double velocidad;
public virtual void Acelerar() => Console.WriteLine("Velocidad = {0}", velocidad += 10);
}
class Taxi : Auto
{
public override void Acelerar() => Console.WriteLine("Velocidad = {0}", velocidad += 5);

RTA: el campo velocidad de la clase Auto es privado, por lo tanto solo puede ser accedida desde la misma clase. La solución puede ser
transformarla en una propiedad pública o declararla protected.
*/

