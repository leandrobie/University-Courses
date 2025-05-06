using System;

namespace Sistema.Aplicacion.Entidades;

public class Libro : IEsAlquilable,IEsReciclable
{
    public void SeAlquila (Persona p){
        Console.WriteLine ($"alquilando libro a persona");
    }
    public void Devolver (Persona p){
        Console.WriteLine($"SE DEVUELVE LIBRO POR PERSONA");
    }
    public void Reciclar()=> Console.WriteLine("Reciclando Libro");
}
