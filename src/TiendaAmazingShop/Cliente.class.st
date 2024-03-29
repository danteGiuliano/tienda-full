Class {
	#name : #Cliente,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'nombre',
		'dni',
		'email',
		'listaDeSuscripcion',
		'colPago'
	],
	#category : #'TiendaAmazingShop-model'
}

{ #category : #initialization }
Cliente class >> crearCLiente:unNombre unDni:unDni unEmail:unEmail [
|temp|.
temp :=self new.
temp crearConNombre: unNombre yDni:unDni  Email:unEmail.
temp crearColleciones.
^temp. 
]

{ #category : #initialization }
Cliente class >> createWithSQL:aMysQuery [
|data temp nombre dni email|
data :=aMysQuery columns. "(dni,nombre,email,keyID)"
dni :=data at:1.
nombre:=data at:2.
email:=data at:3.
temp :=self new.
temp crearColleciones.
temp añadirListaMySQL:(DataBase getSuscripciones_Compradas:dni) rows.
temp añadirContenidoMySQL:(DataBase getContenidosComprados:dni)rows.
^temp crearConNombre:nombre yDni:dni Email:email. 
]

{ #category : #'as yet unclassified' }
Cliente >> addSuscription:aSuscription [.
listaDeSuscripcion add:aSuscription.
]

{ #category : #'as yet unclassified' }
Cliente >> añadirContenidoMySQL: aMySQLQuery [
	aMySQLQuery
		do: [ :instanceKey | 
			|  contenido|
			contenido := Control
				modelFuntionReturn: [ :h | h searchContenido: (instanceKey at: 4) ].
				colPago add:(Pago createWithMySQL:instanceKey).
				]
]

{ #category : #'as yet unclassified' }
Cliente >> añadirLista:unaLista [
listaDeSuscripcion :=unaLista.
]

{ #category : #'as yet unclassified' }
Cliente >> añadirListaMySQL:aMySQLQuery [
	|counter size|
	counter :=1.
	size :=aMySQLQuery size.
	[counter <= size] whileTrue:[
	|data list  nameSuscription descuento_aplicacion descuento_pelicula descuento_libro fechaInicio fechaFin cantidad_productos precio|
	data :=(aMySQLQuery at:counter) columns.
	nameSuscription:=data at:1.
	descuento_aplicacion :=data at:2.
	descuento_pelicula :=data at:3.
	descuento_libro :=data at:4.
	fechaInicio:=data at:5.
	fechaFin :=data at:6.
	cantidad_productos := data at:8.
	precio :=data at:9.
	list :=Dictionary newFrom:{'Aplicacion' ->descuento_aplicacion . 'Pelicula' ->descuento_pelicula.
	'Libro' ->descuento_libro.
	}.
	data :=SuscripcionComprada createWithSQL:list yFechaInicio:fechaInicio  yFechaFin:fechaFin  deNombre:nameSuscription contenidosComprados:cantidad_productos yPrecio:precio.
	self addSuscription:data.
	counter :=counter+1.
	].
]

{ #category : #'as yet unclassified' }
Cliente >> añadirPromocion:unaPromocion [
(listaDeSuscripcion at:1)añadirPromocion:unaPromocion.
]

{ #category : #gettersVisual }
Cliente >> cellColumn: column row:rowIndex [
column id = '#' ifTrue: [ ^ FTCellMorph new addMorph: rowIndex asMorph ].
column id = 'nombre' ifTrue: [ ^ self nameRow: rowIndex ].
column id= 'dni' ifTrue: [ ^self dniRow:rowIndex ].
column id= 'email' ifTrue: [ ^self emailRow:rowIndex ].
]

{ #category : #'as yet unclassified' }
Cliente >> colleccionPago [
^colPago.
]

{ #category : #'as yet unclassified' }
Cliente >> compraContenido:unContenido [
|unPrecio|
unPrecio := self obtenerPrecioContenido:unContenido.
unPrecio == -1 ifFalse:[
	colPago add:(Pago crearPago:unPrecio deItem:unContenido   ySuscripcion:self getSuscripcionActiva ).
	self getSuscripcionActiva contenidoComprado.
	]

]

{ #category : #'as yet unclassified' }
Cliente >> compraSuscripcion:unaSuscripcion [
"Verificar que no exista en tu lista (:"
listaDeSuscripcion add:unaSuscripcion.
]

{ #category : #'as yet unclassified' }
Cliente >> crearColleciones [
listaDeSuscripcion :=SortedCollection sortBlock:[:f1 :f2 |f1 mayor:f2].
colPago :=OrderedCollection new.
"listaDeSuscripcion add: SuscripcionComprada crearSuscripcionNoActiva."
]

{ #category : #'as yet unclassified' }
Cliente >> crearConNombre:unNombre yDni:unDni Email:unEmail [
nombre:=unNombre.
dni:=unDni.
email:=unEmail
]

{ #category : #gettersVisual }
Cliente >> dniRow:rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getDni asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Cliente >> emailRow: rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getEmail asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Cliente >> equals:unDni [
^((dni asString)=unDni ).
]

{ #category : #gettersVisual }
Cliente >> getData [
^('NOMBRE: ',nombre ,'\DNI:  ',(dni asString),'\EMAIL:  ',email) withCRs.
]

{ #category : #getters }
Cliente >> getDni [
^dni.
]

{ #category : #getters }
Cliente >> getEmail [
^email.
]

{ #category : #getters }
Cliente >> getNombre [
^nombre.
]

{ #category : #getters }
Cliente >> getSuscripcionActiva [
|suscripcion sinDescuento temp|
sinDescuento :=Dictionary  newFrom:{'Aplicacion'->0.'Pelicula'->0.'Libro'->0}.
suscripcion :=SuscripcionComprada crearSuscripcion:sinDescuento .
temp :=suscripcion.
listaDeSuscripcion isEmpty ifFalse:[
	suscripcion :=listaDeSuscripcion at:1.
	suscripcion vigente ifTrue:[temp :=listaDeSuscripcion at:1.].
	].
^temp.
]

{ #category : #getters }
Cliente >> getSuscripciones_Compradas [
^listaDeSuscripcion.
]

{ #category : #gettersVisual }
Cliente >> nameRow: rowIndex [
	^ FTCellMorph new  
		addMorphBack: (self elementAt: rowIndex) getNombre asStringMorph;
		yourself
]

{ #category : #gettersVisual }
Cliente >> newDataSourceMatching: aFTFilter [
	| newElements |
	newElements := Array withAll: (elements select: [ :each | 
		aFTFilter matches: (self toString: each) ]).
	^ self class new elements: newElements.
]

{ #category : #gettersVisual }
Cliente >> obtenerDataCompra:keyName [
| pago data|
data :=nil.
pago :=(colPago select:[:unPago| unPago equals:keyName.]).
pago isNotEmpty ifTrue:[
	pago:=pago at:1.
	data:=DataCompra crearData:nombre  enFecha:pago getFecha  yTipo:pago getSuscripcion.
	].
^data.
]

{ #category : #'as yet unclassified' }
Cliente >> obtenerPrecioContenido:unContenido [
|precio|
precio :=-1.
(self poseeContenido:unContenido )ifFalse:[
	|suscripcion categoria descuento|
	suscripcion := self getSuscripcionActiva.
	categoria := unContenido getIDCategoria.
	descuento := suscripcion calcularDescuento:categoria.
	precio := unContenido obtenerPrecio:descuento asNumber.
	].
^precio.
]

{ #category : #'as yet unclassified' }
Cliente >> pagoContenido:contenido [
^colPago select:[:unPago|unPago equals:contenido]
]

{ #category : #'as yet unclassified' }
Cliente >> poseeContenido:contenido [
|flag test|
flag:=false.
test:=colPago detect:[:unPago|unPago seCompro:contenido name]ifNone:[nil].
test isNotNil ifTrue:[
	flag :=true.].
^flag.
]

{ #category : #'as yet unclassified' }
Cliente >> promocionValida:unaCantidadArticulos [
|suscripcionComprada flag|
flag :=false.
listaDeSuscripcion isEmpty ifFalse:[
	suscripcionComprada :=listaDeSuscripcion at:1.
	flag:=(suscripcionComprada  promocionAplicable:unaCantidadArticulos).
	].
^flag.


]

{ #category : #gettersVisual }
Cliente >> toString:aCliente [
^(aCliente getDni) asString.
]
