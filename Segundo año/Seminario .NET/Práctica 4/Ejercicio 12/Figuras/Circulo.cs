namespace Figuras;

public class Circulo
{
    double _radio;
    public Circulo(double radio)
    {
        _radio = radio;
    }

    public double GetArea()
    {
        return Math.PI * Math.Pow(_radio, 2);
    }

}
