/*Utilizar la clase Stack<T> (pila) para implementar un programa
que pase un número en base 10 a otra base realizando divisiones
sucesivas. Por ejemplo para pasar 35 en base 10 a binario dividimos
sucesivamente por dos hasta encontrar un cociente menor que el
divisor, luego el resultado se obtiene leyendo de abajo hacia arriba el
cociente de la última división seguida por todos los restos.*/

Console.WriteLine("Ingrese un número");
int num= int.Parse(Console.ReadLine());
Stack<int> pila = new Stack<int>();
while (num > 0)
{
    pila.Push(num%2);
    num=num/2;
}
    int binario=0;
    while (pila.Count > 0)
    {
        binario=pila.Pop()+binario*10;
    }
    Console.WriteLine(binario);


