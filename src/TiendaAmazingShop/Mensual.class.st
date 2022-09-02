Class {
	#name : #Mensual,
	#superclass : #Suscripcion,
	#instVars : [
		'contenidosComprados',
		'descuento',
		'precio'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Mensual class >> crearSuscripcion:unaListaDescuentos deNombre:unNombre [
|temp|
temp :=self new.
temp añadirDescuento:unaListaDescuentos.
temp precio:unaListaDescuentos getPrecio.
temp nombreSuscripcion: unNombre.
^temp.
]

{ #category : #'as yet unclassified' }
Mensual class >> createWithSQL:unaListaDescuentos yFechaInicio:unaFechaInicio yFechaFin:unaFechaFin deNombre:unNombre
contenidosComprados:cantidad yPrecio:unPrecio [
|temp|
temp :=self new.
temp añadirListaMySQL:unaListaDescuentos  yFechaInicio:unaFechaInicio   yFechaFIN:unaFechaFin   deNombre: unNombre contenidosComprados:cantidad yPrecio:unPrecio.
^temp.
]

{ #category : #'as yet unclassified' }
Mensual >> añadirDescuento:unDescuento [
descuento :=unDescuento.

]

{ #category : #'as yet unclassified' }
Mensual >> añadirListaMySQL:unaLista yFechaInicio:unaFechaInicio yFechaFIN:unaFechaFin deNombre:unNombre contenidosComprados:cantidad yPrecio:unPrecio [.
super añadirListaMySQL:unaLista yFechaInicio:unaFechaInicio yFechaFIN:unaFechaFin deNombre:unNombre contenidosComprados:cantidad yPrecio:unPrecio.
descuento :=unaLista.
precio :=unPrecio.
contenidosComprados :=cantidad.
]

{ #category : #'as yet unclassified' }
Mensual >> añadirPago:unPago [
super añadirPago: unPago.
contenidosComprados :=contenidosComprados +1
]

{ #category : #'as yet unclassified' }
Mensual >> calcularPrecio:unContenido [
|categoria  unPrecio unDescuento|
categoria :=unContenido  getIDCategoria.
unPrecio :=unContenido precio.
categoria = 'Pelicula' ifTrue:[
	unPrecio :=0.
	]ifFalse:[
	unDescuento :=descuento obtenerDescuento:categoria.
	unPrecio:=unPrecio*((100-unDescuento)/100)
	].

^unPrecio

]

{ #category : #'as yet unclassified' }
Mensual >> compraContenidos [ 
contenidosComprados :=0.
]

{ #category : #gettersVisual }
Mensual >> getPrecio [
^precio asString
]

{ #category : #'as yet unclassified' }
Mensual >> initialize [ 
super initialize.
self compraContenidos.
fechaInicio :=Date today.
fechaFin :=Date today addMonths:1
]

{ #category : #'as yet unclassified' }
Mensual >> precio:unPrecio [
precio :=unPrecio
]

{ #category : #'as yet unclassified' }
Mensual >> promocionAplicable:unaCantidad [
^contenidosComprados >=unaCantidad.
]
