using System;

namespace teoria4;

public class Persona
{
    string _nombre;
    int _dni,_edad;

    public Persona(string nombre,int edad,int dni)
    {
        this._nombre=nombre;
        this._dni=dni;
        this._edad=edad;
    }

    public string Imprimir()=> $"{this._nombre} {this._edad} {this._dni}";
  
    public bool EsMayorQue(Persona p)=> this._edad>p._edad;

}
