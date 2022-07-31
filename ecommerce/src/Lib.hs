{- ecommerce - Julián Koroluk

take :: Int -> [a] -> [a]
drop :: Int -> [a] -> [a]
head :: [a] -> a
elem :: Eq a => a -> [a] -> Bool
reverse :: [a] -> [a]
-}
type Producto = (String, Float)

nombreProducto :: Producto -> String
nombreProducto (nombre, _) = nombre

precioProducto :: Producto -> Float
precioProducto (_, precio) = precio

productoDeLujo :: Producto -> Bool
productoDeLujo unProducto = ((elem 'x') . nombreProducto $ unProducto) || ((elem 'z') . nombreProducto $ unProducto)

productoCodiciado :: Producto -> Bool
productoCodiciado unProducto = (length . nombreProducto $ unProducto) > 10

esVocal :: Char -> Bool
esVocal unaLetra = elem unaLetra "aeiouAEIOU"

productoCorriente :: Producto -> Bool
productoCorriente unProducto = esVocal . head . nombreProducto $ unProducto

productoDeElite :: Producto -> Bool
productoDeElite unProducto = productoDeLujo unProducto && productoCodiciado unProducto && (not . productoCorriente) unProducto

descodiciarProducto :: Producto -> String
descodiciarProducto unProducto = (take 10) . nombreProducto $ unProducto

productoXL :: Producto -> String
productoXL unProducto = (nombreProducto unProducto) ++ "XL"

versionBarata :: Producto -> String
versionBarata unProducto = reverse . descodiciarProducto $ unProducto

aplicarDescuento :: Float -> Float -> Float
aplicarDescuento precio descuento = precio - precio * (descuento / 100)

aplicarCostoDeEnvio :: Float -> Float -> Float
aplicarCostoDeEnvio precio costoDeEnvio = precio + costoDeEnvio

precioTotal :: Producto -> Float -> Float -> Float -> Float
precioTotal unProducto cantidad descuento costoDeEnvio =
    aplicarCostoDeEnvio (aplicarDescuento (precioProducto unProducto) descuento * cantidad) costoDeEnvio

entregaSencilla :: String -> Bool
entregaSencilla diaDeEntrega = even . length $ diaDeEntrega
