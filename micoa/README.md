# Micoa

En un futuro distópico los recursos escasean por doquier. Por suerte siguen existiendo los juegos para que la gente logre distraerse y los robots para cumplir sus tareas. Con esto en mente,  MicroRobots y Sacoa, una empresa dedicada a la creación de robots y la otra al entretenimiento,  deciden aunar esfuerzos y crear “Micoa”. Micoa creará tanto robots como atracciones para parques de diversiones.  Los androides son quienes probarán los juegos, y viceversa. 🤯

Los robots que probarán el parque de diversiones tendrán una pantalla que indicará su nombre, su nivel de náuseas y la cantidad de tickets que llevan acumulados.
Dentro de Micoa los robots probarán los siguientes juegos:
zamba: Se configura la velocidad en vueltas por segundo. Aumenta el nivel de náuseas en 5 unidades por cada vuelta por segundo. No entrega tickets por subirse.
pumpIt: todos los robots son muy buenos bailando, por lo que obtendrán 10 tickets cada vez que jueguen. A su vez, agrega el prefijo “bailarín” al nombre del robot.
daytono: se puede elegir el nivel de dificultad. El nivel 1 siempre entrega 20 tickets. El nivel 2 entrega 30 tickets si el nombre del robot tiene menos de 3 letras, de lo contrario no entrega tickets. El nivel 3 es imposible ya que tiene demasiadas curvas, por ende solo genera un aumento del nivel de náuseas en 15 unidades.
carreraDeCaballos: este juego siempre fue un robo, por lo que resta 30 tickets al que lo juegue, dejando como mínimo 0 (los tickets nunca pueden ser negativos).

Parte A
Modelar los robots.
Modelar los juegos que conocemos.
Modelar los siguientes robots:
Wall-E: viene de un viaje largo por lo que su nivel de náuseas es 60, y no tiene tickets.
Arturito: Viene con 10 unidades de náuseas y Luke Skywalker le regaló 35 tickets que le sobraban.

Parte B
Hasta ahora, ayudamos muchísimo a Micoa, pero recordemos que también debemos probar a los robots. Para ellos, nos pidieron que diseñemos las siguientes pruebas:

pruebaBrasilera: un conjunto de robots debe jugar al zamba dando 10 vueltas por segundo. Nos interesa quedarnos solamente con los robots que siguen funcionando, es decir, los que su nivel de náuseas es menor a 80.
champions: queremos a los 3 robots que hayan conseguido la mayor cantidad de tickets luego de jugar a un determinado juego.
tourCompleto: queremos ver cómo queda un robot luego de jugar un conjunto de juegos.

¡Al finalizar las pruebas también necesitan que desarrollemos un juego nuevo!

montañaRusa: se sube un robot a un asiento determinado y en consecuencia se aumenta su nivel de náuseas en 10 unidades por el número de asiento del robot en la montaña rusa. Si al finalizar el robot sigue funcionando, se le dan 50 tickets por su valentía.

Parte C
Para hacer la previa a la apertura del parque, nos dieron infinitos robots para terminar de hacer las pruebas y no pidieron que justifiquemos la respuesta a la siguiente pregunta:

¿Podemos conocer a 100 robots que sigan funcionando después de hacer el tourCompleto integrado por 5 zambas con 1 vuelta por segundo y 3 daytonas?

Aclaraciones

Todas las funciones deberán estar tipadas.
NO repetir lógica.
Usar composición siempre que sea posible.
