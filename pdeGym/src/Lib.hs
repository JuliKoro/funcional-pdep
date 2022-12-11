import Text.Show.Functions ()

-- PARTE A
data Persona = UnaPersona {
  nombre :: String,
  calorias :: Int,
  hidratacion :: Int,
  disponibilidad :: Float,
  equipamiento :: [String]
} deriving Show

type Ejercicio = Persona -> Persona

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
setCalorias :: Int -> Persona -> Persona
setCalorias = mapCalorias . const

setHidratacion :: Int -> Persona -> Persona
setHidratacion = mapHidratacion . const

setEquipamiento :: [String] -> Persona -> Persona
setEquipamiento = mapEquipamiento . const

-- Funciones auxiliares
perderCalorias :: Int -> Persona -> Persona
perderCalorias = mapCalorias . subtract -- resta unasCalorias de las calorias

perderHidratacion :: Int -> Persona -> Persona
perderHidratacion = mapHidratacion . subtract

tieneEquipamiento :: String -> Persona -> Bool
tieneEquipamiento unObjeto = elem unObjeto . equipamiento

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

-- 4.
laGranHomeroSimpson :: Ejercicio
laGranHomeroSimpson = id

-- Otras acciones
-- 1.
renovarEquipo :: Persona -> Persona
renovarEquipo = mapEquipamiento (map ("Nuevo " ++))

-- 2.
volverseYoguista :: Persona -> Persona
volverseYoguista = mapCalorias (`div` 2) . mapHidratacion (* 2) . setEquipamiento(["colchoneta"])

-- 3.
volverseBodyBuilder :: Persona -> Persona
volverseBodyBuilder unaPersona
  | tieneSoloPesas unaPersona = mapNombre (++ "BB") . mapCalorias (* 3) $ unaPersona
  | otherwise = unaPersona

tieneSoloPesas :: Persona -> Bool
tieneSoloPesas = all (== "pesa") . equipamiento

-- 4.
comerUnSandwich :: Persona -> Persona
comerUnSandwich = setCalorias 500 . setHidratacion 100

-- PARTE B
