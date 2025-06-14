using Sitema.Consola;

Delegados.Del1 d1 = delegate (int x) { Console.WriteLine(x); };
d1(10);
Delegados.Del2 d2 = x => Console.WriteLine(x.Length);
d2(new int[] { 2, 4, 6, 8 });
Delegados.Del3 d3 = x =>
{
int sum = 0;
for (int i = 1; i <= x; i++)
{
sum += i;
}
return sum;
};
int resultado = d3(10);
Console.WriteLine(resultado);
Delegados.Del4 d4 = LongitudPar;
Console.WriteLine(d4("hola mundo"));
bool LongitudPar(string st)
{
return st.Length % 2 == 0;
}