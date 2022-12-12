import Text.Show.Functions ()
 -- PARTE A
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

-- Mappers
mapDificultad :: (Int -> Int) -> Plato -> Plato
mapDificultad unaFuncion unPlato = unPlato {dificultad = max 0 . min 10 . unaFuncion . dificultad $ unPlato}

mapComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
mapComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion . componentes $ unPlato}

-- Setters
setDificultad :: Int -> Plato -> Plato
setDificultad = mapDificultad . const

-- 1.
endulzar :: Int -> Truco
endulzar unosGramos = mapComponentes (++ [("azucar", unosGramos)])

-- 2.
salar :: Int -> Truco
salar unosGramos = mapComponentes (++ [("sal", unosGramos)])

-- 3.
darSabor :: Int -> Int -> Truco
darSabor gramosSal gramosAzucar = endulzar gramosAzucar . salar gramosSal

-- 4.
duplicarPorcion :: Truco
duplicarPorcion = mapComponentes (map (\(ingrediente, gramos) -> (ingrediente, 2 * gramos)))

-- 5.
simplificar :: Truco
simplificar unPlato
  | esUnBardo unPlato = setDificultad 5 . mapComponentes (filter (gramosMayorA 10)) $ unPlato
  | otherwise = unPlato

esUnBardo :: Plato -> Bool
esUnBardo unPlato = cantidadComponentes unPlato > 5 && dificultad unPlato > 7

cantidadComponentes :: Plato -> Int
cantidadComponentes = length . componentes

gramosMayorA :: Int -> Componente -> Bool
gramosMayorA unosGramos (_, gramos) = gramos > unosGramos
