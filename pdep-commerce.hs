{- PdeP - commerce
 Tarea Funcional - 04/04
 Alumno: Julián Andrés Koroluk
 -}

{- Funciones que pueden utilizar (y tienen que tipar, las usen o no):  

take :: Ord a => Int -> [a] -> [a]
>> take 2 “Buenas!!”
“Bu”
>> take 5 “Saludos”
“Salud”

drop :: Ord a => Int -> [a] -> [a]
>> drop 2 “Buenas!!”
“enas!!”
>> drop 3 “Saludos”
“udos”
	
head :: Ord a => [a] -> a
>> head “Buenas!!”
‘B’
>> head “Nos vemos”
‘N’

elem :: Eq a => a -> [a] -> Bool
	>> elem ‘a’ “Buenas!!”
	True
	>> elem ‘y’ “Buenas!!”
	False

reverse :: Ord a => [a] -> [a]
	>> reverse “Buenas!!”
	"!!saneuB"
-}

productoDeLujo :: String -> Bool
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




