using System;

namespace teoria6;

public class C:B
{
    public C(int id): base(id)=>_id=id;

    public override void Imprimir()
    {
        Console.Write($"C_{_id} --> ");
        base.Imprimir();
    }

}
