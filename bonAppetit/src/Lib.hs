import Text.Show.Functions ()
-- 1)
-- a) Modelados y Alias de Tipos
data Persona = UnaPersona {
  calorias :: Int,
  nutrientes :: [Nutriente]
} deriving Show

data Evento = UnEvento {
  nombre :: String,
  menu :: Menu,
  invitados :: [Persona]
} deriving Show

type Nutriente = String
type Comida = Persona -> Persona
type Menu = [Comida]

sofia :: Persona -- Sofia sin comer
sofia = UnaPersona {
  calorias = 0,
  nutrientes = []
}

-- mappers
mapNutrientes :: ([Nutriente] -> [Nutriente]) -> Persona -> Persona
mapNutrientes unaFuncion unaPersona = unaPersona {nutrientes = unaFuncion . nutrientes $ unaPersona}

mapCalorias :: (Int -> Int) -> Persona -> Persona
mapCalorias unaFuncion unaPersona = unaPersona {calorias = unaFuncion . calorias $ unaPersona}

mapInvitados :: ([Persona] -> [Persona]) -> Evento -> Evento
mapInvitados unaFuncion unEvento = unEvento {invitados = unaFuncion . invitados $ unEvento}

-- b) Funciones Auxiliares
incorporarNutriente :: Nutriente -> Persona -> Persona
incorporarNutriente unNutriente unaPersona
  | tieneNutriente unNutriente unaPersona = unaPersona
  | otherwise = mapNutrientes (++ [unNutriente]) unaPersona

incorporarNutrientes :: [Nutriente] -> Persona -> Persona
incorporarNutrientes [] unaPersona = unaPersona
incorporarNutrientes (x:xs) unaPersona = incorporarNutriente x . incorporarNutrientes xs $ unaPersona

tieneNutriente :: Nutriente -> Persona -> Bool
tieneNutriente unNutriente = elem unNutriente . nutrientes

incorporarCalorias :: Int -> Persona -> Persona
incorporarCalorias unasCalorias unaPersona = mapCalorias (+ unasCalorias) unaPersona

-- 2) Comidas
-- a)
tomate :: Comida
tomate = incorporarNutrientes ["vitamina A", "vitamina C"]

-- b)
zanahoria :: Comida
zanahoria = incorporarNutrientes ["vitamina A", "vitamina C", "vitamina E", "vitamina K"]

-- c)
carne :: Int -> Comida
carne unosGramos = incorporarCalorias (240 * unosGramos `div` 10) . incorporarNutrientes ["calcio", "hierro"]

-- d) Panes
-- i)
panBlanco :: Comida
panBlanco = incorporarNutriente "zinc" . incorporarCalorias 265

-- ii)
panIntegral :: Comida
panIntegral = incorporarNutrientes ["zinc", "fibras"] . incorporarCalorias 200

-- iii)
panDePapa :: Comida
panDePapa unaPersona
  | estaPipona unaPersona = incorporarNutriente "zinc" . incorporarCalorias 100 $ unaPersona
  | otherwise = incorporarNutriente "zinc" . incorporarCalorias 500 $ unaPersona

estaPipona :: Persona -> Bool
estaPipona unaPersona = calorias unaPersona > 2000

-- e)
hamburguesaCheta :: Comida
hamburguesaCheta = panDePapa . carne 180 . tomate . panDePapa

-- 3)

menuSofia :: Menu
menuSofia = [panIntegral, zanahoria, hamburguesaCheta]

--comerMenu :: Menu -> Persona -> Persona
--comerMenu unMenu unaPersona = map (comer unaPersona) unMenu

--comer :: Persona -> Comida -> Persona -- Problema con los $
--comer unaPersona unaComida = (incorporarNutriente . nutrientesComida $ unaComida) . (incorporarCalorias . caloriasComida $ unaComida) $ unaPersona

-- 4)
--altaFiesta :: Evento -> Bool
--altaFiesta unEvento = (all estaSatsifecho) . map (comerMenu . menu $ unEvento) . invitados $ unEvento

estaSatsifecho :: Persona -> Bool
estaSatsifecho unaPersona = estaPipona unaPersona || (length . nutrientes $ unaPersona) >= 5

-- 5)
--colarseEvento :: [Evento] -> Persona -> [Evento]
--colarseEvento listaDeEventos unColado = map (\unEvento -> colarseSegun unEvento unColado) listaDeEventos

--colarseSegun :: Evento -> Evento
--colarseSegun unEvento unColado
--  | altaFiesta unEvento = mapInvitados (: unColado) unEvento
--  | otherwise = id unEvento

{- 6) ¿Se podría determinar si un evento es alta fiesta si tuviese infinitos invitados?
No, ya que la condicion de que sea alta fiesta depende de si TODOS los invitados estan satisfecho,
y altaFiesta estaría evaluando infinitamente la lista de invitados por lo que no respondería nada hasta que la memoria estalle.
-}
