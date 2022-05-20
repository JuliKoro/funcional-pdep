type Titulo = String -- alias de tipos
type Autor = String 
type Paginas = Int

data Libro = UnLibro { -- Data (crear un tipo de dato)
  autor :: String, -- record sintax (reemplaza los accesors)
  titulo :: String,
  paginas :: Int
} deriving (Show, Eq) -- le doy pertenencia a los Type Class que quiero

-- elVisitante :: Libro -- es lo mismo que hacer "elVisitante :: (String, String, Int)"
-- elVisitante = ("Stephen King", "El Visitante", 592) -- definicion de etiquetas

elVisitante :: Libro 
elVisitante = UnLibro "Stephen King" "El Visitante" 592

shingeki1 :: Libro
shingeki1 = UnLibro "Hajime Isayama" "Shingeki no Kyojin 1" 40

shingeki3 :: Libro
shingeki3 = UnLibro "Hajime Isayama" "Shingeki no Kyojin 3" 40

shingeki127 :: Libro
shingeki127 = UnLibro "Hajime Isayama" "Shingeki no Kyojin 127" 40

fundacion :: Libro
fundacion = UnLibro "Isaac Asimov" "Fundación" 230

sandman5 :: Libro
sandman5 = UnLibro "Neil Gaiman" "Sandman 5" 35

sandman10 :: Libro
sandman10 = UnLibro "Neil Gaiman" "Sandman 10" 35

sandman12 :: Libro
sandman12 = UnLibro "Neil Gaiman" "Sandman 12" 35

eragon :: Libro
eragon = UnLibro "Christopher Paolini" "Eragon" 544

eldest :: Libro
eldest = UnLibro "Christopher Paolini" "Eldest" 704

brisignr :: Libro
brisignr = UnLibro "Christopher Paolini" "Brisignr" 700

legado :: Libro
legado = UnLibro "Christopher Paolini" "Legado" 811

type Saga = [Libro]

sagaDeEragon :: Saga
sagaDeEragon = [eragon, eldest, brisignr, legado]

type Biblioteca = [Libro] -- Lista de Libros

miBiblioteca :: Biblioteca 
miBiblioteca = [elVisitante, shingeki1, shingeki3, shingeki127, sandman5, sandman10, sandman12, legado, brisignr, eragon, eldest, fundacion]

promedioDePaginas :: Biblioteca -> Int -- `div`para que sea infija
promedioDePaginas unaBiblioteca = sumatoriaPaginasBiblioteca unaBiblioteca `div` length unaBiblioteca

sumatoriaPaginasBiblioteca :: Biblioteca -> Int
sumatoriaPaginasBiblioteca unaBiblioteca = sum . map paginas $ unaBiblioteca

-- paginas :: Libro -> Int -- Accesor -> retorna solamente un elemento especifico de la terna
-- paginas (_, _, paginas) = paginas
-- al usar "record syntax" en los data no hace falta crear los accesors

lecturaObligatoria :: Libro -> Bool -- Pattern Matching
lecturaObligatoria (UnLibro "Isaac Asimov" "Fundación" 230) = True -- del más específico
lecturaObligatoria (UnLibro "Stephen King" _ _) = True
lecturaObligatoria unLibro = esDeSagaEragon unLibro -- al más genérico

esDeAutor :: String -> Libro -> Bool
esDeAutor unAutor unLibro = autor unLibro == unAutor

esDeSagaEragon :: Libro -> Bool
esDeSagaEragon unLibro = elem unLibro sagaDeEragon

bibliotecaFantasiosa :: Biblioteca -> Bool
bibliotecaFantasiosa unaBiblioteca = any esLibroFantasioso unaBiblioteca

esLibroFantasioso :: Libro -> Bool
esLibroFantasioso unLibro = esDeAutor "Christopher Paolini" unLibro || esDeAutor "Neil Gaiman" unLibro

nombreDeLaBiblioteca :: Biblioteca -> String
nombreDeLaBiblioteca unaBiblioteca = sinVocales . concat . listaDeTitulos $ unaBiblioteca

sinVocales :: String -> String
sinVocales unNombre = filter (not . esVocal) unNombre

esVocal :: Char -> Bool -- Toma caracter por caracter de una lista (String)
esVocal unCaracter = elem unCaracter "aeiouAEIOU"

listaDeTitulos :: Biblioteca -> [String]
listaDeTitulos unaBiblioteca = map titulo unaBiblioteca

bibliotecaLigera :: Biblioteca -> Bool
bibliotecaLigera unaBiblioteca = all esLecturaLigera unaBiblioteca

esLecturaLigera :: Libro -> Bool
esLecturaLigera unLibro = paginas unLibro <= 40

genero :: Libro -> String -- Guardas: Retorna en el tipo de la funcion (¡menos Bool!) en distintos casos
genero unLibro
  | esDeAutor "Stephen King" unLibro = "Terror"
  | esDeAutorJapones unLibro = "Manga"
  | paginas unLibro < 40 = "Comic"

esDeAutorJapones :: Libro -> Bool
esDeAutorJapones unLibro = esDeAutor "Hajime Isayama" unLibro

agregarPaginas :: Libro -> Int -> Libro -- retorna un nuevo libro distinto, no cambia el que le paso
-- agregarPaginas (UnLibro unAutor unTitulo unasPaginas) paginasAAgregar = UnLibro unAutor unTitulo (unasPaginas + paginasAAgregar) -- libro abierto
agregarPaginas unLibro unasPaginas = unLibro { paginas = paginas unLibro + unasPaginas } -- con record syntax

sacarSecuela :: Libro -> Libro
sacarSecuela unLibro = unLibro { titulo = titulo unLibro ++ " 2", paginas = paginas unLibro + 50 }