namespace Automotores;

public class Auto(string marca, int modelo)
{
    public Auto() : this("Fiat", DateTime.Now.Year) { }
    public Auto(string marca) : this(marca, DateTime.Now.Year) { }
    public string GetDescripcion() => $"Auto {marca} {modelo}";
}
