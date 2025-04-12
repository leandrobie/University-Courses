using System;

namespace teoria4;

public class Matriz
{
    double[,] _matriz;

    public Matriz(int filas,int columnas)
    {
        this._matriz=new double[filas,columnas];
    }

    public Matriz (double[,] matriz)
    {
        this._matriz=matriz;
    }

    public void SetElemento(int fila, int columna, double elemento)
    {
        this._matriz[fila,columna]=elemento;
    }

    public double GetElemento(int fila,int columna)
    {
        return this._matriz[fila,columna];
    }

    public void Imprimir()
    {
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            for (int j=0;j<this._matriz.GetLength(1);j++)
            {
                Console.Write(this._matriz[i,j] + " ");
            }
            Console.WriteLine();
        }
    }

    public void Imprimir(string formatString)
    {
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            for (int j=0;j<this._matriz.GetLength(1);j++)
            {
                Console.Write(this._matriz[i,j].ToString(formatString) + " ");
            }
            Console.WriteLine();
        }
    }

    public double[] GetFila(int fila)
    {
        double[] aux=new double[this._matriz.GetLength(0)];
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            aux[i]=this._matriz[fila,i];
        }
        return aux;
    }

    public double[] GetColumna(int columna)
    {
        double[] aux= new double[this._matriz.GetLength(1)];
        for (int i=0;i<this._matriz.GetLength(1);i++)
        {
            aux[i]=this._matriz[i,columna];
        }
        return aux;
    }

    public double[] GetDiagonalPrincipal()
    {
        double[] aux=new double[this._matriz.GetLength(0)];
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            aux[i]=this._matriz[i,i%this._matriz.GetLength(0)]; 
        }

        return aux;

    }

    public double[] GetDiagonalSecundaria()
    {
        double[] aux=new double[this._matriz.GetLength(0)];
        for (int i=0;i<this._matriz.GetLength(0)-1;i++)
        {
            aux[i]=this._matriz[i,i+1%this._matriz.GetLength(0)];
        }
        return aux;
    }

    public double[][] GetArregloDeArreglo()
    {
        double[][] aux= new double [this._matriz.GetLength(0)][];
        // Cada sub arreglo
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            aux[i]= new double [this._matriz.GetLength(1)];
        }
        // Carga de datos 
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            for (int j=0;j<this._matriz.GetLength(1);j++)
            {
                aux[i][j]=this._matriz[i,j];
            }
        }
        return aux;
    }

    public void Sumarle(Matriz m)
    {
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            for (int j=0;j<this._matriz.GetLength(1);j++)
            {
                this._matriz[i,j]+=m.GetElemento(i,j);
            }
        }
    }

    public void Restarle(Matriz m)
    {
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            for (int j=0;j<this._matriz.GetLength(1);j++)
            {
                this._matriz[i,j]= this._matriz[i,j] - m.GetElemento(i,j);
            }
        }
    }

    public void Multiplicar(Matriz m)
    {
        for (int i=0;i<this._matriz.GetLength(0);i++)
        {
            for (int j=0;j<this._matriz.GetLength(1);j++)
            {
                this._matriz[i,j]= this._matriz[i,j] * m.GetElemento(i,j);
            }
        }
    }



}
