using System;

namespace Sistema.Aplicacion.Entidades;

public class Pelicula : IEsAlquilable
{
    public virtual void SeAlquila (Persona p){
        Console.WriteLine ($"SE ALQUILA A PERSONA");
    }
    public virtual void Devolver (Persona p){
        Console.WriteLine($"PELICULA DEVUELTA POR PERSONA");
    }
}
