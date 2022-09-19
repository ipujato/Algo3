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

3. 
