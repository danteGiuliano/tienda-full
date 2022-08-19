Class {
	#name : #Suscripcion,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'fechaInicio',
		'fechaFin',
		'nombreSuscripcion',
		'precio',
		'coleccionPagos'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #'as yet unclassified' }
Suscripcion class >> crearSuscripcion:unaListaDescuentos deNombre:unNombre [
|temp|
temp :=self new.
temp añadirLista:unaListaDescuentos.
temp compraContenidos.
temp precio:unaListaDescuentos getPrecio.
temp nombreSuscripcion: unNombre.
^temp.
]

{ #category : #'as yet unclassified' }
Suscripcion class >> crearSuscripcion:unaListaDescuentos deNombre:unNombre yPrecio:unPrecio [
|temp|
temp :=self new.
temp añadirLista:unaListaDescuentos.
temp compraContenidos.
temp precio:unPrecio.
temp nombreSuscripcion: unNombre.
^temp.
]

{ #category : #'as yet unclassified' }
Suscripcion class >> createWithSQL:unaListaDescuentos yFechaInicio:unaFechaInicio yFechaFin:unaFechaFin deNombre:unNombre
contenidosComprados:cantidad yPrecio:unPrecio [
|temp|
temp :=self new.
temp añadirListaMySQL:unaListaDescuentos  yFechaInicio:unaFechaInicio   yFechaFIN:unaFechaFin   deNombre: unNombre contenidosComprados:cantidad yPrecio:unPrecio.
^temp.
]

{ #category : #'as yet unclassified' }
Suscripcion >> añadirListaMySQL:unaLista yFechaInicio:unaFechaInicio yFechaFIN:unaFechaFin deNombre:unNombre contenidosComprados:cantidad yPrecio:unPrecio [.
fechaInicio :=unaFechaInicio.
fechaFin :=unaFechaFin.
nombreSuscripcion :=unNombre.
precio:=unPrecio.
self crearColleciones.
]

{ #category : #dataTable }
Suscripcion >> añadirPago:unPago [
coleccionPagos add:unPago.
]

{ #category : #dataTable }
Suscripcion >> añadirPagoMySQL:aMySQLQuery [
	aMySQLQuery
		do: [ :instanceKey | 
			|  contenido|
			contenido := Control
				modelFuntionReturn: [ :h | h searchContenido: (instanceKey at: 4) ].
				coleccionPagos 
				 add:(Pago createWithMySQL:instanceKey).
				]
]

{ #category : #dataTable }
Suscripcion >> cellColumn: column row:rowIndex [
column id = 'Tipo' ifTrue: [ ^ self tipoRow: rowIndex ].
column id= 'Inicio' ifTrue: [ ^self inicioRow:rowIndex ].
column id= 'Vence' ifTrue: [ ^self vencimientoRow:rowIndex ].
column id= 'Precio' ifTrue: [ ^self precioRow:rowIndex ].
]

{ #category : #'as yet unclassified' }
Suscripcion >> crearColleciones [
coleccionPagos := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Suscripcion >> getFechaInicio [
^fechaInicio .
]

{ #category : #dataTable }
Suscripcion >> getInicio [
^fechaInicio asString.
]

{ #category : #'as yet unclassified' }
Suscripcion >> getPagos [ 
^coleccionPagos.
]

{ #category : #'as yet unclassified' }
Suscripcion >> getPrecio [
^precio asString
]

{ #category : #dataTable }
Suscripcion >> getTipo [
|nombre|
nombre :=nombreSuscripcion.
nombreSuscripcion ifNil:[
	nombre:='Sin suscripcion'.
	].
^nombre.
]

{ #category : #dataTable }
Suscripcion >> getVencimiento [
^fechaFin .
]

{ #category : #dataTable }
Suscripcion >> inicioRow:rowIndex [
^ FTCellMorph new  
		addMorphBack:((self elementAt: rowIndex) getInicio asStringMorph color:(Color green));
		yourself
]

{ #category : #dataTable }
Suscripcion >> keyValue [
^nombreSuscripcion
]

{ #category : #'as yet unclassified' }
Suscripcion >> mayor:aFecha [
^fechaInicio >(aFecha getFechaInicio)asDate.
]

{ #category : #dataTable }
Suscripcion >> newDataSourceMatching: aFTFilter [
	| newElements |
	newElements := Array withAll: (elements select: [ :each | 
		aFTFilter matches: (self toString: each) ]).
	^ self class new elements: newElements.
]

{ #category : #accessing }
Suscripcion >> nombreSuscripcion:unNombre [
nombreSuscripcion :=unNombre
]

{ #category : #'as yet unclassified' }
Suscripcion >> obtenerDataCompra:keyName cliente:nombre [
| pago data|
data :=nil.
pago :=(coleccionPagos select:[:unPago| unPago equals:keyName.]).
pago isNotEmpty ifTrue:[
	pago:=pago at:1.
	data:=DataCompra crearData:nombre  enFecha:pago getFecha  yTipo:pago getSuscripcion.
	].
^data.
]

{ #category : #'as yet unclassified' }
Suscripcion >> obtenerPago:aKeyName [
^coleccionPagos select:[:pago|pago equals:aKeyName]
]

{ #category : #'as yet unclassified' }
Suscripcion >> pagoEnFecha:unaFecha [ 
^(fechaInicio >=unaFecha) & (unaFecha <=fechaFin).
]

{ #category : #'as yet unclassified' }
Suscripcion >> precio:unPrecio [
precio :=unPrecio

]

{ #category : #dataTable }
Suscripcion >> precioRow: rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getPrecio asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Suscripcion >> seCompro:unContenido [
|flag test|
flag:=false.
test:=coleccionPagos  detect:[:unPago|unPago equals:unContenido  name]ifNone:[nil].
test isNotNil ifTrue:[
	flag :=true.].
^flag.
]

{ #category : #dataTable }
Suscripcion >> tipoRow: rowIndex [
^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getTipo asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
Suscripcion >> toString:aSuscription [
^aSuscription getTipo.
]

{ #category : #dataTable }
Suscripcion >> vencimientoRow:rowIndex [ 
^ FTCellMorph new  
		addMorphBack: ((self elementAt: rowIndex) getVencimiento asStringMorph color:(Color red));
		yourself
]

{ #category : #'as yet unclassified' }
Suscripcion >> vigente [
^fechaFin asDateAndTime>= Date today.
]
