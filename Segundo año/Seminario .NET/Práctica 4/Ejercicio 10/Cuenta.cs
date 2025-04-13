using System;

namespace teoria4;

public class Cuenta
{
    double _monto;
    int _titularDNI;
    string? _titularNombre;

    public Cuenta()
    {
        this._titularDNI = 0;
        this._titularNombre = "No especificado";
        this._monto = 0;
    }

    public Cuenta (int dni):this()
    {
        this._titularDNI = dni;
    } 

    public Cuenta (string? nombre): this()
    {
        this._titularNombre = nombre;
    }

    public Cuenta (string? nombre,int dni):this(nombre)
    {
        this._titularDNI = dni;
    }

    public void Imprimir()=> Console.WriteLine($"Nombre: {this._titularNombre}, DNI: {this._titularDNI}, Monto: {this._monto}");
    
    public void Depositar(double monto)
    {
        this._monto+=monto;
    }

    public void Extraer(double monto)
    {
        if (this._monto>=monto)
            this._monto= this._monto - monto;
        else
            Console.WriteLine("Operación cancelada, saldo insuficiente");
    }
    
     
}
