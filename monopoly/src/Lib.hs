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

-- Setters
setTactica :: String -> Jugador -> Jugador
setTactica unaTactica unJugador = mapTactica (const unaTactica) unJugador

-- 2. Acciones
pasarPorElBanco :: Accion
pasarPorElBanco unJugador = (setTactica "Comprador compulsivo") . mapDinero (+ 40) $ unJugador

enojarse :: Accion
enojarse unJugador =  mapAcciones (++ [gritar]) . mapDinero (+ 50) $ unJugador

gritar :: Accion
gritar unJugador = mapNombre ("AHHHH " ++) unJugador

subastar :: Accion
subastar

cobrarAlquileres :: Accion
cobrarAlquileres

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
  | tactica unJugador == "Accionista" = mapDinero (+ 200) unJugador
  | otherwise = mapDinero (+ (-100)) unJugador

hacerBerrinchePor :: Accion
hacerBerrinchePor
