Class {
	#name : #SuscripcionComprada,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'listaDescuento',
		'fechaInicio',
		'fechaFin',
		'nombreSuscripcion',
		'contenidosComprados',
		'promocion',
		'suscripto'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
SuscripcionComprada class >> crearSuscripcion:unaListaDescuentos [ 
|temp|
temp :=self new.
temp añadirLista:unaListaDescuentos.
temp compraContenidos.
^temp.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada class >> crearSuscripcion:unaListaDescuentos deNombre:unNombre [
|temp|
temp :=self new.
temp añadirLista:unaListaDescuentos.
temp compraContenidos.
temp nombreSuscripcion: unNombre.
^temp.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada class >> crearSuscripcionNoActiva [ 
|temp|
temp :=self new.
temp sinSuscripcionActiva.
temp compraContenidos.
^temp.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada class >> createWithSQL:unaListaDescuentos yFechaInicio:unaFechaInicio yFechaFin:unaFechaFin deNombre:unNombre [
|temp|
temp :=self new.
temp añadirListaMySQL:unaListaDescuentos  yFechaInicio:unaFechaInicio   yFechaFIN:unaFechaFin   deNombre: unNombre.
^temp.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada class >> createWithSQL:unaListaDescuentos yFechaInicio:unaFechaInicio yFechaFin:unaFechaFin deNombre:unNombre
contenidosComprados:cantidad [
|temp|
temp :=self new.
temp añadirListaMySQL:unaListaDescuentos  yFechaInicio:unaFechaInicio   yFechaFIN:unaFechaFin   deNombre: unNombre contenidosComprados:cantidad.
^temp.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> añadirLista:unaLista [
listaDescuento :=unaLista.
fechaInicio :=Date today yyyymmdd.
fechaFin :=Date today onNextMonth  yyyymmdd.
suscripto :=true.

]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> añadirListaMySQL:unaLista yFechaInicio:unaFechaInicio yFechaFIN:unaFechaFin deNombre:unNombre contenidosComprados:cantidad [
listaDescuento :=unaLista.
fechaInicio :=unaFechaInicio.
fechaFin :=unaFechaFin.
nombreSuscripcion :=unNombre.
contenidosComprados :=cantidad.
suscripto :=true.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> añadirPromocion:unaPromocion [
promocion :=unaPromocion.
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> calcularDescuento:unId [
^listaDescuento at:unId.
]

{ #category : #dataTable }
SuscripcionComprada >> cellColumn: column row:rowIndex [
column id = 'Tipo' ifTrue: [ ^ self tipoRow: rowIndex ].
column id= 'Inicio' ifTrue: [ ^self inicioRow:rowIndex ].
column id= 'Vence' ifTrue: [ ^self vencimientoRow:rowIndex ].
]

{ #category : #dataTable }
SuscripcionComprada >> compraContenidos [
contenidosComprados :=0.
]

{ #category : #dataTable }
SuscripcionComprada >> contenidoComprado [
contenidosComprados :=contenidosComprados +1.
]

{ #category : #dataTable }
SuscripcionComprada >> descuento [
promocion ifNil:[
	^1 asNumber .
	  ]ifNotNil:[
	promocion descuento asNumber.
	]
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> getFechaInicio [
^fechaInicio .
]

{ #category : #dataTable }
SuscripcionComprada >> getInicio [
^fechaInicio asString.
]

{ #category : #dataTable }
SuscripcionComprada >> getTipo [
^nombreSuscripcion asString.
]

{ #category : #dataTable }
SuscripcionComprada >> getVencimiento [
^fechaFin .
]

{ #category : #dataTable }
SuscripcionComprada >> inicioRow:rowIndex [
^ FTCellMorph new  
		addMorphBack:((self elementAt: rowIndex) getInicio asStringMorph color:(Color green));
		yourself
]

{ #category : #dataTable }
SuscripcionComprada >> keyValue [
^nombreSuscripcion
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> mayor:aFecha [
^fechaInicio >(aFecha getFechaInicio)asDate.
]

{ #category : #dataTable }
SuscripcionComprada >> newDataSourceMatching: aFTFilter [
	| newElements |
	newElements := Array withAll: (elements select: [ :each | 
		aFTFilter matches: (self toString: each) ]).
	^ self class new elements: newElements.
]

{ #category : #accessing }
SuscripcionComprada >> nombreSuscripcion:unNombre [
nombreSuscripcion :=unNombre
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> promocionAplicable:unaCantidad [
^(contenidosComprados >= unaCantidad ).

]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> sinSuscripcion [
^(suscripto not).
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> sinSuscripcionActiva [
suscripto :=false.
nombreSuscripcion :='Sin Suscripcion'.
fechaInicio:=Date today.
fechaFin:='Usuario sin suscripcion'.
contenidosComprados :=OrderedCollection new.
listaDescuento :={'Aplicacion'->0.'Libro'->0.'Pelicula'->0.}.
]

{ #category : #dataTable }
SuscripcionComprada >> tipoRow: rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getTipo asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> toString:aSuscription [
^aSuscription getTipo.
]

{ #category : #dataTable }
SuscripcionComprada >> vencimientoRow:rowIndex [ 
^ FTCellMorph new  
		addMorphBack: ((self elementAt: rowIndex) getVencimiento asStringMorph color:(Color red));
		yourself
]

{ #category : #'as yet unclassified' }
SuscripcionComprada >> vigente [
^fechaFin >= Date today.
]
