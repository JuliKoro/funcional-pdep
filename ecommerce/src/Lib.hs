{-
take :: Int -> [a] -> [a]
drop :: Int -> [a] -> [a]
head :: [a] -> a
elem :: Eq a => a -> [a] -> Bool
reverse :: [a] -> [a]
-}

productoDeLujo :: Num a => (String, a) -> Bool
productoDeLujo (nombre, _) = elem 'x' nombre || elem 'z' nombre

productoCodiciado :: Num a => (String, a) -> Bool
productoCodiciado (nombre, _) = length nombre >= 10

esVocal :: Char -> Bool
esVocal unaLetra = elem unaLetra "aeiouAEIOU"

productoCorriente :: Num a => (String, a) -> Bool
productoCorriente (nombre, _) = esVocal . head $ nombre

productoDeElite :: Num a => (String, a) -> Bool
productoDeElite (nombre, _) = productoDeLujo nombre && productoCodiciado nombre && (not . productoCorriente) nombre

descodiciarProducto :: Num a => (String, a) -> String
descodiciarProducto (nombre, _) = take ((length nombre) - 10) nombre

productoXL :: Num a => (String, a) -> String
productoXL (nombre, _) = nombre ++ "XL"

versionBarata :: Num a => (String, a) -> String
versionBarata (nombre, _) = reverse . descodiciarProducto nombre $ nombre

aplicarDescuento :: Num a => (String, a) -> a -> a
aplicarDescuento (_, precio) descuento = 
    (fst producto, precio - precio * (descuento / 100))

aplicarCostoDeEnvio :: Num a => (String, a) -> a -> a
aplicarCostoDeEnvio (_, precio) costoDeEnvio = aplicarDescuento (precio) + costoDeEnvio

precioTotal :: Num a => (String, a) -> Int -> a -> a -> a 
precioTotal (_, precio) cantidad descuento costoDeEnvio = 
    aplicarCostoDeEnvio . (aplicarDescuento . precio) $ precio

entregaSencilla :: String -> Bool
entregaSencilla diaDeEntrega = even . length $ diaDeEntrega

