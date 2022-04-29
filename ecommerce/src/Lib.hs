{- ecommerce
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
productoDeElite (nombre, precio) = productoDeLujo (nombre, precio) && productoCodiciado (nombre, precio) && (not . productoCorriente) (nombre, precio)

descodiciarProducto :: Num a => (String, a) -> String
descodiciarProducto (nombre, _) = take 10 nombre

productoXL :: Num a => (String, a) -> String
productoXL (nombre, _) = nombre ++ "XL"

versionBarata :: Num a => (String, a) -> String
versionBarata (nombre, precio) = reverse . descodiciarProducto $ (nombre, precio)

aplicarDescuento :: Num a => a -> a -> a -- corregir (devuelve negativo)
aplicarDescuento precio descuento = precio - descuento

aplicarCostoDeEnvio :: Num a => a -> a -> a
aplicarCostoDeEnvio precio costoDeEnvio = precio + costoDeEnvio

precioTotal :: Num a => (String, a) -> a -> a -> a -> a
precioTotal (_, precio) cantidad descuento costoDeEnvio = 
    aplicarCostoDeEnvio (aplicarDescuento precio descuento * cantidad) costoDeEnvio

entregaSencilla :: String -> Bool
entregaSencilla diaDeEntrega = even . length $ diaDeEntrega

