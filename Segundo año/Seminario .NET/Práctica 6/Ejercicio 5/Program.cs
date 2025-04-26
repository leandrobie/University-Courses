/* ¿Qué líneas del siguiente código provocan error de compilación y por qué?
class Persona
{
public string Nombre { get; set; }
}
public class Auto
{
private Persona _dueño1, _dueño2;
public Persona GetPrimerDueño() => _dueño1; (1)
protected Persona SegundoDueño (2)
{
set => _dueño2 = value;
}
}

RTA: Los errores están en (1) y (2). Esto es debido a que la clase Persona no está declarada como public. Por lo tanto
no se puede acceder a sus getters y setters desde otra clase.
*/

