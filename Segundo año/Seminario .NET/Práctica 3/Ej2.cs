/*Implementar un método para imprimir por consola todos los elementos de una matriz (arreglo de dos
dimensiones) pasada como parámetro. Debe imprimir todos los elementos de una fila en la misma línea
en la consola.*/

/*creación y carga de la matriz*/
int [,] mat= new int[3,3];
for (int i=0;i<=8;i++)
{
    mat[i/3,i%3] = i;
}

ImprimirMatriz(mat);

void ImprimirMatriz(int[,] matriz)
{
    for (int i=0;i<matriz.GetLength(0);i++)
    {
        for (int j=0;j<matriz.GetLength(1);j++)
        {
            Console.Write(matriz[i,j] + " ");
        }
        Console.WriteLine();
    }
}
