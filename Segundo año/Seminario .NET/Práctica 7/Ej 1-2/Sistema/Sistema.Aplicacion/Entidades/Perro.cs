using System;

namespace Sistema.Aplicacion.Entidades;

public class Perro : IEsAtendible, IEsVendible,IEsLavable
{
    public void Vender (Persona p){
        Console.WriteLine ($"VENDIENDO PERRO A PERSONA");
    }
    public void Atiende(){
        Console.WriteLine ($"ATENDIENDO A PERRO");
    }
    public void Lavar()=> Console.WriteLine("Lavando perro");
    public void Secar()=> Console.WriteLine("Secando perro");
}
