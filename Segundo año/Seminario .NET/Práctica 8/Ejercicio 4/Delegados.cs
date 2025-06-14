using System;

namespace Sitema.Consola;

public static class Delegados
{
    public delegate void Del1(int num);
    public delegate void Del2(int[] vecInt);
    public delegate int Del3(int num);
    public delegate bool Del4(string st);
}
