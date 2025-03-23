int n= 35;
int x= 51;
Console.WriteLine($"Se ingresó el valor n={n} y x={x}");
Swap(ref n,ref x);
Console.WriteLine($"Se ingresó el valor n={n} y x={x}");


void Swap(ref int n,ref int x)
{
    int aux=n;
    n=x;
    x=aux;
}
