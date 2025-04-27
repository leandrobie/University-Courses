using System;

namespace teoria6;

public class Vendedor : Empleado
{
    public double Comision {get;set;}

    public Vendedor(string nombre, int DNI, DateTime fechaDeIngreso,double salarioBase): base(nombre,DNI,fechaDeIngreso,salarioBase){}
    
    public override double Salario=> SalarioBase+Comision;
   

    public override void AumentarSalario()
    {
        if (FechaDeIngreso.Year+10<2022)  SalarioBase+=SalarioBase*0.05; //Si tiene menos de 10 años de antigüedad se le aumenta un 5%, sino un 10%
        else SalarioBase+=SalarioBase*0.10;
    }

    public override void Imprimir()
    {
        Console.Write("Vendedor ");
        base.Imprimir();
    }
    
}
