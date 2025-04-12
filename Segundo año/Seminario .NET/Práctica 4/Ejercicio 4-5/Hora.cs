using System;


namespace teoria4;

public class Hora
{
    int _hora;
    double _minutos;
    double _segundos;

    public Hora(int hora,double minutos,double segundos)
    {
        this._hora = hora;
        this._minutos = minutos;
        this._segundos = segundos;
    }

    public Hora(double hora)
    {
        this._hora=(int)hora;
        double parteDecimal=hora-this._hora;
        this._minutos=Math.Round(parteDecimal*60);
        this._segundos=((parteDecimal*60)-this._minutos)*60; 

    }

    public string Imprimir()=> $"{this._hora} horas, {this._minutos} minutos y {this._segundos:f3} segundos";
}
