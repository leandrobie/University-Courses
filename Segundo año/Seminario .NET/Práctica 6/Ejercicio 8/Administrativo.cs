using System;

namespace teoria6;

public class Administrativo : Empleado
{
    public int Premio {get;set;}
    public Administrativo (string nombre,int DNI, DateTime fechaDeIngreso, double salarioBase) : base(nombre,DNI,fechaDeIngreso,salarioBase){}
  
    public override double Salario=> SalarioBase + Premio;

    public override void AumentarSalario()=>SalarioBase=SalarioBase*(1+ 0.01*(2022-FechaDeIngreso.Year));

    public override void Imprimir()
    {
        Console.Write("Administrativo ");
        base.Imprimir();
    }
    
    
}
