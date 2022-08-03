-- Currify
--(Simulacro Parcial Fncional - Clase 8)
import Text.Show.Functions ()
-- PARTE A
-- 1.
data Cancion = UnaCancion {
  titulo :: String,
  genero :: String,
  duracion :: Int
} deriving Show

-- 2.
data Artista = UnArtista {
  nombre :: String,
  canciones :: [Cancion],
  efectoPreferido :: Efecto
} deriving Show

type Efecto = Cancion -> Cancion

-- mappers
mapTitulo :: (String -> String) -> Cancion -> Cancion
mapTitulo unaFuncion unaCancion = unaCancion {titulo = unaFuncion . titulo $ unaCancion}

mapDuracion :: (Int -> Int) -> Cancion -> Cancion
mapDuracion unaFuncion unaCancion = unaCancion {duracion = unaFuncion . duracion $ unaCancion}

mapGenero :: (String -> String) -> Cancion -> Cancion
mapGenero unaFuncion unaCancion = unaCancion {genero = unaFuncion . genero $ unaCancion}

-- setter
setDuracion :: Int -> Cancion -> Cancion
setDuracion = mapDuracion . const

setGenero :: String -> Cancion -> Cancion
setGenero = mapGenero . const

-- 3.
acortar :: Efecto
acortar = mapDuracion (max 0 . subtract 60)

remixar :: Efecto
remixar = mapTitulo (++ "Remix") . mapDuracion (*2) . setGenero "remixado"

acustizar :: Int -> Efecto
acustizar unaDuracion unaCancion
  | esDelGenero "acustico" unaCancion = unaCancion
  | otherwise = (setGenero "acustico") . (setDuracion unaDuracion) $ unaCancion

esDelGenero :: String -> Cancion -> Bool
esDelGenero unGenero unaCancion = genero unaCancion == unGenero

metaEfecto :: [Efecto] -> Efecto
metaEfecto listaDeEfectos unaCancion = foldr ($) unaCancion listaDeEfectos

--4.
cafeParaDos :: Cancion
cafeParaDos = UnaCancion "Café Para Dos" "rock melacólico" 146

fuiHastaAhi :: Cancion
fuiHastaAhi = UnaCancion "Fuí Hasta Ahí" "rock" 239

losEscarabajos :: Artista
losEscarabajos = UnArtista "Los Escarabajos" [rocketRaccoon, mientrasMiBateríaFesteja, tomateDeMadera] acortar

rocketRaccoon :: Cancion
rocketRaccoon = UnaCancion "Rocket Raccoon" undefined undefined

mientrasMiBateríaFesteja :: Cancion
mientrasMiBateríaFesteja = UnaCancion "Mientras Mi Bateria Festeja" undefined undefined

tomateDeMadera :: Cancion
tomateDeMadera = UnaCancion "Tomate De Madera" undefined undefined

adela :: Artista
adela = UnArtista "Adela" [teAcordas, unPibeComoVos, daleMechaALaLluvia] remixar

teAcordas :: Cancion
teAcordas = UnaCancion "¿Te Acordas?" undefined undefined

unPibeComoVos :: Cancion
unPibeComoVos = UnaCancion "Un Pibe Como Vos" undefined undefined

daleMechaALaLluvia :: Cancion
daleMechaALaLluvia = UnaCancion "Dale Mecha A La Lluvia" undefined undefined

elTigreLoco :: Artista
elTigreLoco = UnArtista "El Tigre Loco" [] (acustizar 360)

-- PARTE B
-- 1.
vistazo :: Artista -> [Cancion]
vistazo unArtista = take 3 . filter esCorta . canciones $ unArtista

esCorta :: Cancion -> Bool
esCorta unaCancion = (< 150) . duracion $ unaCancion

-- 2.
playlist :: String -> [Artista] -> [Cancion]
playlist unGenero listaDeArtistas = concatMap (cancionesDelGenero unGenero) listaDeArtistas

cancionesDelGenero :: String -> Artista -> [Cancion]
cancionesDelGenero unGenero unArtista = filter (esDelGenero unGenero) . canciones $ unArtista

-- PARTE C
-- 1.
