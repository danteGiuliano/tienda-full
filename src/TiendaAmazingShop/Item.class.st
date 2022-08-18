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
