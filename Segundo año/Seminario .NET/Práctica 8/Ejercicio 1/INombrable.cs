using System;

namespace Sistema.Aplicacion.Interfaces;

public interface INombrable : IComparable
{  
    public String Nombre { get; set; }
}
