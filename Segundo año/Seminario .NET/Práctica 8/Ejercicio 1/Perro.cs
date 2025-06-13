using System;
using Sistema.Aplicacion.Interfaces;

namespace Sistema.Aplicacion.Entidades;

public class Perro : IEsAtendible, IEsVendible, IEsLavable, INombrable
{
    public String Nombre { get; set; }
    public void Vender(Persona p)
    {
        Console.WriteLine($"VENDIENDO PERRO A PERSONA");
    }
    public void Atiende()
    {
        Console.WriteLine($"ATENDIENDO A PERRO");
    }
    public void Lavar() => Console.WriteLine("Lavando perro");
    public void Secar() => Console.WriteLine("Secando perro");
    public int CompareTo(object? obj)
    {
        int result = 0;
        if (obj is INombrable p)
        {
            string nombre = p.Nombre;
            result = this.Nombre.CompareTo(nombre);
        }
        return result;
    }

    public override string ToString() => $"{this.Nombre} es un perro";

}
