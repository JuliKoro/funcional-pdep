-- (Dis)funcional
-- Corrección de errores comunes en Funcional
-- 1.
--tieneNombreLargo mascota = length (fst mascota) > 9 == True -- Se puede quitar el True ya que es elemnto neutro de ==
--tieneNombreLargo mascota = length (fst mascota) > 9 -- Se puede componer
tieneNombreLargo mascota = (> 9) . length . fst $ mascota

-- 2.
--sumarEnergia (Persona _ energia _ _) = (Persona _ (energia + 5) _ _) -- No se usan _ del lado e los valores
--sumarEnergia (Persona nombre energia ciudad edad) = (Persona nombre (energia + 5) ciudad edad) --Se puede usar un mapper
sumarEnergia unaPersona = mapEnergia (+ 5) unaPersona

mapEnergia unaFuncion (Persona nombre energia ciudad edad) = (Persona nombre (unaFuncion energia) ciudad edad)

--data Persona = Persona String Int String Int -- Sin Record Sintax

data Persona = Persona { -- Con Record Sintax
  nombre :: String,
  energia :: Int,
  ciudad :: String,
  edad :: Int
}

-- 3.
triplicarLosPares :: [Int] -> [Int]
--triplicarLosPares numeros = (map (*3) . filter . even) numeros -- Está mal usada la composición
--triplicarLosPares numeros = map (*3) . filter even $ numeros
triplicarLosPares = map (*3) . filter even --con point free

-- 4.1
--sonTodosMamiferos animales = all (==True) (map esMamifero animales) -- Es redundante tener una lista de booleanos y evaluarla
sonTodosMamiferos animales = all esMamifero animales

-- 4.2
-- and -> De una lista de booleanos, realiza && entre todos sus elementos (fold)
-- or -> De una lista de booleanos, realiza || entre todos sus elementos (fold)
--sonTodosMamiferos' animales = (and . map esMamifero) animales -- es poco declarativo, misma corrección que 4.1
sonTodosMamiferos' animales = all esMamifero animales

{- Ejemplo zipWith:
zipWith esMultiplo [1,2,3] [6,7,8,9,10]
[False, False, False]
-}

-- 5.
{- Repetición de los tipos, se puede usar un type alias
abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAireA :: Casa -> Int -> Casa
mudarseA :: String -> Casa -> Casa
-}

type Domotica = Casa -> Casa

prenderEstufa :: Domotica
encenderElAireA :: Casa -> Int -> Casa
mudarseA :: String -> Domotica

encenderElAireAlReves :: Int -> Domotica --Alternativa para no usar flip
encenderElAireAlReves unaTemperatura unaCasa = encenderElAireA unaCasa unaTemperatura

miCasaInteligente = Casa
   { direccion = "Medrano 951",
     temperatura = 26,
     --reguladoresDeTemperatura = [abrirVentanas, prenderEstufa, mudarseA, encenderElAireA 24] --Las listas deben ser homogénicas
     reguladoresDeTemperatura = [
        abrirVentanas,
        prenderEstufa,
        mudarseA "Av. Antartida Argentina 1234", -- funcion como aplicacion parcial
        flip encenderElAireA 24 -- flip para invertir el orden de los parametros a recibir
     ]
   }

-- 6.
{- abrirVentanas casa = casa { --No hace falta expresar los otros campos si no se modifican
  direccion = direccion casa, <-
  temperatura = temperatura casa - 2,
  reguladoresDeTemperatura = reguladoresDeTemperatura casa <-
} -}

abrirVentanas :: Domotica
abrirVentanas casa = casa {
  temperatura = temperatura casa - 2 -- Se podría usar un mapper acá también
}

-- 87
{-
esBeatle _ = False -- Está mal hecho el pattern matching, lo más genérico va al final
esBeatle "Ringo" = True
esBeatle "John" = True
esBeatle "George" = True
esBeatle "Paul" = True
-}
{- Se puede resolver con un elem también
esBeatle "Ringo" = True
esBeatle "John" = True
esBeatle "George" = True
esBeatle "Paul" = True
esBeatle _ = False
-}

esBeatle unBeatle = elem unBeatle beatles
  where beatles = ["Ringo", "John", "George", "Paul"] -- where define algo de forma local

-- 8.
edad :: Persona -> Int
{-
sumaDeLasEdadesRecursiva [] = 0
sumaDeLasEdadesRecursiva lista = -- lista no es un buen nombre, no tiene expresividad
    edad (head lista) + sumaDeLasEdadesRecursiva (drop 1 lista)
-}
{-
sumaDeLasEdadesRecursiva [] = 0
sumaDeLasEdadesRecursiva individuos = -- Conviene usar otro patron para la lista, separando cabeza y cola
    edad (head lista) + sumaDeLasEdadesRecursiva (drop 1 individuos)
-}
sumaDeLasEdadesRecursiva [] = 0 -- Se puede evitar la recurisividad también
sumaDeLasEdadesRecursiva (unIndividuo : otrosIndividuos) =
   edad unIndividuo + sumaDeLasEdadesRecursiva otrosIndividuos

sumaDeLasEdades unosIndividuos = sum . map edad $ unosIndividuos

-- 9.
{-
agregarValor valor indice lista =
  take (indice - 1) lista  ++ [valor] ++ drop indice lista -- Se puede simplificar concatenando el resto de la lista (+ declarativo)
-}
agregarValor valor indice lista =
  take (indice - 1) lista  ++ valor : drop indice lista

-- 10.
--poneleUnNombre numeros = (sum (map (*3) (filter even numeros))) < 100 -- Usar composición
--poneleUnNombre numeros = ((< 100) . sum . map (* 3) . filter even) numeros -- Sin $
--poneleUnNombre numeros = (< 100) . sum . map (* 3) . filter even $ numeros -- Con $
poneleUnNombre = (< 100) . sum . map (* 3) . filter even -- Con point free
poneleUnNombre' = (sum . map (* 3) . filter even) numeros < 100 -- Con notación infija
