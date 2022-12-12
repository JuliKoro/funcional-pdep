import Text.Show.Functions ()
 -- PARTE A
 -- Modelados y Alias de Tipos
data Participante = UnParticipante {
  nombre :: String,
  trucos :: [Truco],
  especialidad :: Plato
} deriving Show

data Plato = UnPlato {
  dificultad :: Int,
  componentes :: [Componente]
} deriving Show

type Truco = Plato -> Plato
type Componente = (String, Int)

christophe :: Participante -- Participante de ejemplo
christophe = UnParticipante {
  nombre = "Christophe Krywonis",
  trucos = [(darSabor 3 2)],
  especialidad = ñoquis
}

ñoquis :: Plato -- Plato de ejemplo
ñoquis = UnPlato 8 [("harina", 300), ("papa", 500), ("tomate", 200), ("cebolla", 100), ("ajo", 10), ("morron", 50), ("curri", 5), ("pimienta", 8)]

-- Mappers
mapDificultad :: (Int -> Int) -> Plato -> Plato
mapDificultad unaFuncion unPlato = unPlato {dificultad = max 0 . min 10 . unaFuncion . dificultad $ unPlato}

mapComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
mapComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion . componentes $ unPlato}

-- Setters
setDificultad :: Int -> Plato -> Plato
setDificultad = mapDificultad . const

-- Getter
componente :: String -> Plato -> Componente
componente unIngrediente = head . filter ((== unIngrediente) . fst) . componentes

-- Trucos
-- 1.
endulzar :: Int -> Truco
endulzar unosGramos = condimentarCon "azucar" unosGramos

condimentarCon :: String -> Int -> Plato -> Plato
condimentarCon unIngrediente unosGramos = mapComponentes (++ [(unIngrediente, unosGramos)])

-- 2.
salar :: Int -> Truco
salar unosGramos = condimentarCon "sal" unosGramos

-- 3.
darSabor :: Int -> Int -> Truco
darSabor gramosSal gramosAzucar = endulzar gramosAzucar . salar gramosSal

-- 4.
duplicarPorcion :: Truco
duplicarPorcion = mapComponentes (map (\(ingrediente, gramos) -> (ingrediente, 2 * gramos)))

-- 5.
simplificar :: Truco
simplificar unPlato
  | esComplejo unPlato = setDificultad 5 . mapComponentes (filter (gramosMayorA 10)) $ unPlato
  | otherwise = unPlato

gramosMayorA :: Int -> Componente -> Bool
gramosMayorA unosGramos (_, gramos) = gramos > unosGramos

-- Cualidades Platos
-- 1.
esVegano :: Plato -> Bool
esVegano unPlato =  (not . tiene "carne" $ unPlato) || (not . tiene "huevos" $ unPlato) || (not . contieneElementos lacteos $ unPlato)

tiene :: String -> Plato -> Bool
tiene unIngrediente = elem unIngrediente . map fst . componentes

contieneElementos :: [String] -> Plato -> Bool
contieneElementos [] _ = False
contieneElementos (x:xs) unPlato = tiene x unPlato || contieneElementos xs unPlato

lacteos :: [String]
lacteos = ["leche", "queso", "crema", "manteca", "yogurt"]

-- 2.
esSinTacc :: Plato -> Bool
esSinTacc = not . tiene "harina"

-- 3.
esComplejo :: Plato -> Bool
esComplejo unPlato = cantidadComponentes unPlato > 5 && dificultad unPlato > 7

cantidadComponentes :: Plato -> Int
cantidadComponentes = length . componentes

-- 4.
noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = tiene "sal" unPlato && (gramosMayorA 2 . componente "sal" $ unPlato)

-- PARTE B: Prueba Piloto
pepeRonccino :: Participante
pepeRonccino = UnParticipante {
  nombre = "Pepe Ronccino",
  trucos = [(darSabor 2 5), simplificar, duplicarPorcion],
  especialidad = torreDePanqueques
}

torreDePanqueques :: Plato
torreDePanqueques = UnPlato {
  dificultad = 8,
  componentes = [("huevos", 2), ("harina", 200), ("leche", 500), ("sal", 10), ("queso", 200), ("carne", 100), ("aceitunas", 30), ("palta", 300), ("jugo de limon", 2), ("mayonesa", 60)]
}

-- PARTE C: ¡A cocinar!
-- 1.
cocinar :: Participante -> Plato
--cocinar unParticipante = foldl (flip ($)) (especialidad unParticipante) (trucos unParticipante) -- aplica los trucos de izqueirda a derecha
cocinar unParticipante = foldr ($) (especialidad unParticipante) (trucos unParticipante) -- aplica los trucos de derecha a izquierda

-- 2.
esMejorQue :: Plato -> Plato -> Bool
esMejorQue unPlato otroPlato = dificultad unPlato > dificultad otroPlato && peso unPlato < peso otroPlato

peso :: Plato -> Int
peso = sum . map snd . componentes

-- 3.
participanteEstrella :: [Participante] -> Participante
participanteEstrella [] = error "Sin participantes"
participanteEstrella [unParticipante] = unParticipante
participanteEstrella (x1:x2:xs)
  | (cocinar x1) `esMejorQue` (cocinar x2) = participanteEstrella (x1:xs)
  | otherwise = participanteEstrella (x2:xs)

-- PARTE D: Plato Definitivo
platinum :: Plato
platinum = UnPlato {
  dificultad = 10,
  componentes = componentesMiseriosos
}

componentesMiseriosos :: [Componente]
componentesMiseriosos = zip (repetirPalabras "Ingrediente ") [1..]

repetirPalabras :: String -> [String]
repetirPalabras unaPalabra = map ((unaPalabra ++) . show) . iterate (+1) $ 1

{- Preguntas Teóricas:
¿Qué sucede si aplicamos cada uno de los trucos modelados en la Parte A al platinum?
  Para los trucos de endulzar, salar, darSabor y simplificar no podría responder con un nuevo plato, ya que al ser funciones que se aplican sobre una
lista infinita, no termina de evaluarla, ya que necesita agregar ingredientes al final (edulzar, salar, darSabor) o necesita conocer la lista
completa de componentes para poder filtrarla (simplificar).
  En el caso de duplicarPorcion, si responde con otra lista infinita donde simplemente los gramos de los ingredientes aumentan exponencialmente como
potencias de 2.

¿Cuáles de las preguntas de la Parte A (esVegano, esSinTacc, etc.) se pueden responder sobre el platinum?
  En los casos de esVegano, esSinTacc o noAptoHipertension, no respondería nunca, ya que necesita evaluar la lista entera para saber si alguno de los
componentes cumple con tal condición.
  En el caso de esComplejo, tampoco podría responder, ya que se queda evaluando la longitud de una lista infinita.

¿Se puede saber si el platinum es mejor que otro plato?
  Nunca lo sería, ya que al tener infinitos componentes debería sumar todos sus pesos y nunca terminaría de evaluarlos.
  Ademas de que si se compara otroPlato `esMejorQue` platinum, y otroPlato tiene dificultad menor a 10, respondería False ya que no necesita
evaluar y comparar los pesos, esto se debe a que Haskell utiliza Lazy Evaluation
-}
