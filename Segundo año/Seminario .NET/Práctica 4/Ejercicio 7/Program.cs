/*Ejercicio 7: Implementar la clase Matriz que se utilizará para trabajar con matrices matemáticas. Implementar los dos
constructores y todos los métodos que se detallan a continuación:
public Matriz(int filas, int columnas)
public Matriz(double[,] matriz)
public void SetElemento(int fila, int columna, double elemento)
public double GetElemento(int fila, int columna)
public void imprimir()
public void imprimir(string formatString)
public double[] GetFila(int fila)
public double[] GetColumna(int columna)
public double[] GetDiagonalPrincipal()
public double[] GetDiagonalSecundaria()
public double[][] getArregloDeArreglo()
public void sumarle(Matriz m)
public void restarle(Matriz m)
public void multiplicarPor(Matriz m)*/
using teoria4;

double[,] matriz= new double[,]
                             { {2.3,5.2,1.5},
                                {5.1,7.9,1.8},
                                {9.5,2.1,7.3}                        
                             } ;
Matriz miMatriz= new Matriz(matriz);
miMatriz.Imprimir();
Console.WriteLine();

miMatriz.Imprimir("0.00");
Console.WriteLine();

double[] vecFila=miMatriz.GetFila(0);
for (int i=0;i<vecFila.Length;i++)
{
    Console.Write(vecFila[i] + " ");
}
Console.WriteLine();

double [] vecColum= miMatriz.GetColumna(0);
for (int i=0;i<vecColum.Length;i++)
{
    Console.WriteLine(vecColum[i]);
}

double[] vecDiagPrinc=miMatriz.GetDiagonalPrincipal();
for (int i=0;i<vecDiagPrinc.Length;i++)
{
    Console.Write(vecDiagPrinc[i] + " ");
    
}
Console.WriteLine();

double [] vecDiagSec=miMatriz.GetDiagonalSecundaria();
for (int i=0;i<vecDiagSec.Length;i++)
{
    Console.Write(vecDiagSec[i] + " ");
}
Console.WriteLine();

double[][] vecDeVec=miMatriz.GetArregloDeArreglo();
for (int i=0;i<vecDeVec.GetLength(0);i++)
{
    for (int j=0;j<vecDeVec.GetLength(0);j++)
    {
        Console.Write(vecDeVec[i][j] + " ");
    }
    Console.WriteLine();
}

Matriz miOtraMatriz=new Matriz(matriz);
miMatriz.Sumarle(miOtraMatriz);
miMatriz.Imprimir();
miMatriz.Restarle(miOtraMatriz);
miMatriz.Imprimir();
miMatriz.Multiplicar(miOtraMatriz);
miMatriz.Imprimir();


