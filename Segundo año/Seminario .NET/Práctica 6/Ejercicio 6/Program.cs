/* Señalar el error en cada uno de los siguientes casos:

1) class A
   {
    public string M1() => "A.M1";
    }
    class B : A
    {
    public override string M1() => "B.M1";
    }

    RTA: El método de la clase A debe ser marcado con la palabra clave 'virtual' para que pueda ser 
    invalidado por otro método.

2) class A
    {
    public abstract string M1();
    }
    class B : A
    {
    public override string M1() => "B.M1";
    }

    RTA: No puede declararse un método abstracto en la clase A ya que la misma no es una clase abstracta.

3)  abstract class A
    {
    public abstract string M1() => "A.M1";
    }
    class B : A
    {
    public override string M1() => "B.M1";
    }

    RTA: Cuando se declara un método abstracto, el mismo debe implementarse desde las sub-clases, no desde la clase abstracta.

4) class A
    {
    public override string M1() => "A.M1";
    }
    class B : A
    {
    public override string M1() => "B.M1";
    }

    RTA:El error está en la clase A, ya que se quiere invalidar un método que no está heredando de ninguna clase, sino que 
    es propia de la misma.

5) class A
    {
    public virtual string M1() => "A.M1";
    }
    class B : A
    {
    protected override string M1() => "B.M1";
    }

    RTA:El error está en la clase B. Se quiere proteger un método invalidado que se deriva de la clase A, marcado 
    como public. Al marcarlo como protected reduce la visibilidad del método de la clase A, cuando debería coincidir 
    con la misma. (Es decir, si el método de A está declarado como public, entonces el método de la clase B también debería estarlo)

6) class A
    {
    public static virtual string M1() => "A.M1";
    }
    class B : A
    {
    public static override string M1() => "B.M1";
    }

    RTA: No puede invalidarse un método estático porque que es propio de la clase (A en este caso), incluso si tiene clases derivadas. 
    Además, los miembros estáticos se determinan en tiempo de compilación, mientras que los métodos override y virtual en tiempo de ejecución. 
    Por lo tanto cuando se quiera llamar a un método estático, el compilador no va a saber si llamar al invalidado o al estático de la clase A, 
    por lo que lanzará error.

7) class A
    {
    virtual string M1() => "A.M1";
    }
    class B : A
    {
    override string M1() => "B.M1";
    }

    RTA: Los métodos virtual y override deben declararse como public, ya que por defecto se declaran como private y no van a poder ser accedidos desde la clase B.

8)  class A
    {
    protected A(int i) { }
    }
    class B : A
    {
    B() { }
    }

    RTA: El error está en la clase B ya que se quiere llamar a un constructor sin parámetros de A. Esto no es posible debido a que
    en la clase A se declaró un constructor con un parámetro, por lo tanto el constructor por defecto (es decir, sin parámetros)
    ya no está implícito.

9)  class A
    {
    private int _id;
    protected A(int i) => _id = i;
    }
    class B : A
    {
        B(int i):base(5) {
        _id = i;
        }
    }

    RTA: El problema está en la clase B, donde se quiere acceder al campo privado _id perteneciente a la clase A.
    Esto es inválido ya que el campo privado de una clase, solamente puede ser accedido desde la misma, independientemente
    de que tenga clases derivadas.

10) class A
    {
    private int Propiedad { set; public get; }
    }
    class B : A
    {
    }

    RTA: La propiedad 'Propiedad' de la clase A tiene el setter privado, por lo tanto no puede ser accedido desde
    la clase B. 

11) abstract class A
    {
    public abstract int Prop {set; get;}
    }
    class B : A
    {
        public override int Prop
        {
        get => 5;
        }
    }

    RTA: El error está en la clase B porque se hace una implementación del get pero no del set.

12) abstract class A
    {
    public int Prop {set; get;}
    }
    class B : A
    {
        public override int Prop {
        get => 5;
        set {}
        }
    }

    RTA: No se puede hacer un método override en la clase B porque en la clase A el método no está marcado como virtual.
*/

