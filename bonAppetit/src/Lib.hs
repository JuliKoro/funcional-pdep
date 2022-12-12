import Text.Show.Functions ()
-- 1)
-- a) Modelados y Alias de Tipos
data Persona = UnaPersona {
  calorias :: Int,
  nutrientes :: [Nutriente]
} deriving Show

data Evento = UnEvento { -- Punto 3)
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

julian :: Persona -- ejemplo colado
julian = UnaPersona {
  calorias = 10,
  nutrientes = []
}

casamientoMirtaYJose :: Evento -- Ejemplo Evento (alta fiesta)
casamientoMirtaYJose = UnEvento {
  nombre = "Casamiento de Mirta y José",
  menu = [tomate, zanahoria, (carne 200), panBlanco, panIntegral, panDePapa, hamburguesaCheta],
  invitados = [sofia]
}

fiestaDeEgresados :: Evento -- Ejemplo Evento (no alta fiesta)
fiestaDeEgresados = UnEvento {
  nombre = "Fiesta de Egresados",
  menu = [],
  invitados = [sofia]
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

-- 3) Menúes
menuSofia :: Menu
menuSofia = [panIntegral, zanahoria, hamburguesaCheta]

comerMenu :: Menu -> Persona -> Persona
comerMenu unMenu unaPersona = foldr ($) unaPersona unMenu

-- 4)
altaFiesta :: Evento -> Bool
altaFiesta unEvento = all estaSatisfecho . map (comerMenu . menu $ unEvento) . invitados $ unEvento

estaSatisfecho :: Persona -> Bool
estaSatisfecho unInvitado = estaPipona unInvitado || (length . nutrientes $ unInvitado) >= 5

-- 5)
colarseAEventos :: Persona -> [Evento] -> [Evento]
--colarseAEventos unColado = map (\unEvento -> colarseVIP unColado unEvento)
colarseAEventos _ [] = []
colarseAEventos unColado (x:xs) = (colarseVIP unColado x) : (colarseAEventos unColado xs)

colarseVIP :: Persona -> Evento -> Evento
colarseVIP unColado unEvento
  | altaFiesta unEvento = mapInvitados (++ [unColado]) unEvento
  | otherwise = unEvento

{- 6) ¿Se podría determinar si un evento es alta fiesta si tuviese infinitos invitados?
 No se puede saber si un evento es altaFiesta si todos los invitados quedarían satisfechos, ya que
estaría evaluando infinitamente la lista de invitados.
 Pero si alguno de ellos queda insatisfecho (no estaSatisfecho), la evaluación termina y responde False,
esto debido a que Haskell emplea Lazy Evaluation y no necesita tener generada la lista infinita.
-}
