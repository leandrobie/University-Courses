using System;

namespace Sitema.Consola;

public static class VectorDeEnterosExtension
{
    public static void Print(this int[] vector, string leyenda)
    {
        Console.WriteLine(leyenda + string.Join(", ", vector));
    }
    public static int[] Seleccionar(this int[] vector, FuncionEntera f)
    {
        int[] result = new int[vector.Length];
        for (int i = 0; i < vector.Length; i++)
        {
            result[i] = f(vector[i]);
        }
        return result;
    }

    public static int[] Donde(this int[] vector, Predicado n)
    {
        List<int> result = new List<int>();
        for (int i = 0; i < vector.Length; i++)
        {
            if (n(vector[i])) result.Add(vector[i]);
        }
        return result.ToArray();
    }
}
