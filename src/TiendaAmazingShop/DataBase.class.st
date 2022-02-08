Class {
	#name : #DataBase,
	#superclass : #File,
	#instVars : [
		'collectionLogins'
	],
	#classVars : [
		'credentials',
		'database',
		'id_user'
	],
	#category : #'TiendaAmazingShop-services'
}

{ #category : #'querys_up' }
DataBase class >> actualizar_cantidad_productos_compra:unCliente [
|suscripcion nombre l|
suscripcion :=unCliente getSuscripcionActiva.
nombre :='"',suscripcion getTipo,'"'.
l :=database query:'UPDATE Suscripcion_Comprada SET cantidad_productos=cantidad_productos+1 WHERE id_user=',id_user ,' && nombre_suscripcion=',nombre,' && dni_cliente=',(unCliente getDni)asString,' &&
fecha_inicio=','"',suscripcion getFechaInicio,'"'.
l.
]

{ #category : #'as yet unclassified' }
DataBase class >> autenticationName: aName aPassWord: aPassword [
	| query |
	self runDataBase.
	query := database
		query:
			'SELECT * FROM Usuario WHERE  Usuario.usuario="' , aName , '"'
				, ' && Usuario.password="' , aPassword , '"'.
	self desconectar.
	^ query
]

{ #category : #'as yet unclassified' }
DataBase class >> desconectar [
database disconnect.

]

{ #category : #'query_pull' }
DataBase class >> getClients [
|query|
self runDataBase.
query:=(database query:'SELECT * FROM Cliente WHERE Cliente.usuario_name=',id_user)rows.
self desconectar.
^query.
]

{ #category : #'query_pull' }
DataBase class >> getContenidos [
|query|
self runDataBase.
query:=(database query:'SELECT * FROM Contenido WHERE Contenido.id_usuario=',id_user)rows.
self desconectar.
^query.
]

{ #category : #'query_pull' }
DataBase class >> getContenidosComprados:aDni [
|query|
self runDataBase.
query:=database  query:'SELECT * FROM Contenido_Comprado WHERE Contenido_Comprado.cliente_dni=',aDni asString.
self desconectar.
^query.
]

{ #category : #'as yet unclassified' }
DataBase class >> getDataBase [
^database.


]

{ #category : #'query_pull' }
DataBase class >> getPromociones_Suscripcion [
^(self query:'SELECT * FROM Promocion_Suscripcion WHERE id_user=',id_user)rows.
]

{ #category : #'as yet unclassified' }
DataBase class >> getSuscripcion [
|query|
self runDataBase.
query:=(database query:'SELECT * FROM Suscripcion WHERE id_user=',id_user )rows.
self desconectar.
^query.
]

{ #category : #'as yet unclassified' }
DataBase class >> getSuscripciones_Compradas:aDni [
|query|.
self runDataBase.
query:=database query:'SELECT
Suscripcion.nombre_suscripcion,Suscripcion.descuento_aplicacion,Suscripcion.descuento_pelicula,Suscripcion.descuento_libro,
Suscripcion_Comprada.fecha_inicio,Suscripcion_Comprada.fecha_fin,Suscripcion_Comprada.keyValue, Suscripcion_Comprada.cantidad_productos FROM Suscripcion_Comprada INNER JOIN Suscripcion ON Suscripcion.nombre_suscripcion=Suscripcion_Comprada.nombre_suscripcion
WHERE Suscripcion.id_user=',id_user,' AND Suscripcion_Comprada.dni_cliente=',aDni asString .
self desconectar.
^query.
]

{ #category : #'as yet unclassified' }
DataBase class >> initializeCredentials [
credentials :=MySQLDriverSpec new 
				database:'bqjjyahm2odbtd2jyer3';
				host:'bqjjyahm2odbtd2jyer3-mysql.services.clever-cloud.com';
				user:'ucgufhmstam0yv5o';
				password:'I990vhwVaWn9Pcv9vtIF';
				port:3306.


]

{ #category : #'as yet unclassified' }
DataBase class >> query:AStringQuery [
|query|
self runDataBase.
query:=database query:AStringQuery.
self desconectar.
^query.
]

{ #category : #'querys_up' }
DataBase class >> registerClient:aCollection [
|values dni|
dni :=aCollection at:1.
aCollection removeAt:1.
values:=StringReader new formateValue:aCollection.
"aColecction ( dni , nombre , email , usuario_name)"
self runDataBase.
database query:'INSERT INTO Cliente (dni,nombre,email,usuario_name)
VALUES(',dni,',',(StringReader new sliceChar:values pos:1).
self desconectar.

]

{ #category : #'querys_up' }
DataBase class >> registerCompra_contenido: unContenido paraCliente: unCliente [
	| fecha dni nombreContenido nombreSuscripcion |
	dni := unCliente getDni asString.
	nombreContenido := unContenido name.
	fecha := Date today yyyymmdd.
	nombreSuscripcion := unCliente getSuscripcionActiva getTipo.
	self runDataBase.
	database
		query:
			'INSERT INTO Contenido_Comprado (cliente_dni,suscripcion,fecha,nombre_contenido)VALUES('
				, dni , ',"' , nombreSuscripcion , '","' , fecha , '","'
				, nombreContenido , '")'.
				self actualizar_cantidad_productos_compra:unCliente.
		self desconectar
]

{ #category : #'as yet unclassified' }
DataBase class >> registerContenidoNombre:unNombre yPrecio:unPrecio conFecha:unaFecha deCategoria:unaCategoria [
self runDataBase.
database query:'INSERT INTO Contenido (nombre_contenido,precio_contenido,categoria,fecha_inicio,id_usuario) VALUES(
"',unNombre,'",',unPrecio ,',"',unaCategoria,'","',unaFecha ,'",',id_user,')'.
self desconectar.
]

{ #category : #'querys_up' }
DataBase class >> registerPromocion:aPromocion [
|nombreSus nombreNuevaSus canMeses desc fechaActual fechaMaxima canArticulos |
nombreSus :=aPromocion getSuscripcion.
nombreNuevaSus :=aPromocion  getNuevaSuscripcion.
canMeses :=(aPromocion getMeses) asString.
desc :=aPromocion getDescuentoPromocion.
fechaActual :=(aPromocion getFechaInicio ).
fechaMaxima :=(aPromocion getFechaFin ).
canArticulos :=(aPromocion getCantidadArticulos)asString.
self runDataBase.
database query:'INSERT INTO Promocion_Suscripcion (nombre_suscripcion,nombre_nueva_suscripcion,cantidad_articulos,descuento_promocion,cantidad_meses,id_user,fecha_inicio,fecha_fin)VALUES ("',nombreSus,'","',nombreNuevaSus ,'",',canArticulos,',',desc,',',canMeses,',',id_user,',"',fechaActual,'","',fechaMaxima,'")'.
self desconectar.
]

{ #category : #'querys_up' }
DataBase class >> registerShop:aCollection [
|values query|.
values :=StringReader new formateValue:aCollection.
self runDataBase.
query:=database query:'INSERT INTO Usuario (usuario,password,name_shop) VALUES',values.
self desconectar.
^query.
]

{ #category : #running }
DataBase class >> registerSuscripcion_Comprada:aCollection [
|key dni keySub|
key:=aCollection at:1.
dni:=aCollection at:2.
self runDataBase.
keySub :=key,dni,Date today  yyyymmdd,Date today onNextMonth yyyymmdd.
database query:'INSERT INTO Suscripcion_Comprada (nombre_suscripcion,dni_cliente,fecha_inicio,fecha_fin,keyValue,id_user,cantidad_productos) 
VALUES("',key,'",',dni,',"',Date today yyyymmdd ,'","',Date today onNextMonth yyyymmdd,'","',keySub ,'",',id_user,',0)'.
self desconectar.
]

{ #category : #running }
DataBase class >> registerSuscription:aCollection [
|nombre_suscripcion descuentro_aplicacion descuento_libro descuento_pelicula|
self runDataBase.
nombre_suscripcion :=aCollection at:1.
descuento_libro :=(aCollection at:2)asString.
descuento_pelicula :=(aCollection at:3)asString.
descuentro_aplicacion :=(aCollection at:4)asString.
nombre_suscripcion :='"',nombre_suscripcion ,'"'.
database query:'INSERT INTO Suscripcion (nombre_suscripcion,descuento_aplicacion,descuento_pelicula,descuento_libro,id_user) VALUES (',nombre_suscripcion ,',',descuentro_aplicacion ,',',descuento_pelicula ,',',descuento_libro,',',id_user,')'.
self desconectar.
]

{ #category : #'querys_up' }
DataBase class >> registerrPromocion:aPromocion [
|nombreSus nombreNuevaSus canMeses desc fechaActual fechaMaxima canArticulos|
nombreSus :=aPromocion getSuscripcion.
nombreNuevaSus :=aPromocion  getNuevaSuscripcion.
canMeses :=aPromocion getMeses.
desc :=aPromocion getDescuentoPromocion.
fechaActual :=aPromocion getFechaInicio.
fechaMaxima :=aPromocion getFechaFin.
canArticulos :=aPromocion getCantidadArticulos.
self runDataBase.
database query:'INSERT INTO Promocion_Suscripcion (nombre_suscripcion,nombre_nueva_suscripcion,cantidad_articulos,descuento_promocion,cantidad_meses,id_user,fecha_inicio,fecha_fin)VALUES ("',nombreSus,'","',nombreNuevaSus ,'",',canArticulos ,desc,canMeses ,'"',id_user End of statement list encountered ->')'.
self desconectar.
]

{ #category : #'querys_up' }
DataBase class >> registrarPromocion:arrayPromocion [
|nombreSus nombreNuevaSus canMeses Desc fechaActual fechaMaxima|
self runDataBase.
database query:'INSERT INTO Promocion_Suscripcion (nombre_suscripcion,nombre_nueva_suscripcion,cantidad_articulos,descuento_promocion,cantidad_meses,id_user)VALUES ("test","test",4,45,6,"admin")'.
self desconectar.
]

{ #category : #'as yet unclassified' }
DataBase class >> runDataBase [
	self initializeCredentials.
	database := MySQLDriver new.
	database  connect: credentials
]

{ #category : #'as yet unclassified' }
DataBase class >> userKey [
^id_user.


]

{ #category : #'as yet unclassified' }
DataBase class >> userkey:aUser [
aUser notNil ifTrue:[
id_user :='"',aUser,'"'.
	].


]
