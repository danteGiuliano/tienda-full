"
self call openInHand.
"
Class {
	#name : #ComponeneteContenidoBusqueda,
	#superclass : #BorderedMorph,
	#instVars : [
		'table',
		'inputNombre',
		'search',
		'resultado',
		'contenido'
	],
	#category : #'TiendaAmazingShop-components tienda'
}

{ #category : #'ffi-calls' }
ComponeneteContenidoBusqueda class >> call [
|temp|
temp := self new.
temp initialize.
^temp.
]

{ #category : #'ffi-calls' }
ComponeneteContenidoBusqueda class >> call:table [
|temp|
temp := self new.
temp initialize.
temp table:table.
^temp.
]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> addMorphs [
Helper addCenterMorph:inputNombre  in:self.   
Helper addCenterMorph:search  in:self.  
Helper addCenterMorph:resultado in:self. 
Helper addCenterMorph:contenido in:self. 

]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> defineMorph [
self extent: 620@200.

inputNombre :=TextBox create:'Nombre contenido' size:500@30.
search :=Button create:'BUSCAR' size:60@20.
resultado :=StringMorph contents:'Busqueda no realizada.'.
contenido :=BorderedMorph new extent:600@100.
 
]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> initialize [ 
super initialize.
self defineMorph.
self addMorphs.
self style.
self logic.
]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> logic [
search mouseAction:[
	(inputNombre text)asString='' ifFalse:[
		|input contenidoModel |
		input :=(inputNombre text)asString.
		contenidoModel :=Control modelFuntionReturn:[:h| h searchContenido:input.].
		contenidoModel isNotNil ifTrue:[
			resultado contents:'Contenido encontrado...'.
			self updateView:contenidoModel.
			]ifFalse:[
				resultado contents:'Contenido no encontrado ...'.
			].
		]
	]
]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> style [
inputNombre top:self top+20.
inputNombre  left:self left+10.
search top:inputNombre top.
search left:inputNombre right +10.
"Style v2."
inputNombre  borderStyle:(BottomBorder new width:2).
inputNombre  color:(Color transparent).
inputNombre borderColor:(Color black).
inputNombre ghostColor:(Theme ghostText).
contenido color:Theme morphContrast.
self color:Theme morph.

Helper border:search   aColor:Theme buttom rad:2. 
Helper border: self aColor:Theme morph.
Helper border:contenido aColor:Theme morphContrast rad:6. 

contenido bottom:self bottom-15.
resultado center:self center.
resultado bottom:contenido top-10.
resultado font:(StandardFonts codeFont).
]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> subMenu:aTable [
table :=aTable.


]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> table:aTable [
table :=aTable.


]

{ #category : #initialization }
ComponeneteContenidoBusqueda >> updateView:contenidoModel [
|pos|
pos :=contenido center.
contenido delete.
contenido :=ComponenteContenido createComponentModel:contenidoModel.
contenido table:table.
Helper addCenterMorph:contenido in:self. 
Helper border:contenido aColor:Theme morphContrast rad:6. 
contenido color:Theme morphContrast.
contenido center:pos.


]
