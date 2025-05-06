using System;
using Sistema.Aplicacion.Entidades;

namespace Sistema.Aplicacion;

public interface IEsAlquilable
{
    void SeAlquila(Persona p);

    void Devolver (Persona p);
}
