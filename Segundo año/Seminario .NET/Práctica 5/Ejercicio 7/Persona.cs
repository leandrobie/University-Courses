using System;

namespace teoria5;

class Persona
{
    public string _nombre {get;set;}
    public char _sexo{get;set;}
    public int _dni {get;set;}
    public DateTime _fechaNacimiento {get;set;}
    public int _edad {get;}=22;

    public Persona (string nombre,char sexo,int dni,DateTime fechaNacimiento)
    {
        this._nombre=nombre;
        this._sexo=sexo;
        this._dni=dni;
        this._fechaNacimiento=fechaNacimiento;
    }

    public object? this [int i]
    {
        get
        {
            if (i==0) return this._nombre;
            else if (i==1) return this._sexo;
            else if (i==2) return this._dni;
            else if (i==3) return this._fechaNacimiento;
            else if (i==4) return this._edad;
            else return null; 
        }
        set
        {
            if (i==0) this._nombre=(string)value;
            else if (i==1) this._sexo=(char)value;
            else if (i==2) this._dni=(int)value;
            else if (i==3) this._fechaNacimiento=(DateTime)value;
            else Console.WriteLine("No se modifica");
        }
    }

}
