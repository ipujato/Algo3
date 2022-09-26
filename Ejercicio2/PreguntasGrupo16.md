1. En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código,
por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

El ente que estaba repetido pero no representado como un ente en sí era el de un reloj. El código repetido del test 01 y 02 era poder contar el tiempo tardado entre el
comienzo y fin de algo, que es lo que hace un reloj cualquiera. Puntualmente, se utilizaba el concepto de temporizador, porque se ponía un límite que no se podía 
superar. En cuanto a crearlo no hizo falta porque ya estaba implementado en Smalltalk por lo que rehusamos esos mensajes y listo.


2. ¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para 
representar entidades de la realidad?

Puedo usar clases e instancias. Para representar ideas o conceptos uno crea clases. Las clases son las abstracciones más "generales" de un concepto como por ejemplo un 
auto. Dentro de la idea de auto todos podemos coincidir en que va a tener un volante, 4 ruedas, un motor, etc. En mi idea de auto yo puedo imaginarme un auto sin 
necesariamente entrar en la imagen de un auto específico. Sin embargo, dentro de esta idea de "autocidad" existe un objeto concreto que me hace relacionar con la clase, 
que sería mi auto. Mi auto sería la instancia de esta clase. Dentro de la generalidad del auto, MI AUTO es uno único dentro de la clase porque al identificarlo ya es 
distinto al resto. El mismo lo puedo prender, apagar, y otros mensajes implementados en la clase auto, o crear con especificaciones de la instancia misma. Por ejemplo, 
un auto de dos puertas no deja de ser un auto a pesar de que sea diferente al resto.


3. ¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

Al conocer el pensamiento del modelo uno puede recordar si ya conoce la implementación. Si uno va creando sobre una idea a medida que avance va a reconocer si ya 
implemento cierta lógica como para poder reutilizarla y no generar código repetido. Si uno mira código ya creado por alguien para poder buscar y encontrar el código 
repetido tiene que sentarse a mirar todo lo que escribió y analizarlo lentamente para ver si ve cosas similares mientras trata de entender. En cambio, si uno ya conoce 
sobre lo que se está modelando, puede evitar buscar comparaciones que no tengan sentido. Por ejemplo: si modelamos un partido de fútbol, alguien que conoce el deporte sabe 
que no va a haber lógica similar entre el comportamiento de un DT y un arquero y no va a encontrar ahi código repetido, mientras que si uno no está familiarizado va a 
perder tiempo comparando esas situaciones. De igual manera, si yo implementó el fútbol conociéndolo sé que ambos laterales tendrán carreras iguales pero en lados 
diferentes, haciendo la abstracción de repetición casi automática de detectar.
