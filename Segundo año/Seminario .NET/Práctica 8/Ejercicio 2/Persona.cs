using System;
using Sistema.Aplicacion.Interfaces;

namespace Sistema.Aplicacion.Entidades;

public class Persona : IEsAtendible, INombrable
{
    public String Nombre { get; set; }
    public void Atiende()
    {
        Console.WriteLine("ATENDIENDO A PERSONA");
    }
    public int CompareTo(object? obj)
    {
        int result = 0;
        if (obj is INombrable e)
        {
            string nombre = e.Nombre;
            result = this.Nombre.CompareTo(nombre);
        }
        return result;
    }

    public override string ToString() => $"{this.Nombre} es una persona";

    
}
