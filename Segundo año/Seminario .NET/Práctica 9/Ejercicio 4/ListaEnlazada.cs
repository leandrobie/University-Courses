

using System.Collections;

namespace teoria9;

public class ListaEnlazada<T> : IEnumerable<T>
{
    private Nodo<T>? pri;
    private Nodo<T>? ult;

    public void AgregarAdelante(T valor)
    {
        Nodo<T> nodo = new Nodo<T>(valor);
        if (pri == null) pri = ult = nodo;
        else
        {
            nodo.Proximo = pri;
            pri = nodo;
        }
    }

    public void AgregarAtras(T valor)
    {
        Nodo<T> nodo = new Nodo<T>(valor);
        if (ult == null) pri = ult = nodo;
        else
        {
            ult.Proximo = nodo;
            ult = nodo;
        }
    }

    public IEnumerator<T> GetEnumerator()
    {
        Nodo<T>? act = pri;
        while (act != null)
        {
            yield return act.Valor;
            act = act.Proximo;
        }
        yield break;
        
    }

    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

}
