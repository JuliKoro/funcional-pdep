import Text.Show.Functions ()

-- Modelado y Tipados
data Persona = UnaPersona {
  nombre :: String,
  calorias :: Int,
  hidratacion :: Int,
  disponibilidad :: Tiempo,
  equipamiento :: [String]
} deriving Show

type Tiempo = Int -- minutos
type Ejercicio = Persona -> Persona
type Rutina = (Tiempo, [Ejercicio])

-- Mappers
mapNombre :: (String -> String) -> Persona -> Persona
mapNombre unaFuncion unaPersona = unaPersona {nombre = unaFuncion . nombre $ unaPersona}

mapCalorias :: (Int -> Int) -> Persona -> Persona
mapCalorias unaFuncion unaPersona = unaPersona {calorias = max 0 . unaFuncion . calorias $ unaPersona}

mapHidratacion :: (Int -> Int) -> Persona -> Persona
mapHidratacion unaFuncion unaPersona = unaPersona {hidratacion = max 0 . min 100 . unaFuncion . hidratacion $ unaPersona}

mapEquipamiento :: ([String] -> [String]) -> Persona -> Persona
mapEquipamiento unaFuncion unaPersona = unaPersona {equipamiento = unaFuncion . equipamiento $ unaPersona}

-- Setters

setHidratacion :: Int -> Persona -> Persona
setHidratacion = mapHidratacion . const

setEquipamiento :: [String] -> Persona -> Persona
setEquipamiento = mapEquipamiento . const

-- Funciones auxiliares
perderCalorias :: Int -> Persona -> Persona
perderCalorias = mapCalorias . subtract -- resta unasCalorias de las calorias

perderHidratacion :: Int -> Persona -> Persona
perderHidratacion = mapHidratacion . subtract

-- PARTE A
-- Ejercicios
-- 1.
abdominales :: Int -> Ejercicio
abdominales repeticiones = perderCalorias (8 * repeticiones)

-- 2.
flexiones :: Int -> Ejercicio
flexiones repeticiones = perderCalorias (16 * repeticiones) . perderHidratacion (repeticiones `div` 10 * 2)

-- 3.
levantarPesas :: Int -> Int -> Ejercicio
levantarPesas repeticiones unPeso unaPersona
  | tieneEquipamiento "pesa" unaPersona = perderCalorias (32 * repeticiones) . perderHidratacion (repeticiones `div` 10 * unPeso) $ unaPersona
  | otherwise = unaPersona

tieneEquipamiento :: String -> Persona -> Bool
tieneEquipamiento unObjeto = elem unObjeto . equipamiento

-- 4.
laGranHomeroSimpson :: Ejercicio
laGranHomeroSimpson = id

-- Otras acciones
-- 1.
renovarEquipo :: Persona -> Persona
renovarEquipo = mapEquipamiento (map ("Nuevo " ++))

-- 2.
volverseYoguista :: Persona -> Persona
volverseYoguista = mapCalorias (`div` 2) . mapHidratacion (* 2) . setEquipamiento ["colchoneta"]

-- 3.
volverseBodyBuilder :: Persona -> Persona
volverseBodyBuilder unaPersona
  | tieneSoloPesas unaPersona = mapNombre (++ "BB") . mapCalorias (* 3) $ unaPersona
  | otherwise = unaPersona

tieneSoloPesas :: Persona -> Bool
tieneSoloPesas = all (== "pesa") . equipamiento

-- 4.
comerUnSandwich :: Persona -> Persona
comerUnSandwich = mapCalorias (+ 500) . setHidratacion 100

-- PARTE B: Rutinas
hacerRutina :: Rutina -> Ejercicio
hacerRutina unaRutina unaPersona
  | puedeHacerRutina unaRutina unaPersona = foldr ($) unaPersona (snd unaRutina)
  | otherwise = error "No puede hacer esta rutina"

puedeHacerRutina :: Rutina -> Persona -> Bool
puedeHacerRutina unaRutina unaPersona = (fst unaRutina) <= (disponibilidad unaPersona)

-- 1.
esPeligrosa :: Rutina -> Persona -> Bool
esPeligrosa unaRutina = estaAgotada . hacerRutina unaRutina

-- 2.
esBalanceada :: Rutina -> Persona -> Bool
esBalanceada unaRutina unaPersona = quedaNormal . hacerRutina unaRutina $ unaPersona
  where quedaNormal personaPostRutina = hidratacion personaPostRutina > 80 && calorias personaPostRutina < calorias unaPersona `div` 2

estaAgotada :: Persona -> Bool
estaAgotada unaPersona = calorias unaPersona < 50 && hidratacion unaPersona < 10

elAbominableAbdominal :: Rutina
elAbominableAbdominal = (60, (map abdominales [1..]))

-- PARTE C: Ejercicios grupales
-- 1.
seleccionarGrupoDeEjercicio :: Persona -> [Persona] -> [Persona]
seleccionarGrupoDeEjercicio unaPersona = filter (tienenMismaDisponibilidad unaPersona)

tienenMismaDisponibilidad :: Persona -> Persona -> Bool
tienenMismaDisponibilidad unaPersona otraPersona = disponibilidad unaPersona == disponibilidad otraPersona

-- 2.
promedioDeRutina :: Rutina -> [Persona] -> (Int, Int)
promedioDeRutina unaRutina = estadisticasGrupales . map (hacerRutina unaRutina)

estadisticasGrupales :: [Persona] -> (Int, Int)
estadisticasGrupales unGrupo = (promedioDe calorias unGrupo, promedioDe hidratacion unGrupo)

promedioDe :: (a -> Int) -> [a] -> Int
promedioDe getter = promedio . map getter

promedio :: [Int] -> Int
promedio unosValores = sum unosValores `div` length unosValores
