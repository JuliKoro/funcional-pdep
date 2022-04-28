{-
take :: Int -> [a] -> [a]
drop :: Int -> [a] -> [a]
head :: [a] -> a
elem :: Eq a => a -> [a] -> Bool
reverse :: [a] -> [a]
-}


precioTotal :: Float -> Float -> Float -> Float -> Float
precioTotal precioUnitario cantidad descuento costoDeEnvio = aplicarCostoDeEnvio (aplicarDescuento precioUnitario descuento * cantidad) costoDeEnvio

productoDeElite :: String -> Bool
productoDeElite nombreDeProducto = productoDeLujo nombreDeProducto && productoCodiciado nombreDeProducto && (not . productoCorriente) nombreDeProducto

aplicarDescuento :: Float -> Float -> Float
aplicarDescuento unPrecio unDescuento = unPrecio * (1 - unDescuento)

entregaSencilla :: String -> Bool
entregaSencilla unDia = even . length $ unDia

descodiciarProducto :: String -> String
descodiciarProducto nombreDeProducto = take 10 nombreDeProducto

productoDeLujo :: String -> Bool
productoDeLujo nombreDeProducto = elem 'x' nombreDeProducto || elem 'z' nombreDeProducto

aplicarCostoDeEnvio :: Float -> Float -> Float
aplicarCostoDeEnvio unPrecio unCostoDeEnvio = unPrecio + unCostoDeEnvio

productoCodiciado :: String -> Bool
productoCodiciado nombreDeProducto = length nombreDeProducto > 10

productoCorriente :: String -> Bool
productoCorriente nombreDeProducto = esVocal . head $ nombreDeProducto

esVocal :: Char -> Bool
esVocal unaLetra = elem unaLetra "aeiouAEIOU"

productoXL :: String -> String
productoXL nombreDeProducto = nombreDeProducto ++ " XL"

versionBarata :: String -> String
versionBarata nombreDeProducto = reverse . descodiciarProducto $ nombreDeProducto
