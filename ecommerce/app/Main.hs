take :: Ord a => Int -> [a] -> [a]

drop :: Ord a => Int -> [a] -> [a]

head :: [a] -> a

elem :: Eq a => a -> [a] -> Bool

reverse :: [a] -> [a]

productoDeLujo :: Num a => (String a) -> Bool
productoDeLujo producto = (elem 'x' producto) || (elem 'z' producto)

productoCodiciado :: String -> Bool
productoCodiciado producto = (length producto) >= 10

productoCorriente :: String -> Bool
productoCorriente producto = head ['a', 'e', 'i', 'o', 'u'] producto

productoDeElite :: String -> Bool
productoDeElite producto = productoDeLujo producto && productoCodiciado producto && not productoCorriente

descodiciarProducto :: String -> String
descodiciarProducto producto = take ((length producto) - 10) producto

productoXL :: String -> String
productoXL producto = producto ++ "XL"

versionBarata :: String -> String
versionBarata producto = reverse . descodiciarProducto producto $ producto

precioSubTotal :: Num a => precioUnitario * cantidad
precioSubTotal precioUnitario cantidad = precioUnitario * cantidad

aplicarDescuento :: Num a => a -> a -> a
aplicarDescuento precioUnitario descuento = 
    precioSubTotal $ precioUnitario - precioSubTotal $ precioUnitario * (descuento / 100)

aplicarCostoDeEnvio :: Num a => a -> a -> a
aplicarCostoDeEnvio precioUnitario costoDeEnvio = aplicarDescuento (precioUnitario) + costoDeEnvio

precioTotal :: Num a => a -> Int -> a -> a -> a 
precioTotal precioUnitario cantidad descuento costoDeEnvio = 
    aplicarCostoDeEnvio . (aplicarDescuento . precioSubTotal) $ precioUnitario

entregaSencilla :: String -> Bool
entregaSencilla diaDeEntrega = even . length $ diaDeEntrega 