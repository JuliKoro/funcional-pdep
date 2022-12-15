import Text.Show.Functions
import Data.List (sortBy)
-- PARTE A
-- 1. Robots
-- Modelados y Alias de Tipos
data Robot = UnRobot {
  nombre :: String,
  nauseas :: Int,
  tickets :: Int
} deriving (Show)

type Juego = Robot -> Robot
type Prueba = [Robot] -> [Robot]
type Tour = [Juego]

-- Mappers
mapNombre :: (String -> String) -> Robot -> Robot
mapNombre unaFuncion unRobot = unRobot {nombre = unaFuncion . nombre $ unRobot}

mapNauseas :: (Int -> Int) -> Robot -> Robot
mapNauseas unaFuncion unRobot = unRobot {nauseas = unaFuncion . nauseas $ unRobot}

mapTickets :: (Int -> Int) -> Robot -> Robot
mapTickets unaFuncion unRobot = unRobot {tickets = max 0 . unaFuncion . tickets $ unRobot}

-- Funciones auxiliares
entregarTickets :: Int -> Robot -> Robot
entregarTickets unosTickets = mapTickets (+ unosTickets)

-- 2. Juegos
zamba :: Int -> Juego
zamba vueltasPorSegundo = mapNauseas (+ 5 * vueltasPorSegundo)

pumpIt :: Juego
pumpIt = mapNombre ("bailarin " ++) . entregarTickets 10

daytono :: Int -> Juego
daytono 1 unRobot = entregarTickets 10 unRobot
daytono 3 unRobot = mapNauseas (+ 15) unRobot
daytono 2 unRobot
  | tieneMenosLetras 3 unRobot = entregarTickets 30 unRobot
  | otherwise = unRobot

tieneMenosLetras :: Int -> Robot -> Bool
tieneMenosLetras unaCantidad unRobot = (length . nombre $ unRobot) < unaCantidad

carreraDeCaballos :: Juego
carreraDeCaballos = mapTickets (+ (-20))

-- 3.
walle :: Robot
walle = UnRobot {
  nombre = "Wall-E",
  nauseas = 60,
  tickets = 0
}

arturito :: Robot
arturito = UnRobot {
  nombre = "Arturito",
  nauseas = 10,
  tickets = 35
}

jk :: Robot -- ejemplo de robot con menos de 3 letras
jk = UnRobot {
  nombre = "JK",
  nauseas = 100,
  tickets = 0
}

messi :: Robot -- ejemplo de Robot
messi = UnRobot {
  nombre = "Messitron",
  nauseas = 0,
  tickets = 10
}

robotsInvitados :: [Robot] -- Ejemplo de unos robots para las Pruebas
robotsInvitados = [messi, jk, walle, arturito]

-- PARTE B: Pruebas
pruebaBrasilera :: Prueba
pruebaBrasilera = filter funciona . map (zamba 10)

funciona :: Robot -> Bool
funciona unRobot = (nauseas unRobot) < 80

champions :: Juego -> Prueba
champions unJuego unosRobots = take 3 . reverse . sortBy compareTickets . map unJuego $ unosRobots

compareTickets :: Robot -> Robot -> Ordering
compareTickets (UnRobot _ _ unosTickets) (UnRobot _ _ otrosTickets) = compare unosTickets otrosTickets

tourCompleto :: Tour -> Robot -> Robot
tourCompleto unTour unRobot = foldr ($) unRobot unTour

-- Juego nuevo
montañaRusa :: Int -> Juego
montañaRusa numeroAsiento unRobot
  | funciona . (efectoMontañaRusa numeroAsiento) $ unRobot = entregarTickets 50 . (efectoMontañaRusa numeroAsiento) $ unRobot
  | otherwise = efectoMontañaRusa numeroAsiento unRobot

efectoMontañaRusa :: Int -> Robot -> Robot
efectoMontañaRusa numeroAsiento = mapNauseas (+ 10 * numeroAsiento)

-- PARTE C: Infinitos Robots
infinitosRobots :: Robot -> [Robot]
infinitosRobots = repeat

tourXL :: [Juego]
tourXL = [zamba 1, zamba 1, zamba 1, zamba 1, zamba 1, daytono 1, daytono 2, daytono 3]

pruebaTourXL :: Prueba
pruebaTourXL unosRobots = take 100 . filter funciona . map (tourCompleto tourXL) $ unosRobots

{-
¿Podemos conocer a 100 robots que sigan funcionando después de hacer el tourCompleto integrado
por 5 zambas con 1 vuelta por segundo y 3 daytonas?

Rta: Si, podemos conocer los primeros 100 robots, ya que Haskell funciona con Evaluación Perezosa y no necesita a que la lista infinita
de Robots termine de generarse, solo toma los primeros 100 que cumplan la condición y por lo tanto termina de evaluar y responder correctamente.
-}
