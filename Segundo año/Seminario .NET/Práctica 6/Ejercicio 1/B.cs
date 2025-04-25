using System;

namespace teoria6;

public class B : A
{
public B (int id): base(id)=>_id=id;
    public override void Imprimir()
    {
        Console.Write($"B_{_id} --> ");
        base.Imprimir();
    } 
}
