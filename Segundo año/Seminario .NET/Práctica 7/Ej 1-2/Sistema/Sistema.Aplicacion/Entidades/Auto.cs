namespace Sistema.Aplicacion.Entidades;
public class Auto:IEsVendible,IEsLavable,IEsReciclable
{
    public void Vender(Persona p)=> Console.WriteLine("Vendiendo auto a persona");
    public void Lavar()=> Console.WriteLine("Lavando auto");
    public void Secar()=> Console.WriteLine("Secando auto");
    public void Reciclar()=> Console.WriteLine("Reciclando auto");
}