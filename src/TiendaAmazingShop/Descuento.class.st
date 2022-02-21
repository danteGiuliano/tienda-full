Class {
	#name : #Descuento,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'diccionarioDescuento',
		'nombre',
		'precio'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Descuento class >> conDescuentos:aDiccionary deNombre:unNombre yPrecio:unPrecio [
|temp|
temp :=self new.
temp iniciarConDescuentos:aDiccionary deNombre:unNombre yPrecio:unPrecio.
^temp.
]

{ #category : #'as yet unclassified' }
Descuento class >> createWithSQL:aMySQL [
|aDiccionary nombre temp query|
temp :=self new.
query :=aMySQL columns.
nombre :=query at:1.
aDiccionary := Dictionary newFrom:{'Aplicacion'-> (query at:2). 'Pelicula' -> (query at:3).'Libro'->(query at:4)}.
temp iniciarConDescuentos: aDiccionary  deNombre:nombre yPrecio:(query at:6). 
^temp.
]

{ #category : #gettersVisual }
Descuento >> aplicacionRow: rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getAplication asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Descuento >> cellColumn: column row:rowIndex [
column id = 'Nombre' ifTrue: [ ^self nombreRow: rowIndex].
column id= 'Descuento Libro' ifTrue: [ ^self libroRow:rowIndex ].
column id= 'Descuento Aplicacion' ifTrue: [ ^self aplicacionRow:rowIndex ].
column id= 'Descuento Pelicula' ifTrue: [ ^self peliculaRow:rowIndex ].
column id= 'Precio' ifTrue: [ ^self precioRow:rowIndex ].


]

{ #category : #comparing }
Descuento >> equals:aName [
^nombre ==aName.
]

{ #category : #gettersVisual }
Descuento >> fechaIncioRow:rowIndex [ 
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getFechaInicio asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Descuento >> getAplication [
^(diccionarioDescuento at:'Aplicacion')asString,' %'.
]

{ #category : #gettersVisual }
Descuento >> getLibro [
^(diccionarioDescuento at:'Libro')asString,' %'
]

{ #category : #gettersVisual }
Descuento >> getNombre [
^nombre asString
]

{ #category : #gettersVisual }
Descuento >> getPelicula [
^(diccionarioDescuento at:'Pelicula')asString,' %'
]

{ #category : #gettersVisual }
Descuento >> getPrecio [ 
^precio asString.
]

{ #category : #'as yet unclassified' }
Descuento >> iniciarConDescuentos:aDiccionary deNombre:unNombre yPrecio:unPrecio [
nombre:=unNombre.
diccionarioDescuento :=aDiccionary.
precio:=unPrecio .
]

{ #category : #gettersVisual }
Descuento >> libroRow:rowIndex [ 
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getLibro asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Descuento >> newDataSourceMatching: aFTFilter [
	| newElements |
	newElements := Array withAll: (elements select: [ :each | 
		aFTFilter matches: (self toString: each) ]).
	^ self class new elements: newElements.
]

{ #category : #gettersVisual }
Descuento >> nombreRow: rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getNombre asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Descuento >> obtenerDescuento:selecion [
^diccionarioDescuento at:selecion.
]

{ #category : #gettersVisual }
Descuento >> peliculaRow: rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getPelicula asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Descuento >> precioRow: rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getPrecio asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Descuento >> toString:aSuscription [
^aSuscription getNombre.
]
