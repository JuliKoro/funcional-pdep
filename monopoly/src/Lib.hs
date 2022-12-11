import Text.Show.Functions ()

data Jugador = UnJugador {
  nombre :: String,
  dinero :: Float,
  tactica :: String,
  propiedades :: [Propiedad],
  acciones :: [Accion]
} deriving Show

type Propiedad = (String, Float)
type Accion = Jugador -> Jugador

-- 1. Jugadores
carolina :: Jugador
carolina = UnJugador {
  nombre = "Carolina",
  dinero = 500,
  tactica = "Accionista",
  propiedades = [],
  acciones = [pasarPorElBanco, pagarAAccionistas]
}

manuel :: Jugador
manuel = UnJugador {
  nombre = "Manuel",
  dinero = 500,
  tactica = "Oferente singular",
  propiedades = [],
  acciones = [pasarPorElBanco, enojarse]
}

-- Mappers
mapNombre :: (String -> String) -> Jugador -> Jugador
mapNombre unaFuncion unJugador = unJugador {nombre = unaFuncion . nombre $ unJugador}

mapDinero :: (Float -> Float) -> Jugador -> Jugador
mapDinero unaFuncion unJugador = unJugador {dinero = unaFuncion . dinero $ unJugador}

mapTactica :: (String -> String) -> Jugador -> Jugador
mapTactica unaFuncion unJugador = unJugador {tactica = unaFuncion . tactica $ unJugador}

mapAcciones :: ([Accion] -> [Accion]) -> Jugador -> Jugador
mapAcciones unaFuncion unJugador = unJugador {acciones = unaFuncion . acciones $ unJugador}

mapPropiedades :: ([Propiedad] -> [Propiedad]) -> Jugador -> Jugador
mapPropiedades unaFuncion unJugador = unJugador {propiedades = unaFuncion . propiedades $ unJugador}

-- Setters
setTactica :: String -> Jugador -> Jugador
setTactica unaTactica = mapTactica (const unaTactica) --Aplicacion Parcial
--setTactica = mapTactica . const --Point free
--setTactica unaTactica unJugador = mapTactica (const unaTactica) unJugador

-- 2. Acciones
pasarPorElBanco :: Accion
pasarPorElBanco = (setTactica "Comprador compulsivo") . mapDinero (+ 40)

enojarse :: Accion
enojarse =  mapAcciones (++ [gritar]) . mapDinero (+ 50)

gritar :: Accion
gritar = mapNombre ("AHHHH " ++)

subastar :: Propiedad -> Accion
subastar unaPropiedad unJugador
  | tieneTactica "Oferente singular" unJugador || tieneTactica "Accionista" unJugador = ganarPropiedad unaPropiedad unJugador
  | otherwise = unJugador

tieneTactica :: String -> Jugador -> Bool
tieneTactica unaTactica = (unaTactica ==) . tactica

ganarPropiedad :: Propiedad -> Accion
ganarPropiedad unaPropiedad = mapPropiedades (++ [unaPropiedad]) . mapDinero (+ (-snd unaPropiedad))

cobrarAlquileres :: Accion
cobrarAlquileres unJugador = mapDinero ((+) . recaudacionAlquileres . propiedades $ unJugador) unJugador

recaudacionAlquileres :: [Propiedad] -> Float
recaudacionAlquileres [] = 0
recaudacionAlquileres (x:xs)
  | esBarata x = 10 + recaudacionAlquileres xs
  | otherwise = 20 + recaudacionAlquileres xs

esBarata :: Propiedad -> Bool
esBarata = (< 150) . snd

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
  | tactica unJugador == "Accionista" = mapDinero (+ 200) unJugador
  | otherwise = mapDinero (+ (-100)) unJugador

hacerBerrinchePor :: Propiedad -> Accion
hacerBerrinchePor unaPropiedad unJugador
  | leAlcanza unaPropiedad unJugador = ganarPropiedad unaPropiedad unJugador
  | otherwise = hacerBerrinchePor unaPropiedad . mapDinero (+ 10) . gritar $ unJugador

leAlcanza :: Propiedad -> Jugador -> Bool
leAlcanza (_, precio) (UnJugador _ dinero _ _ _) = dinero >= precio

ultimaRonda :: Accion -- ¿Se puede ejecutar y que a la vez aplique las funciones que se agregan sobre la marcha?
ultimaRonda unJugador = foldl (flip ($)) unJugador (acciones unJugador)
--ultimaRonda unJugador = foldl (flip (.)) id (acciones unJugador) $ unJugador

--aplicarAcciones :: [Accion] -> Accion
--aplicarAcciones [] unJugador = unJugador
--aplicarAcciones (x:xs) unJugador = (aplicarAcciones xs) . x $ unJugador

-- 3. Propiedades
edificioKavanagh :: Propiedad
edificioKavanagh = ("Edificio Kavanagh", 2000)

teatroColon :: Propiedad
teatroColon = ("Teatro Colon", 2500)

palacioBarolo :: Propiedad
palacioBarolo = ("Palacio Barolo", 1900)

galeriaGuemes :: Propiedad
galeriaGuemes = ("Galeria Guemes", 1000)

palacioPaz :: Propiedad
palacioPaz = ("Palacio Paz", 3000)

-- 4. Ganador
juegoFinal :: Jugador -> Jugador -> Jugador
juegoFinal jugador1 jugador2 = quienTieneMasDinero (jugarNRondas 2 jugador1) (jugarNRondas 2 jugador2)

jugarNRondas :: Int -> Jugador -> Jugador
jugarNRondas n unJugador = iterate ultimaRonda unJugador !! n

quienTieneMasDinero :: Jugador -> Jugador -> Jugador
quienTieneMasDinero jugador1 jugador2
  | dinero jugador1 > dinero jugador2 = jugador1
  | dinero jugador2 > dinero jugador1 = jugador2
  | otherwise = error "No pueden tener lo mismo"
