using System;
using Sistema.Aplicacion.Interfaces;

namespace Sistema.Aplicacion.Entidades;

public class ComparadorLongitudNombre : System.Collections.IComparer
{
    public int Compare(object? x, object? y)
    {
        int result = 1;
        if (x is INombrable nom1 && y is INombrable nom2)
        {
            int longitud1 = nom1.Nombre.Length;
            int longitud2 = nom2.Nombre.Length;
            result = longitud1.CompareTo(longitud2);
        }
        return result;

    }
}
