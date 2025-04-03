/*Implementar el método ImprimirMatrizConFormato, similar al anterior pero ahora con un
parámetro más que representa la plantilla de formato que debe aplicarse a los números al imprimirse.
La plantilla de formato es un string de acuerdo a las convenciones de formato compuesto, por ejemplo
“0.0” implica escribir los valores reales con un dígito para la parte decimal.*/

Console.WriteLine("Ingrese el formato del string");
string st=Console.ReadLine();
double[,] matriz= new double[,]
                             {  {3.1416,2.7182},
                                 {1.6100,0.5722}
                             } ;


ImprimirMatrizConFormato(matriz,st);
void ImprimirMatrizConFormato(double[,] matriz, string formatString)
{
    for (int i = 0;i<matriz.GetLength(0);i++)
    {
        for (int j=0;j<matriz.GetLength(1);j++)
        {
            Console.Write(matriz[i,j].ToString(formatString) + " ");
        }
        Console.WriteLine();
    }
}
