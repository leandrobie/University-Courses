/*Implementar un programa que permita al usuario ingresar números por la consola. Debe ingresarse
un número por línea finalizado el proceso cuando el usuario ingresa una línea vacía. A medida que se
van ingresando los valores el sistema debe mostrar por la consola la suma acumulada de los mismos.
Utilizar double.Parse() y try/catch para validar que la entrada ingresada sea un número válido,
en caso contrario advertir con un mensaje al usuario y proseguir con el ingreso de datos.*/

double suma=0;
Console.WriteLine("Ingrese un número o un espacio en blanco para finalizar");
string st=Console.ReadLine();
double num;
while (st!=" ")
{
    try
    {
        num=double.Parse(st);
        suma+=num;
    }
    catch
    {
        Console.WriteLine("Valor inválido");
    }
    finally
    {
        Console.WriteLine("Ingrese otro número o un espacio en blanco para finalizar");
        st=Console.ReadLine();
    }
}
Console.WriteLine("La suma de los numeros ingresados es de " + suma);
