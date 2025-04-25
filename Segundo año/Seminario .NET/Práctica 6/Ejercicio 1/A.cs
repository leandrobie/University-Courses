using System;

namespace teoria6;

public class A
{
    protected int _id;
    public A(int id) => _id = id;
    public virtual void Imprimir() => Console.WriteLine($"A_{_id}");
}
