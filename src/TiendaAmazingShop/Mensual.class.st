Class {
	#name : #Mensual,
	#superclass : #Suscripcion,
	#instVars : [
		'contenidosComprados',
		'descuento'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Mensual >> calcularDescuento:unContenido [
|categoria  unPrecio unDescuento|
unPrecio :=-1.
categoria :=unContenido  getIDCategoria.
categoria == 'Pelicula' ifFalse:[
unPrecio :=unContenido precio.
unDescuento :=descuento obtenerDescuento:categoria.	
unPrecio := unPrecio*((unDescuento - 100)/100)
].
^unPrecio.

]

{ #category : #'as yet unclassified' }
Mensual >> calcularPrecioDescuento:unContenido [
|categoria  unPrecio unDescuento|
categoria :=unContenido  getIDCategoria.
unPrecio :=unContenido precio.
unDescuento :=descuento obtenerDescuento:categoria.
^unPrecio*((unDescuento - 100)/100)

]

{ #category : #'as yet unclassified' }
Mensual >> compraContenidos [ 
contenidosComprados :=0.
]

{ #category : #'as yet unclassified' }
Mensual >> contenidoComprado [
contenidosComprados := contenidosComprados +1
]

{ #category : #'as yet unclassified' }
Mensual >> initialize [ 
super initialize.
self compraContenidos.
]
