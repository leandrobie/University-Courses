using System;

namespace Figuras;

public class Rectangulo
{
    double _base,_altura;

    public Rectangulo(double unaBase, double altura)
    {
        _base = unaBase;
        _altura = altura;
    }

    public double GetArea()
    {
        return _base*_altura;
    } 
}
