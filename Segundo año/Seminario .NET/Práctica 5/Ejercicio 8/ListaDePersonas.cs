using System;

namespace teoria5;

public class ListaDePersonas
{
    private List<Persona> cantPer{get;}=new List<Persona>(); 
    public void Agregar (Persona p)
    {
        if (p!=null) cantPer.Add(p);
    }

    public Persona? this [int dni]
    {
        get
        {
            
            Persona? aux=null;
            for (int i=0;i<cantPer.Count;i++)
            {
                if (cantPer[i]._dni==dni) 
                {
                    aux=cantPer[i];
                    break;
                }
            }
            return aux;
        }
    }

    public List<string> this [char car]
    {
        get
        {
            List<string> listaNom= new List<string>();
            for (int i=0;i<cantPer.Count;i++)
            {
                if (cantPer[i]._nombre[0]==car) listaNom.Add(cantPer[i]._nombre);
            }
            return listaNom;
        }
    }
}

