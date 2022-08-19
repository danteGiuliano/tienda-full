Class {
	#name : #Item,
	#superclass : #Suscripcion,
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Item >> calcularDescuento:unContenido [
|categoria  unPrecio |
unPrecio :=-1.
categoria :=unContenido  getIDCategoria.
(categoria=='Juego') |(categoria== 'Pelicula') ifFalse:[
unPrecio :=unContenido precio.
].
^unPrecio.
]

{ #category : #'as yet unclassified' }
Item >> existeContenido:unContenido [
^coleccionPagos detect:[:unPago|unPago equals:unContenido name]ifNone:[nil]
]
