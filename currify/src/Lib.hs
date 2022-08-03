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

mapCanciones :: Efecto -> Artista -> Artista
mapCanciones unEfecto unArtista = unArtista {canciones = (map unEfecto) . canciones $ unArtista}

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
hacerseDJ :: Artista -> Artista
hacerseDJ unArtista = mapCanciones (efectoPreferido unArtista) unArtista

-- 2.
tieneGustoHomogeneo :: Artista -> Bool
tieneGustoHomogeneo unArtista = sonTodosIguales . map genero . canciones $ unArtista

sonTodosIguales :: Eq a => [a] -> Bool
sonTodosIguales unaLista = all (== head unaLista) unaLista

-- 3.
formarBanda :: String -> [Artista] -> Artista
formarBanda unNombre listaDeArtistas = UnArtista {
  nombre = unNombre,
  canciones = concatMap canciones listaDeArtistas,
  efectoPreferido = metaEfecto . map efectoPreferido $ listaDeArtistas
}

-- 4.
obraMaestraProgresiva :: Artista -> Cancion
obraMaestraProgresiva unArtista = UnaCancion {
  titulo = concatMap titulo . canciones $ unArtista,
  duracion = sum . map duracion . canciones $ unArtista,
  genero = (++ " progresivo") . foldl1 generoSuperador . map genero . canciones $ unArtista
}

generoSuperador :: String -> String -> String
generoSuperador "rock" _ = "rock"
generoSuperador _ "rock" = "rock"
generoSuperador "reggaeton" otroGenero = otroGenero
generoSuperador otroGenero "reggaeton" = otroGenero
generoSuperador unGenero otroGenero = maximoSegun length unGenero otroGenero

maximoSegun :: Ord b => (a -> b) -> a -> a -> a
maximoSegun criterio unValor otroValor
  | max (criterio unValor) (criterio otroValor) == (criterio unValor) = unValor
  | otherwise = otroValor

{- PARTE D
billieEilish :: Artista
billieEilish = UnArtista "Billie Eilish" [badGuy ..] undefined

1. ¿Puede esta nueva artista hacerse dj?
Si, esta aritsta puede hacerseDJ, ya que gracias al "lazy evaluation" que tiene Haskell el efecto es aplicado a la lista de canciones infinitamente.

2. ¿Podemos echar un vistazo a su música?
Si, ya que no hay que esperar a que la lista de canciones termine de generarse y simplemente toma las primeras 3 canciones cortas que encuentre.
Aunque también depende de si la artista posee canciones cortas.

3. ¿Podrá crear una obra maestra progresiva?
No, ya que en este punto si necesita de la lista completa de canciones por lo que el programa no se rompería, sino que se quedaría esperando a que termine la lista, en este caso nunca.
-}
