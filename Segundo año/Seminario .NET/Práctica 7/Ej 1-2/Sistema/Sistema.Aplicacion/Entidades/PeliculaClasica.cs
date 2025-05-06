using System;

namespace Sistema.Aplicacion.Entidades;

public class PeliculaClasica : Pelicula, IEsVendible
{
    public override void SeAlquila(Persona p) => Console.WriteLine("Alquilando película clásica a persona");
    public override void Devolver(Persona p)=> Console.WriteLine("Película clásica devuelta por persona");
    public  void Vender(Persona p)=> Console.WriteLine("Vendiendo película clasica a persona");

}
