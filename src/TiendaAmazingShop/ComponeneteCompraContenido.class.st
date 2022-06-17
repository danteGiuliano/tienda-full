"
self call openInHand
"
Class {
	#name : #ComponeneteCompraContenido,
	#superclass : #BorderedMorph,
	#instVars : [
		'text',
		'inputDNi',
		'inputContenido',
		'search',
		'comprar',
		'cliente',
		'contenido'
	],
	#category : #'TiendaAmazingShop-components tienda'
}

{ #category : #'ffi-calls' }
ComponeneteCompraContenido class >> call [
	^ (self new)openInWorld
]

{ #category : #initialization }
ComponeneteCompraContenido >> defineMorph [
self extent:300@350.
text:=RubScrolledTextMorph new extent:290@220.
inputContenido :=TextBox create:'nombre contenido' size:200@30.
inputDNi :=TextBox create:'DNI usuario' size:200@30.
search :=Button create:'BUSCAR' size:70@30.
comprar :=Button create: 'COMPRAR' size:70@40.

self addMorph:text;addMorph:comprar;addMorph:inputContenido ;addMorph:search;addMorph:inputDNi.
]

{ #category : #initialization }
ComponeneteCompraContenido >> initialize [ 
super initialize. 
self defineMorph.
self style.
self logic. 
]

{ #category : #initialization }
ComponeneteCompraContenido >> logic [
	|valido|
	valido :=false.
	search
		mouseAction: [ cliente := Control
				modelFuntionReturn: [ :h | h searchDNI: inputDNi text asString ].
			contenido := Control
				modelFuntionReturn: [ :h | h searchContenido: inputContenido text asString ].
			cliente isNotNil & contenido isNotNil
				ifTrue: [ | data precio |
					data := 'INFORMACION DE CLIENTE ----- \' withCRs.
					data := data , cliente getData.
					data := (data , '\ \ INFORMACION DE CONTENIDO-----  \') withCRs.
					data := data , contenido getData.
					precio:=(cliente obtenerPrecioContenido:contenido).
					data := data, ' PRECIO DESCUENTO: ', (precio asString).
					text setText: data .
					(precio == -1) ifFalse:[valido:=true].
					] ].
	comprar
		mouseAction: [ cliente isNotNil & contenido isNotNil & valido
				 ifTrue: [ DataBase registerCompra_contenido: contenido paraCliente: cliente.
					cliente compraContenido: contenido.
					Control modelFuntion:[:h| h actualizarCliente: cliente].
					text setText:''.
					text setText: 'COMPRA CON EXITO ...' ] ifFalse:[text setText:'compra invalida'] ]
]

{ #category : #initialization }
ComponeneteCompraContenido >> style [ 
"position"
inputDNi top: self top+15.
inputDNi left:self left+15.
inputContenido top:inputDNi bottom+5.
inputContenido left:inputDNi left.
search left:inputDNi right +10.
search top: inputDNi  top+10.
text center:self center.
text top:inputContenido bottom+10.
comprar center:self center.
comprar bottom:self bottom-10.
"Style"
text color:Theme morphContrast.
self color:Theme morph.
Helper border:search  aColor:(search color).
Helper border:comprar  aColor:(comprar color ).
Helper border: self aColor: self color.
Helper border: text aColor: text color.
]
