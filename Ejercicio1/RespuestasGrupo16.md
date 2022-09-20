ACLARACION SAGA II: AL CORRER LAS PRUEBAS COMBATIENTES TEST TODAS JUNTAS FALLAN PERO AL CORRERLAS INDIVIDUALMENTE PASAN. LO MIRAMOS CON SERGIO Y NO SUPIMOS ENCONTRAR EL PROBLEMA. 

Preguntas

1. ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)

2. ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)

3. ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?

Respuestas
1. Es el mismo mensaje pero cambiando la interpretacion del resultado. Podria facilmente implementarse la solucion en un solo mensaje que reciba un segundo parametro 
diciendo si se busca igualdad (a 20 -> no esta herido) o no se busca igualdad. Es practicamente utilidad reptida en codigo diferente y no colabora a hacer un conjunto 
minimal de mensajes. A su vez hace que el dominio con la realidad sean 2 mensajes para un solo concepto de la realidad.

2. Es un mal necesario, porque de la forma en que funcionan nuestros personajes todos deben ser testeados. Si bien los tres atacar son iguales cada uno tiene el propio
y no escapan de la posibilidad de un error de tipeo. Si fuesen hijos de un subconjunto con un solo testeo alcanzaria pero no es el caso de nuestra implementacion. Como 
los tres tienen un metodo propio, debemos testear los trres aunque sea lo mismo tres veces.

3. Para modelar el resultado consideramos las tres variables que participan en determinar el mismo. Estas son: rondas jugadas, sobrevivientes del bando 1 y sobrevivientes del bando 2. Para poder analizar este resultado y pasar las preubas armamos tres mensajes que recibia el objeto. Estos son:
  1. ganadorIndefinido: unaCantidadDeRondas
      Para poder analizar este caso hay que considerar la necesidad de que en ambos bandos quede al menos un miembro de pie y las rondas corridas coinicdan con                 unaCantidadDeRondas.
  2. ganadorBando1: unaCantidadDeRondas
      Para este caso es necesario que el bando 1 tenga al menos un sobreviviente y que el bando 2 no tenga. Ademas, las rondas corridas deben coincidir con las esperadas
      pasadas en unaCantidadDeRondas.
  3. ganadorBando2: unaCantidadDeRondas
      Para este caso es necesario que el bando 2 tenga al menos un sobreviviente y que el bando 1 no tenga. Ademas, las rondas corridas deben coincidir con las esperadas
      pasadas en unaCantidadDeRondas.
      
Para poder analizar estas 3 cuestiones creamos dos mensajes. El primer mensaje es:
      hizoCantidadDeRondas: unNumeroDeRondaEsperado  
  Este mensaje analiza que la cantidad de rondas corridas sea igual a las esperadas y devuevle true en caso de coincidir. Para contar las rondas creamos un colaborador   interno rondasCorridas que comienza en cero y aumenta en uno al finalizar cada ronda.
El segundo mensaje es:
      sobrevivientesBandoElegido: unBando resultadoEsperado: unBooleano
   Este mensaje busca en unBando a los miembros que tengan mas puntos de vida que 0 y los guarda en un conjunto llamado combatientesDePie. Devuelve la condicion de que 
   combatientesDePie == unBooleano. Al añadir unBooleano se puede reutilizar el mensaje para buscar al menos uno vivo (unBooleano = false) o que esten todos muertos 
   (unBooleano = true). De este modo se pueden comparar ambos escenarios (bando1 vivo y bando1 muerto) usando el mismo mensaje pero cambiando el valor de unBooleano.
Los dos mensajes mencionados devuelven un booleano por lo que en total quedan tres booleanos, haciendo correcto uso de sobrevivientesBandoElegido y hizoCantidadDeRondas se pueden obtener las condiciones buscadas y si son cumplidas o no. Para el resultado final de ganadorBando1 ganadorBando2 o ganadorIndefinido se busca que los 3 resultados devuelvan true.
