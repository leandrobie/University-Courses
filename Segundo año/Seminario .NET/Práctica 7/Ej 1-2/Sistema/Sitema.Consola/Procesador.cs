using System;
using Sistema.Aplicacion.Entidades;

namespace Sistema.Aplicacion;

static class Procesador
{
    public static void Alquilar (IEsAlquilable x,Persona p) => x.SeAlquila (p);
    public static void Atender (IEsAtendible x) => x.Atiende();
    public static void Devolver (IEsAlquilable x,Persona p)=> x.Devolver(p);
    public static void Lavar (IEsLavable x)=> x.Lavar();
    public static void Reciclar (IEsReciclable x) => x.Reciclar();
    public static void Secar (IEsLavable x) => x.Secar();
    public static void Vender (IEsVendible x,Persona p) => x.Vender(p);
}
