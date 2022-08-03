# Currify
## Simulacro de Parcial Funcional - Clase 8

Ayer a la noche sucedió un trágico evento, la gente de Spotify subió una canción, pero no contaban con los derechos de autoría de la misma. Lamentablemente su página fue clausurada, peeero como saben de nuestros conocimientos en el paradigma funcional nos pidieron que les creemos una nueva. Para evitar más conflictos decidimos cambiar su nombre a Currify.

Al ser una plataforma de música tenemos tanto canciones como artistas:
de las canciones se sabe que éstas tienen un título, un género y una duración expresada en segundos;
de cada artista sabemos su nombre, sus canciones y su efecto preferido.

Los efectos que conocemos son:
acortar: crea una nueva canción que dura un minuto menos que la original (las duraciones no pueden ser un número negativo pero sí 0).
remixar: a partir de una canción me devuelve una nueva que:
le agrega la palabra "remix" al final del título original;
posee el doble de duración;
su género es "remixado".
acustizar: recibe una canción y una duración. Si la canción no es de género "acústico", devuelve una nueva con este género y la duración que se recibe por parámetro. Si ya es acústica no hace nada.
metaEfecto: recibe una lista de efectos y se los aplica todos a una canción que también recibimos por parámetro.

Parte A

1. Modelar las canciones.
2. Modelar artistas.
3. Modelar los efectos que conocemos.
4. Modelar las siguientes canciones y artistas:

"Café para dos" es una canción de rock melancólico que dura 146 segundos.
"Fuí hasta ahí" es una canción de rock que dura 4:39 minutos.
"Los escarabajos" es una banda (sí, las bandas también son artistas) que tiene las canciones Rocket Raccoon, Mientras mi batería festeja y Tomate de madera. Su efecto es acortar.
"Adela" es una artista que cuenta con las canciones ¿Te acordás?, Un pibe como vos y Dale mecha a la lluvia. Su efecto predilecto es remixar.
"El tigre Joaco" es un artista que aún no tiene canciones. Su efecto es acustizar con 6 minutos.


Parte B

En Currify, al igual que en Spotify, la gente a veces no quiere escuchar todas las canciones para saber si un artista les gusta o no, así que queremos poder echar un vistazo a algunas canciones cortas de su autoría.
Además, ¡qué sería de una plataforma de streaming de música sin poder crear una playlist! Peeero, como tenemos el poder de armar Currify a nuestro gusto, las playlists las vamos a crear por género.

Modelar vistazo que me devuelve las primeras 3 canciones cortas de un artista. Una canción es corta cuando dura menos de 2 minutos y medio.
Modelar playlist que, dados un género y una lista de artistas, devuelve de sus canciones solo aquellas que pertenecen al género recibido por parámetro.

Parte C

¿No te gustaría saber un poco más del mundo de aquellas personas que son artistas?
No siempre toman los mismos caminos, a veces quieren experimentar y se hacen DJ, otras veces les gusta tanto un género que son fieles a él, otras deciden agruparse y formar bandas… Pero en lo que casi todo el mundo está de acuerdo es que el punto álgido de sus carreras está al crear su obra maestra progresiva.

Modelar hacerseDJ que permite saber cómo queda cada artista luego de aplicar su efecto a todas sus canciones.
Modelar tieneGustoHomogeneo que me dice si todas las canciones de alguien son del mismo género.
Modelar formarBanda que a partir de un nombre y una lista de artistas crea una banda. La banda tendrá como nombre el recibido por parámetro, como canciones las de todas las personas que integran la banda, y como efecto, la combinación de los efectos de cada integrante.
Modelar obraMaestraProgresiva gracias a la cual cada artista podrá crear una nueva canción compuesta por:
título: la concatenación de los títulos de todas sus canciones
duración: la suma de todas las duraciones de esas canciones
género: es el género superador entre todos los géneros de las canciones del artista concatenado con la palabra “progresivo”
    Para armar esta función te va a servir crear otra que dados dos géneros me devuelva cuál es el mejor.
Se sabe que:
El rock supera a cualquier género.
En el resto de los casos gana el que más letras tiene.
El reggaeton no le gana a ninguno.

Parte D

En la escena apareció una artista que está arrasando con todos los premios gracias a que tiene infinitas canciones, pero antes de agregar su música en Currify te preguntamos:

¿Puede esta nueva artista hacerse dj?
¿Podemos echar un vistazo a su música?
¿Podrá crear una obra maestra progresiva?

Justificá todas tus respuestas.

Aclaraciones

Todas las funciones deberán estar tipadas.
NO repetir lógica.
Usar composición siempre que sea posible.
Poner número y nombre a todas las hojas.
