-- (Dis)funcional
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
--triplicarLosPares numeros = (map (*3) . filter . even) numeros -- Está mal usada la composición
--triplicarLosPares numeros = map (*3) . filter even $ numeros
triplicarLosPares = map (*3) . filter even --con point free

-- 4.1
sonTodosMamiferos animales = all (==True) (map esMamifero animales)

-- 4.2
sonTodosMamiferos’ animales = (and . map esMamifero) animales

-- 5.
abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAireA :: Casa -> Int -> Casa
mudarseA :: String -> Casa -> Casa

miCasaInteligente = Casa
   { direccion = "Medrano 951",
     temperatura = 26,
     reguladoresDeTemperatura = [abrirVentanas, prenderEstufa, mudarseA, encenderElAireA 24]
   }

-- 6.
esBeatle _ = False
esBeatle "Ringo" = True
esBeatle "John" = True
esBeatle "George" = True
esBeatle "Paul" = True

-- 7.
sumaDeLasEdadesRecursiva [] = 0
sumaDeLasEdadesRecursiva lista =
   edad (head lista) + sumaDeLasEdadesRecursiva (drop 1 lista)

-- 8.
abrirVentanas casa = casa { direccion = direccion casa, temperatura = temperatura casa - 2, reguladoresDeTemperatura = reguladoresDeTemperatura casa }

-- 9.
agregarValor valor indice lista = take (indice - 1) lista  ++ [valor] ++ drop indice lista

-- 10.
poneleUnNombre numeros = (sum (map (*3) (filter even numeros))) < 100
