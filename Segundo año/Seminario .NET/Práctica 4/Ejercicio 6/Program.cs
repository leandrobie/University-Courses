/*Codificar una clase llamada Ecuacion2 para representar una ecuación de 2o grado. Esta clase debe tener 3
campos privados, los coeficientes a, b y c de tipo double. La única forma de establecer los valores de estos
campos será en el momento de la instanciación de un objeto Ecuacion2.
Codificar los siguientes métodos:
● GetDiscriminante(): devuelve el valor del discriminante (double), el discriminante tiene la
siguiente formula, (b^2)-4*a*c.
● GetCantidadDeRaices(): devuelve 0, 1 ó 2 dependiendo de la cantidad de raíces reales que posee la
ecuación. Si el discriminante es negativo no tiene raíces reales, si el discriminante es cero tiene una
única raíz, si el discriminante es mayor que cero posee 2 raíces reales.
● ImprimirRaices(): imprime la única o las 2 posibles raíces reales de la ecuación. En caso de no
poseer soluciones reales debe imprimir una leyenda que así lo especifique.*/

using teoria4;

Ecuacion2 unaEcuacion2= new Ecuacion2(1,2,5); //Caso donde no posee raíces reales
unaEcuacion2.ImprimirRaices();

Ecuacion2 otraEcuacion2= new Ecuacion2(1,-4,4); //Caso donde posee 1 raíz real
otraEcuacion2.ImprimirRaices();

Ecuacion2 ultEcuacion2= new Ecuacion2(2,-5,2); //Caso donde posee 2 raíces reales
ultEcuacion2.ImprimirRaices();