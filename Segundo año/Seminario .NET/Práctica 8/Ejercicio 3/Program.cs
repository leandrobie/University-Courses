using System.Collections;
IEnumerable Rango(int pri, int ult, int paso)
{
    for (; pri <= ult; pri += paso)
        yield return pri;
}

IEnumerable Potencias(int num, int potencia)
{
    for (int i = 1; i <= potencia; i++)
        yield return Math.Pow(num, i);
}

IEnumerable DivisiblesPor(IEnumerable rango, int divisible)
{
    foreach (int i in rango)
    {
        if (i % divisible == 0) yield return i;
    }
}

IEnumerable rango = Rango(6, 30, 3);
IEnumerable potencias = Potencias(2, 10);
IEnumerable divisibles = DivisiblesPor(rango, 6);

foreach (int i in rango)
{
    Console.Write(i + " ");
}

Console.WriteLine();
foreach (double i in potencias)
{
    Console.Write(i + " ");
}
Console.WriteLine();
foreach (int i in divisibles)
{
Console.Write(i + " ");
}
Console.WriteLine();
