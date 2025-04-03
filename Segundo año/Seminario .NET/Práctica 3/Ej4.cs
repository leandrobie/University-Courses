/*Implementar los métodos GetDiagonalPrincipal y GetDiagonalSecundaria que devuelven
un vector con la diagonal correspondiente de la matriz pasada como parámetro. Si la matriz no es
cuadrada generar una excepción ArgumentException.*/

double[,] matriz= new double[,]
                            {{2.3,5.3,7.9,8.2},
                              {5.1,1.6,6.1,9.8},
                              {7.1,1.9,2.2,8.7},
                              {1.8,2.3,9.1,2.4}  };

GetDiagonalPrincipal(matriz);
GetDiagonalSecundaria(matriz);
double[] GetDiagonalPrincipal(double[,] matriz)
{
    if (matriz.GetLength(0) != (matriz.GetLength(1))) //Verifico si la matriz es cuadrada
    {
        throw new ArgumentException("matriz");
    }
    else
    {
        double[] aux= new double[matriz.GetLength(0)]; //Declaro un vector de longitud de columnas o filas
        for (int i=0;i<matriz.GetLength(0);i++)
        {
            aux[i]= matriz[i,i%matriz.GetLength(0)];
        }
        return aux;
    }
}

double[] GetDiagonalSecundaria(double[,] matriz) //Ídem anterior, solo que se modifica el recorrido de la matriz
{
    if (matriz.GetLength(0) != matriz.GetLength(1))
    {
        throw new ArgumentException("matriz");
    } 
    else
    {
         double[] aux=new double[matriz.GetLength(0)]; 
         for (int i=0;i<matriz.GetLength(0)-1;i++)
         {
            aux[i]= matriz[i,i+1%matriz.GetLength(0)];
         }
           return aux;
    }
  
       
}

