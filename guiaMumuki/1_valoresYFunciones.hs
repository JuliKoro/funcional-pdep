-- 2. Los números
cantidadDiasEnero = 31

-- 3. Valores y alias
cantidadRuedasBicicleta = 2
cantidadRuedasMoto = cantidadRuedasBicicleta

-- 4. Más valores
marioTieneGato = False
peliculaFavoritaAna = "Gladiador"

-- 5. Las Funciones
anterior numero = numero - 1

-- 6. Más funciones
doble numero = numero * 2
cuadrado numero = numero * numero

-- 7. Los booleanos
esNegativo numero = numero < 0

-- 8. Múltiples parámetros
areaRectangulo lado1 lado2 = lado1 * lado2

-- 9. Triángulos
perimetroTriangulo lado1 lado2 lado3 = lado1 + lado2 + lado3

-- 10. Combinando funciones
dobleDelCuadrado numero = doble (cuadrado numero)

-- 11. Composición
tripleDelAnterior = triple.anterior

-- 12. Más composición
masDos = siguiente . siguiente

-- 13. Los operadores son funciones
doble numero = (*) numero 2

-- 14. "Juguemos con strings"
cuantoMidenJuntos palabra1 palabra2 = length (palabra1 ++ palabra2)
