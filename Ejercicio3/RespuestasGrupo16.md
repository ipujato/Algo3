Preguntas teóricas

### Aporte de los mensajes de DD
En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

Cada uno de los llamados aporta el contexto de quien lo recibe. En el primero se sabe quien recibe el mensaje y al hacer el segundo se sabe quién era el parámetro del primer llamado. Al conocer el origen y el destino de mi mensaje, puedo crear un método que refleje el comportamiento deseado. 


### Lógica de instanciado
Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

Que sea un mensaje de instanciación de cada subclase. Osea que tanto Enteros como Fraccion tengan su propia instanciación con new. Sin embargo, en casos como los tipos de enteros para fibonacci no tiene sentido tener una instanciación diferente a Enteros, por lo que ahí es útil reutilizar la instanciación de la superclase. De este modo la respuesta sería depende a qué tanta diferencia haya entre clase y subclase. 
En cuanto a la creación de diferentes lugares habría que ver primero porque una misma clase tiene diferentes instanciones y si son muy marcadas crear subclases con instanciaciones propias. Por ejemplo dentro de Numeros, Fraccion y Enteros se crean individualmente, mientras que Cero, Negativos, Uno y Positivos al ser iguales excepto por un mensaje, no divergen de la instanciación de su superclase, Enteros. 
Si un objeto se crea de muchas formas diferentes tal vez no sea un objeto único, sino que una generalización de muchos otros. 


### Nombres de las categorías de métodos
Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

Como criterio, empezamos viendo los criterios que trae la superclase y respetandolos, por ejemplo si existe suma dentro de arithmetic en la superclase con un self subclassResponsability, tendria sentido que en la subclass ese formato se respete. Por otro lado, estamos agrupando los metodos también por su funcionamiento y naturaleza dentro de la clase. Por ejemplo, en Enteros tiene sentido que los cuatro mensajes que le instruyen que hacer frente a una operación con Fraccion sean una sola categoría llamada arithmetic with fraccion. A su vez, al compartir naturaleza con arithmetic pero yendo a una categorización extra, también tiene sentido que compartan esa parte del nombre. 


### Subclass Responsibility
Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Ponemos ese mensaje para que si en un futuro creamos una nueva subclase el debugger nos frene y nos diga "tenés que implementar este método si o si". Esto es útil cuando hay algo que la subclase si o si tiene que poder hacer para que el modelo funcione y no nos olvidemos a la hora de crearlo, implementar ese método. 


### No rompas
¿Por qué está mal/qué problemas trae romper encapsulamiento?

Anula la repartición de responsabilidades y no colabora a que el conjunto de mensajes sea minimal. Si yo necesito el área de un cuadrado tiene muchísimo más sentido que la responsabilidad del cálculo del área caiga en el rectángulo a que yo le tenga que pedir los lados y lo calcule en otro mensaje. A su vez, si le quito toda responsabilidad al cuadrado, no tendría sentido tenerlo como objeto independiente y haría que mi objeto original abarque tantas cosas que pierda su unicidad dentro de lo que representa. A su vez, si yo no respeto el encapsulamiento por cada cosa que quiera saber de un objeto tercero debo crear mensajes que le corresponden al otro y agrandan mi conjunto, lo cual no es una buena heurística. 

