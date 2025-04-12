using System;

namespace teoria4;

public class Ecuacion2
{
    double _a,_b,_c;

    public Ecuacion2(double a, double b, double c)
    {
        this._a=a;
        this._b=b;
        this._c=c;
    }

    public double GetDiscriminante()=> Math.Pow(this._b,2) - 4*this._a*this._c;

    public int GetCantidadDeRaices()=> this.GetDiscriminante() switch {< 0 => 0, > 0 => 2, _ => 1};

    public void ImprimirRaices()
    {
        switch(this.GetCantidadDeRaices())
        {
            case 1:
                Console.WriteLine ("La raíz del discriminante es " + Math.Sqrt(this.GetDiscriminante()));
                break;
            case 2:
                Console.WriteLine($"Las dos posibles raíces son {(-this._b+ Math.Sqrt(this.GetDiscriminante()))/(2*this._a)} y {(-this._b-Math.Sqrt(this.GetDiscriminante()))/(2*this._a)} " );
                break;
            default:
                Console.WriteLine("No posee raíces reales");
                break;
        }
    }
}
