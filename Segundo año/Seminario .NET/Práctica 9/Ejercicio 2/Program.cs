int[] vector1 = [1, 2, 3];
bool[] vector2 = [true, true, true];
string[] vector3 = ["uno", "dos", "tres"];
Set<int>(vector1, 110, 2);
Set<bool>(vector2, false, 1);
Set<string>(vector3, "Hola Mundo!", 0);
Imprimir(vector1);
Imprimir(vector2);
Imprimir(vector3);

void Set<T> (T[] vec,T elem, int pos)
{
   vec[pos] = elem;
}

void Imprimir<T>(T[] vec)
{
   for (int i = 0; i < vec.Length; i++)
      Console.Write($"{vec[i]} ");
   Console.WriteLine();
}
 