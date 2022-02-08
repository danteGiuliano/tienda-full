Class {
	#name : #Promocion,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'suscripcionBase',
		'descuento',
		'fechaInicio',
		'fechaFin',
		'cantidad',
		'nuevaSuscripcion'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Promocion class >> crearPromoDescuento:unDescuento fechaInicio:unaFechaInicio fechaFin:unaFechaFin deCantidad:unaCantidad yNuevaSuscripcion:nuevaSuscripcion deSuscripcionBase:unaSuscripcionBase [
^self new crearPromoDescuento:unDescuento fechaInicio:unaFechaInicio fechaFin:unaFechaFin deCantidad:unaCantidad yNuevaSuscripcion:nuevaSuscripcion deSuscripcionBase:unaSuscripcionBase
]

{ #category : #initialization }
Promocion class >> createWithSQL:aMySQLQuery [
|nombre_suscripcion nombre_nueva_suscripcion cantidad_articulos descuento_promocion
 fecha_inicio fecha_fin temp|
temp :=aMySQLQuery columns.
nombre_suscripcion :=temp at:1.
nombre_nueva_suscripcion :=temp at:2.
cantidad_articulos :=temp at:3.
descuento_promocion :=temp at:4.
fecha_inicio :=(temp at:7)asDate.
fecha_fin :=(temp at:8)asDate.
^self crearPromoDescuento: descuento_promocion  fechaInicio:fecha_inicio   fechaFin:fecha_fin   deCantidad:cantidad_articulos   yNuevaSuscripcion:nombre_nueva_suscripcion   deSuscripcionBase: 
nombre_suscripcion.
]

{ #category : #'as yet unclassified' }
Promocion >> CantidadArticulos:rowIndex [ 
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getCantidadArticulos asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Promocion >> DescuentoPromocion:rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getDescuentoPromocion asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Promocion >> NuevaSuscripcion:rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getNuevaSuscripcion asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Promocion >> SuscripcionRow: rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getSuscripcion asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Promocion >> cellColumn: column row:rowIndex [
column id = 'Suscripcion' ifTrue: [ ^self SuscripcionRow: rowIndex].
column id= 'Cantidad Articulos' ifTrue: [ ^self CantidadArticulos:rowIndex ].
column id= 'Nueva suscripcion' ifTrue: [ ^self NuevaSuscripcion:rowIndex ].
column id= 'Descuento Promocion' ifTrue: [ ^self DescuentoPromocion:rowIndex ].
column id= 'meses' ifTrue: [ ^self meses:rowIndex ].
]

{ #category : #'as yet unclassified' }
Promocion >> crearPromoDescuento:unDescuento fechaInicio:unaFechaInicio fechaFin:unaFechaFin deCantidad:unaCantidad yNuevaSuscripcion:unaNuevaSuscripcion deSuscripcionBase:unaSuscripcionBase [
descuento :=unDescuento.
fechaInicio:=unaFechaInicio.
fechaFin :=unaFechaFin.
cantidad :=unaCantidad.
nuevaSuscripcion :=unaNuevaSuscripcion.
suscripcionBase :=unaSuscripcionBase.
]

{ #category : #'as yet unclassified' }
Promocion >> getCantidadArticulos [
^cantidad asNumber
]

{ #category : #'as yet unclassified' }
Promocion >> getDescuentoPromocion [
^descuento asString
]

{ #category : #'as yet unclassified' }
Promocion >> getFechaFin [
^fechaFin.
]

{ #category : #'as yet unclassified' }
Promocion >> getFechaInicio [
^fechaInicio.
]

{ #category : #'as yet unclassified' }
Promocion >> getMeses [
|count fechaAuxInicio fechaAuxFin|
count:=0.
fechaAuxInicio :=fechaInicio asDate.
fechaAuxFin :=fechaFin asDate.
[(fechaAuxInicio < fechaAuxFin)] whileTrue:[fechaAuxInicio:=fechaAuxInicio addMonths:1.count:=count+1.].
^count asString.
]

{ #category : #'as yet unclassified' }
Promocion >> getNuevaSuscripcion [
^nuevaSuscripcion asString
]

{ #category : #'as yet unclassified' }
Promocion >> getSuscripcion [
^suscripcionBase asString
]

{ #category : #'as yet unclassified' }
Promocion >> meses:rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getMeses asStringMorph;
		yourself
]