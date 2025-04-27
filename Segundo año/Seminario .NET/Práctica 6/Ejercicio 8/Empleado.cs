using System;

namespace teoria6;

public abstract class Empleado
{
    public string Nombre {get;}
    public int DNI {get;}
    public DateTime FechaDeIngreso {get;}
    public double SalarioBase {get; protected set;}
    public abstract double Salario {get;} //Tiene que implementarse en las clases derivadas Administrativo y Vendedor

    public Empleado (string nombre, int dni, DateTime fechaDeIngreso, double salarioBase)
    {
        Nombre=nombre;
        DNI=dni;
        FechaDeIngreso=fechaDeIngreso;
        SalarioBase=salarioBase;
    }

    public abstract void AumentarSalario(); //Tiene que implementarse en las clases derivadas Administrativo y Vendedor

    public virtual void Imprimir(){ 
        Console.WriteLine($"Nombre: {Nombre}, DNI {DNI}, Antigüedad {2022-FechaDeIngreso.Year}");
        Console.WriteLine($"Salario base: {SalarioBase}, Salario {Salario} ");
        Console.WriteLine("-------------");
    }

}
