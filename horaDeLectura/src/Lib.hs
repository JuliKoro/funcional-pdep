type Titulo = String -- alias de tipos
type Autor = String 
type Paginas = Int

type Libro = (Titulo, Autor, Paginas) 

elVisitante :: Libro -- es lo mismo que hacer "elVisitante :: (String, String, Int)"
elVisitante = ("Stephen King", "El Visitante", 592) -- definicion de etiquetas

shingeki1 :: Libro
shingeki1   = ("Hajime Isayama", "Shingeki no Kyojin 1",   40)

shingeki3 :: Libro
shingeki3   = ("Hajime Isayama", "Shingeki no Kyojin 3",   40)

shingeki127 :: Libro
shingeki127 = ("Hajime Isayama", "Shingeki no Kyojin 127", 40)

fundacion :: Libro
fundacion = ("Isaac Asimov", "Fundación", 230)

sandman5 :: Libro
sandman5 = ("Neil Gaiman", "Sandman 5", 35)

sandman10 :: Libro
sandman10 = ("Neil Gaiman", "Sandman 10", 35)

sandman12 :: Libro
sandman12 = ("Neil Gaiman", "Sandman 12", 35)

eragon :: Libro
eragon = ("Christopher Paolini", "Eragon", 544)

eldest :: Libro
eldest = ("Christopher Paolini", "Eldest", 704)

brisignr :: Libro
brisignr = ("Christopher Paolini", "Brisignr", 700)

legado :: Libro
legado = ("Christopher Paolini", "Legado", 811)

type Biblioteca = [Libro] -- Lista de Libros

miBiblioteca :: Biblioteca 
miBiblioteca = [elVisitante, shingeki1, shingeki3, shingeki127, sandman5, sandman10, sandman12, legado, brisignr, eragon, eldest, fundacion]

promedioDePaginas :: Biblioteca -> Int -- `div`para que sea infija
promedioDePaginas unaBiblioteca = sumatoriaPaginasBiblioteca unaBiblioteca `div` length unaBiblioteca

sumatoriaPaginasBiblioteca :: Biblioteca -> Int
sumatoriaPaginasBiblioteca unaBiblioteca = sum . map paginas $ unaBiblioteca

paginas :: Libro -> Int -- Accesor -> retorna solamente un elemento especifico de la terna
paginas (_, _, paginas) = paginas

lecturaObligatoria :: Libro -> Bool
lecturaObligatoria unLibro = esDeAutor "Stephen King" unLibro || esDeSagaEragon unLibro || unLibro == fundacion

esDeAutor :: String -> Libro -> Bool
esDeAutor unAutor unLibro = autor unLibro == unAutor

autor :: Libro -> String
autor (unAutor, _, _) = unAutor

esDeSagaEragon :: Libro -> Bool
esDeSagaEragon unLibro = elem (titulo unLibro) ["Eragon", "Eldest", "Legado", "Brisignr"]

titulo :: Libro -> String
titulo (_, unTitulo, _) = unTitulo

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