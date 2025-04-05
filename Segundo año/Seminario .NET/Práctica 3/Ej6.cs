

double[,] matriz1= new double[,]
                              { {3.89,1.23,9.2,10.2} ,
                                 {5.6,1.9,0.8,12.4} ,
                                 {9.1,2.5,8.1,1.8}} ;
double[,] matriz2= new double [,]
                               {{1.23,2.12,7.2},
                                 {2.1,6.12,8.1},
                                 {7.1,2.8,9.2} };

Suma(matriz1,matriz2);
Resta(matriz1,matriz2);
Multiplicacion(matriz2,matriz1);

//Método Suma
double[,]? Suma(double[,] A, double[,] B)
{
    if ((A.GetLength(0) == B.GetLength(0)) && (A.GetLength(1) == B.GetLength(1))) //Verifico si las matrices son iguales
    {
        double[,]? aux= new double[A.GetLength(0),A.GetLength(1)]; //Creación de la matriz aux que voy a devolver
        //Carga de la matriz
        for (int i=0;i<aux.GetLength(0);i++)
        {
            for (int j=0;j<aux.GetLength(1);j++)
            {
                aux[i,j]= A[i,j] + B[i,j];
            }
            Console.WriteLine();
        }
        return aux;
    }
    else
        return null;
}

//Método Resta
double[,]? Resta(double[,] A, double[,] B)
{
    if ((A.GetLength(0) == B.GetLength(0)) && (A.GetLength(1) == B.GetLength(1)))
    {
        double[,] aux= new double[A.GetLength(0),A.GetLength(1)]; //Creación matriz a retornar
        for (int i=0;i<aux.GetLength(0);i++)
        {
            for (int j=0;j<aux.GetLength(1);j++)
            {
                aux[i,j]= A[i,j] - B[i,j];
            }
            Console.WriteLine();
        }
        return aux;
    }
    else
    {
        return null;
    }
}

//Método Multiplicación
double[,] Multiplicacion(double[,] A, double[,] B)
{
    if (A.GetLength(1) == B.GetLength(0))
    {
        double[,] aux= new double[B.GetLength(0),A.GetLength(1)];
        for (int i=0;i<B.GetLength(0); i++)
        {
            for (int j=0;j<A.GetLength(1);j++)
            {
                aux[i,j]= A[i,j] * B[i,j];
                Console.Write(aux[i,j] + " ");
            }
            Console.WriteLine();
        }
        
        return aux;
    }
    else
        throw new ArgumentException("La cantidad de columnas de A es distinta a las cantidad de filas de B");
}