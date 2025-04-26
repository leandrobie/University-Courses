using System;

namespace teoria6;

static class Imprimidor
{
    public static void Imprimir(params Letra[] vector)
    {
        foreach (Letra l in vector)
        {
            l.Imprimir();
        }
    }
}
