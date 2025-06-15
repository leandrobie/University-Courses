List<object> lista = [ "hola", 7, 'A' ];
string st = Get<string>(lista, 0);
int i = Get<int>(lista, 1);
char c = Get<char>(lista, 2);
Console.WriteLine($"{st} {i} {c}");

T Get <T> (List<object> a, int b)
{
   return (T) a[b];
}
 