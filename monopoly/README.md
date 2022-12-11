# Monopoly
### [Tarea Opcional - 16/05/2022](https://docs.google.com/document/d/1KazDAzeUB7lYIbuob36d8SS4DGV3_eK93MODm0fWMJY/edit)
![Monopoly](https://www.freelogovectors.net/wp-content/uploads/2016/12/monopoly-logo1.png)

La cuarentena sigue y levante la mano quién empezó a desempolvar los juegos de mesa 🙋‍♀️🙋‍♂️. Nos encontramos con el _Monopoly_: un juego en donde cada participante compra y vende propiedades con el objetivo de monopolizar la oferta de inmuebles. En esta ocasión, queremos programar tan famoso juego y creemos que vos sos la persona indicada para hacerlo 👩‍💻👨‍💻. ¡A programar!

Carolina y Manuel son participantes del juego y tienen las siguientes características:

- Su nombre.
- Una cantidad de dinero.
- Su táctica de juego.
- Sus propiedades compradas, de las cuales sabemos su nombre y su precio.
- Sus acciones a lo largo del juego.

Cada participante comienza con $500, ninguna propiedad a su nombre y con la acción **pasarPorElBanco**, ya que es lo primero que hacen. Además, cada participante tiene su propio estilo:
- La táctica infalible de Carolina es ser una “Accionista” y, por esa razón, también tiene la acción **pagarAAccionistas**.
- Manuel es un “Oferente singular” y su acción inicial, además de la del banco, es **enojarse**.

Las acciones que puede realizar a lo largo del juego cada participante son:

- **pasarPorElBanco**: aumenta el dinero del jugador en $40 y cambia su táctica a “Comprador compulsivo”.
- **enojarse**: suma $50 y agrega gritar a sus acciones.
- **gritar**: agrega “AHHHH” al principio de su nombre.
- **subastar**: al momento de una subasta solo quienes tengan como tácticas “Oferente singular” o “Accionista” podrán ganar la propiedad. Ganar implica restar el precio de la propiedad de su dinero y sumar la nueva adquisición a sus propiedades.
- **cobrarAlquileres**: suma $10 por cada propiedad barata y $20 por cada propiedad cara obtenida. Las propiedades baratas son aquellas cuyo precio es menor a $150.
- **pagarAAccionistas**: resta $100 para todos los casos excepto que la táctica sea “Accionista”, en ese caso suma $200.
- **hacerBerrinchePor**: cuando una persona hace un berrinche por una propiedad se le suman $10 y se la hace gritar, la persona sigue haciendo berrinche hasta que llegue a comprar la propiedad que quiere.

Finalmente llega la tan ansiada ronda final: Carolina vs Manuel. Quien gane el juego será aquella persona que, luego de realizar todas sus acciones, tenga más dinero. Para ello, modelar la función **ultimaRonda**, que dado un participante retorna una acción equivalente a todas sus acciones.

Se pide:
- Modelar a Carolina y Manuel.
- Modelar las acciones.
- Modelar las propiedades.
- Hacer una función **juegoFinal** la cual toma dos participantes y devuelve al ganador.
