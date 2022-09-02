Class {
	#name : #Item,
	#superclass : #Suscripcion,
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Item >> calcularPrecio:unContenido [
|unPrecio categoria|
unPrecio :=-1.
categoria :=unContenido getIDCategoria.
((categoria ='Pelicula') not) & ((categoria='Juego') not) ifTrue:[unPrecio :=unContenido precio].
^unPrecio.
]
