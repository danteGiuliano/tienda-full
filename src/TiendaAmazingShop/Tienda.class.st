"
Clase Main de la Jerarquia.
"
Class {
	#name : #Tienda,
	#superclass : #Object,
	#instVars : [
		'idTienda',
		'colectionClientes',
		'colectionContenidos',
		'coleccionSuscripciones',
		'coleccionPromos'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #updating }
Tienda class >> crear [ 
|temp|
temp := self new.
temp initializeCollection.
^temp.

]

{ #category : #updating }
Tienda class >> crearWithSQL [ 
|temp  suscripciones contenidos promociones|
temp := self new.
temp initializeCollection.
suscripciones :=DataBase getSuscripcion.
promociones :=DataBase getPromociones_Suscripcion.
Control process:20.
contenidos :=DataBase getContenidos.
Control process:30.
contenidos do:[:clientSQL| temp addContenido:(Contenido createWithSQL:clientSQL)].
Control process:40.
suscripciones do:[:clientSQL| temp addSuscription:(Descuento createWithSQL:clientSQL)].
Control process:50.
promociones do:[:clientSQL| temp addPromocion:(Promocion createWithSQL: clientSQL)].
Control process:69.
^temp.

]

{ #category : #updating }
Tienda class >> createClients:aCollectionClients createSuscriptions:aCollectionSubs aId:aIdirectoty [
|temp|
temp :=self new.
temp initializeClients:aCollectionClients initializeSuscriptions:aCollectionSubs  aId:aIdirectoty.
^temp.
]

{ #category : #'as yet unclassified' }
Tienda class >> createTienta:aIdTienda [
|temp|
temp :=self new.
temp initialize:aIdTienda.
^temp.
]

{ #category : #'as yet unclassified' }
Tienda >> actualizarCliente:unCliente [
|i size flag|
i:=1.
size :=colectionClientes size.
flag :=true.
[(i < size)&flag]whileTrue:[
	((colectionClientes at:i)getDni) = unCliente getDni  ifTrue:[
		colectionClientes at:i put:unCliente.
		flag:=false.
		].
	i:=i+1.	
	]
]

{ #category : #'as yet unclassified' }
Tienda >> addClient:aClient [ 
colectionClientes add:aClient.
]

{ #category : #'as yet unclassified' }
Tienda >> addCliente:aCliente [
colectionClientes add:aCliente.
]

{ #category : #'as yet unclassified' }
Tienda >> addContenido:unContenido [
colectionContenidos add:unContenido.
]

{ #category : #'as yet unclassified' }
Tienda >> addPromocion:unaPromocion [
coleccionPromos add:unaPromocion.
]

{ #category : #'as yet unclassified' }
Tienda >> addSuscription:aSuscription [
coleccionSuscripciones add:aSuscription.
]

{ #category : #'as yet unclassified' }
Tienda >> aplicarPromociones [
colectionClientes do:[:cliente| coleccionPromos do:[:unaPromocion|
		(cliente promocionValida:unaPromocion getCantidadArticulos )ifTrue:[
			cliente añadirPromocion:unaPromocion.
			].
		]].
]

{ #category : #'as yet unclassified' }
Tienda >> añadirSuscripcionComprada:unaSuscripcion aCliente:unCliente [
|flag i max|
i :=1.
flag :=true.
max :=colectionClientes size.
[i <= max & flag] whileTrue:[
		(colectionClientes at:i)=unCliente
		ifTrue:[
			unCliente compraSuscripcion:unaSuscripcion.
			colectionClientes at:i put:unCliente.
			flag:=false.
			].
	i:=i+1.
	]
]

{ #category : #'as yet unclassified' }
Tienda >> comprarSuscripcionDescuento:promo enCliente:unCliente [
|suscripcion precio sub nombre aux|
nombre :=promo getNuevaSuscripcion.
suscripcion := coleccionSuscripciones detect:[:h| h equals: nombre ].
aux :=suscripcion getPrecio asNumber.
precio := aux - ((aux * (promo getDescuentoPromocion asNumber))/100 ).

sub :=SuscripcionComprada crearSuscripcion:suscripcion  deNombre:nombre  yPrecio: precio.
self añadirSuscripcionComprada:sub aCliente:unCliente. 

"DataBase"
DataBase registerSuscripcion_Comprada: { nombre. (unCliente getDni)asString. precio asString}
]

{ #category : #'as yet unclassified' }
Tienda >> crearWithSQL [
| clientes  |"Este metodo se encarga de updatear clientes, puesto que debe existir la instancia previamente"
clientes :=DataBase getClients.
Control process:60.
clientes do:[:clientSQL|self addClient:(Cliente createWithSQL:clientSQL)].
Control process:70.
]

{ #category : #'as yet unclassified' }
Tienda >> getClients [
^colectionClientes.
]

{ #category : #'as yet unclassified' }
Tienda >> getComprasContenido:keyNameContenido [
|contenido clientes |
contenido :=self searchContenido:keyNameContenido.
clientes:=colectionClientes select:[:unCliente| unCliente poseeContenido:contenido].
^clientes.

]

{ #category : #'as yet unclassified' }
Tienda >> getContenidos [
^colectionContenidos.
]

{ #category : #'as yet unclassified' }
Tienda >> getIDTienda [
^idTienda.
]

{ #category : #'as yet unclassified' }
Tienda >> getPromociones [
^coleccionPromos.
]

{ #category : #'as yet unclassified' }
Tienda >> getSuscripciones [
^coleccionSuscripciones.
]

{ #category : #'as yet unclassified' }
Tienda >> getSuscripciones_Compradas:aDni [
^colectionClientes detect:[:cliente|cliente equals:aDni]ifNone:[nil]

]

{ #category : #'as yet unclassified' }
Tienda >> initialize:aIdTienda [
idTienda :=aIdTienda. 
self initializeCollection.
]

{ #category : #'as yet unclassified' }
Tienda >> initializeClients:aClients initializeSuscriptions:aSubs aId:aDirectory [
colectionClientes :=aClients.
coleccionSuscripciones :=aSubs.
idTienda :=aDirectory.
]

{ #category : #'as yet unclassified' }
Tienda >> initializeCollection [
colectionClientes :=OrderedCollection new.
colectionContenidos :=OrderedCollection new.
coleccionSuscripciones :=OrderedCollection new.
coleccionPromos :=OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Tienda >> searchContenido:unNombre [
^colectionContenidos  detect:[:contenido|contenido seCompro:unNombre]ifNone:[nil].

]

{ #category : #'as yet unclassified' }
Tienda >> searchDNI:unDni [
^colectionClientes detect:[:cliente|cliente equals:unDni]ifNone:[nil].

]

{ #category : #'as yet unclassified' }
Tienda >> tienePromocion:unCliente [
| suscripcionActiva|
suscripcionActiva :=unCliente getSuscripcionActiva.
^coleccionPromos select:[:promo| suscripcionActiva promocionAplicable:(promo getCantidadArticulos)]
]
