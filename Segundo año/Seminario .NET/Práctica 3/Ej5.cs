/*Implementar un método que devuelva un arreglo de arreglos con los mismos elementos que la matriz
pasada como parámetro.*/

double[,] matriz= new double[,]
                            {{2.61,6.1,9.5} ,
                              {7.1,9.2,7.1}
                            };

GetArregloDeArreglo(matriz);
double [][] GetArregloDeArreglo(double [,] matriz)
{
    double[][] aux= new double[matriz.GetLength(0)][]; //Arreglo principal
    for (int i=0;i<matriz.GetLength(0);i++)
    {
        aux[i]= new double[matriz.GetLength(1)]; //Cada sub-arreglo
    }
    //Carga de datos
    for (int i=0;i<matriz.GetLength(0);i++)
    {
        for (int j=0;j<matriz.GetLength(1);j++)
        {
            aux[i][j]=matriz[i,j]; 
            Console.Write(aux[i][j] + " ");
        }
        Console.WriteLine();
    }
    return aux;
}