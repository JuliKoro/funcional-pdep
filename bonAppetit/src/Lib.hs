-- Bon Appétit
-- Recuperatorio Parcial Funcional - PdeP
import Text.Show.Functions ()
-- 1)
-- a)
data Persona = UnaPersona {
  calorias :: Float,
  nutrientes :: [Nutriente]
} deriving Show

data Comida = UnaComida {
  caloriasComida :: Float,
  nutrientesComida :: [Nutriente]
} deriving Show

data Evento = UnEvento {
  nombre :: String,
  menu :: Menu,
  invitados :: [Persona]
} deriving Show

type Nutriente = String

type Menu = [Comida]

-- mappers
mapNutrientes :: ([Nutriente] -> [Nutriente]) -> Persona -> Persona
mapNutrientes unaFuncion unaPersona = unaPersona {nutrientes = unaFuncion . nutrientes $ unaPersona}

mapCalorias :: (Float -> Float) -> Persona -> Persona
mapCalorias unaFuncion unaPersona = unaPersona {calorias = unaFuncion . calorias $ unaPersona}

mapInvitados :: ([Persona] -> [Persona]) -> Evento -> Evento
mapInvitados unaFuncion unEvento = unEvento {invitados = unaFuncion . invitados $ unEvento}

-- b)
incorporarNutriente :: Nutriente -> Persona -> Persona
incorporarNutriente unNutriente unaPersona
  | any (== unNutriente) . nutrientes $ unaPersona = id unaPersona
  | otherwise = mapNutrientes (unNutriente :) unaPersona

incorporarCalorias :: Float -> Persona -> Persona
incorporarCalorias unasCalorias unaPersona = mapCalorias (+ unasCalorias) unaPersona

-- 2)
-- a)
tomate :: Comida
tomate = undefined ["vitamina A", "vitamina C"]

-- b)
zanahoria :: Comida
zanahoria = undefined ["vitamina A", "vitamina C", "vitamina E", "vitamina K"]

-- c)
carne :: Float -> Comida
carne gramos = UnaComida{
  caloriasComida = gramos * 24,
  nutrientesComida = ["calcio", "hierro"]
}

-- d)
-- i)
panBlanco :: Comida
panBlanco = 256 ["zinc"]

-- ii)
panIntegral :: Comida
panIntegral = 200 ["zinc", "fibras"]

-- iii)
panDePapa :: Persona -> Comida
panDePapa unaPersona = UnaComida {
  caloriasComida = caloriasPanDePapa unaPersona,
  nutrientesComida = ["zinc"]
}

caloriasPanDePapa :: Persona -> Float
caloriasPanDePapa unaPersona
  | estaPipona unaPersona = 100
  | otherwise = 500

estaPipona :: Persona -> Bool
estaPipona unaPersona = calorias unaPersona > 2000

-- e)
hamburguesaCheta :: Persona -> Comida --Corregir
hamburguesaCheta unaPersona = comerMenu [panDePapa, (carne 180), tomate, panDePapa] unaPersona

-- 3)
sofia :: Persona
sofia = undefined undefined

menuSofia :: Menu
menuSofia = [panIntegral, zanahoria, hamburguesaCheta]

comerMenu :: Menu -> Persona -> Persona
comerMenu unMenu unaPersona = map (comer unaPersona) unMenu

comer :: Persona -> Comida -> Persona -- Problema con los $
comer unaPersona unaComida = (incorporarNutriente . nutrientesComida $ unaComida) . (incorporarCalorias . caloriasComida $ unaComida) $ unaPersona

-- 4)
altaFiesta :: Evento -> Bool
altaFiesta unEvento = (all estaSatsifecho) . map (comerMenu . menu $ unEvento) . invitados $ unEvento

estaSatsifecho :: Persona -> Bool
estaSatsifecho unaPersona = (estaPipona unaPersona) || (nutrientes unaPersona >= 5)

-- 5)
colarseEvento :: [Evento] -> Persona -> [Evento]
colarseEvento listaDeEventos unColado = map (\unEvento -> colarseSegun unEvento unColado) listaDeEventos

colarseSegun :: Evento -> Evento
colarseSegun unEvento unColado
  | altaFiesta unEvento = mapInvitados (: unColado) unEvento
  | otherwise = id unEvento

{- 6) ¿Se podría determinar si un evento es alta fiesta si tuviese infinitos invitados?
No, ya que la condicion de que sea alta fiesta depende de si TODOS los invitados estan satisfecho,
y altaFiesta estaría evaluando infinitamente la lista de invitados por lo que no respondería nada hasta que la memoria estalle.
-}
