using System.Dynamic;

public class Cuenta
{
    //Propiedades estáticas que se utilizarán en el método ImprimirResumen()
    private static int s_cantCuentas{get;set;}=0;
    private static int s_cantExtracDenegadas{get;set;}=0;
    private static int s_cantDepositos{get;set;}=0;
    private static int s_cantExtracciones{get;set;}=0;
    private static int s_totExtracciones {get;set;} = 0;
    private static int s_totDepositado{get;set;} = 0;
    private static int s_saldoTotal{get;set;} = 0;
    private static List<Cuenta> s_cuentas{get;}= new List<Cuenta>();

    //Propiedades privadas que se utilizarán para cada instancia
    private int _saldo{get;set;}=0;
    private int _id{get;set;}

    public Cuenta()
    {
        s_cantCuentas++;
        this._id=s_cantCuentas;
        Console.WriteLine($"Se creó la cuenta con Id={this._id}");
        s_cuentas.Add(this);
    }

    public Cuenta Depositar(int monto)
    {
        s_cantDepositos++;
        s_totDepositado+=monto;
        s_saldoTotal+=monto;
        this._saldo+=monto;
        Console.WriteLine($"Se depositó {monto} en la cuenta {this._id} (Saldo={this._saldo})");
        return this;
    }

    public Cuenta Extraer(int monto)
    {
        if (this._saldo>=monto)
        {
            this._saldo-=monto;
            s_totExtracciones+=monto;
            s_saldoTotal-=monto;
            s_cantExtracciones++;
            Console.WriteLine($"Se extrajo {monto} de la cuenta {this._id} (Saldo={this._saldo})");
        }
        else
        {
            s_cantExtracDenegadas++;
            Console.WriteLine("Operación denegada - Saldo insuficiente");
        }
        return this;
    }

    public static void ImprimirDetalle()
    {
        Console.WriteLine($"CUENTAS CREADAS: {s_cantCuentas}");
        Console.WriteLine($"DEPÓSITOS: {s_cantDepositos}        -Total Depositado: {s_totDepositado}");
        Console.WriteLine($"EXTRACCIONES: {s_cantExtracciones}     -Total Extraído: {s_totExtracciones}");
        Console.WriteLine($"                    -Saldo: {s_saldoTotal}");
        Console.WriteLine($"* Se denegaron {s_cantExtracDenegadas} extracciones por falta de fondos");
    }

    public static List<Cuenta>? GetCuentas()
    {
        return new List<Cuenta>(s_cuentas);

    }
    
}