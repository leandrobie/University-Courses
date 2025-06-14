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
}
