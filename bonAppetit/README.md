# Bon Appétit
Nos piden realizar la versión inicial de un sistema totalmente innovador, jamás visto en la industria y menos en PdeP: Un sistema de comidas y eventos.

Resolver los siguientes requerimientos aprovechando los conceptos del paradigma funcional, asegurando también indicar el tipo de todas las funciones principales desarrolladas.

Sabemos que cuando una persona come una comida consume cierta cantidad de calorías e incorpora nutrientes (para los cuales nos alcanza con saber cuáles son).
Modelar a las personas de la forma más conveniente y, para mostrar ejemplos de uso más adelante, indicar cómo se representaría a Sofía, que aún no comió nada (tiene 0 calorías y ningún nutriente aún).
Definir una función para que una persona incorpore un nutriente, teniendo en cuenta que en caso de que ya haya incorporado este nutriente, el mismo no debería agregarse nuevamente.
Modelar las siguientes comidas como consideres más adecuado. Para cada una se indica cuál será la consecuencia de que una persona la coma.
Tomate, que aporta los nutrientes vitamina A y vitamina C.
Zanahoria, que aporta vitaminas A, C, E y K.
Carne (debe indicarse la cantidad en gramos), que aporta 240 calorías cada 10 gramos, y los nutrientes calcio y hierro.
Pan, que siempre aporta zinc, y adicionalmente (dependiendo de qué tipo de pan sea):
Blanco: Aporta 265 calorías.
Integral: Aporta 200 calorías, además aporta fibras.
De papa: Tiene un comportamiento bastante especial… Si la persona que lo come ya está pipona (más de 2000 calorías), sólo le aporta 100 calorías. En caso contrario, aporta 500 calorías.
Hamburguesa cheta: equivalente a comer primero un pan de papa, luego tomate, luego 180 gramos de carne y finalmente otro pan de papa.
Dado un menú (un conjunto de comidas), queremos saber cómo queda una persona luego de comer cada cosa. Mostrar un ejemplo de uso haciendo que Sofía coma un menú que incluye pan integral, zanahoria y una hamburguesa cheta.
A continuación queremos incorporar a nuestro modelo a los eventos que queremos organizar. Un evento se compone de un nombre (ejemplo “Casamiento de Mirta y José”), un menú, y unos invitados. Teniendo esto en cuenta, se pide desarrollar la siguiente funcionalidad:
Alta fiesta: Se cumple para un evento si todas las personas invitadas quedarían satisfechas (piponas o con al menos 5 nutrientes) luego de comer el menú del evento.
Hay gente astuta que logra hacerse invitar en algunos eventos. Pero no a cualquiera, solo a los que valen la pena. Así que dado un conjunto de eventos, queremos que la persona a colarse se agregue entre los invitados, pero únicamente en las que sean altas fiestas (el resto de los eventos deben incluirse también en la respuesta, aunque no se haya colado la persona).
Justificar conceptualmente: ¿Se podría determinar si un evento es alta fiesta si tuviese infinitos invitados?
