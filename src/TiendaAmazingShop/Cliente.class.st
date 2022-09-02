Class {
	#name : #Cliente,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'nombre',
		'dni',
		'email',
		'listaDeSuscripcion',
		'suscripcionItem'
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
temp añadirListaMySQL:((DataBase getSuscripciones_Compradas:dni)rows).
temp añadirContenidoMySQL:((DataBase getContenidosComprados:dni)rows).
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
				self añadirPago:(Pago createWithMySQL:instanceKey).
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
	|data list  nameSuscription fechaInicio fechaFin cantidad_productos precio|
	data :=(aMySQLQuery at:counter) columns.
	nameSuscription:=data at:1.
	list := Control modelFuntionReturn:[:h | h obtenerSuscripcion:nameSuscription].
	fechaInicio:=data at:5.
	fechaFin :=data at:6.
	cantidad_productos := data at:8.
	precio :=data at:9.

	data :=Mensual createWithSQL:list yFechaInicio:fechaInicio  yFechaFin:fechaFin  deNombre:nameSuscription contenidosComprados:cantidad_productos yPrecio:precio.
	self addSuscription:data.
	counter :=counter+1.
	].
]

{ #category : #'as yet unclassified' }
Cliente >> añadirPago:unPago [
|i flag fechaPago|
fechaPago:= unPago fecha.
flag := true.
i :=1.
[(i <= (listaDeSuscripcion size)) & flag & (listaDeSuscripcion isNotEmpty)] whileTrue:[
	|unaSuscripcion|
	unaSuscripcion :=listaDeSuscripcion at:i.
	(unaSuscripcion pagoEnFecha:fechaPago)& (unaSuscripcion equals:(unPago getTipo)) ifTrue:[
		unaSuscripcion añadirPagoMySQL:unPago.
		flag:=false.
		]ifFalse:[
		"El metodo falla aqui"
		(unPago getTipo)='nil'ifTrue:[
		suscripcionItem añadirPagoMySQL:unPago.
		flag:=false.
			].
		].
	i:=i+1.
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
|pagos|
pagos:=OrderedCollection new.
listaDeSuscripcion do:[:suscripcion| pagos:= pagos|suscripcion getPagos].
^pagos.
]

{ #category : #'as yet unclassified' }
Cliente >> compraContenido:unContenido [
|unPrecio exito|
exito :=false.
unPrecio := self obtenerPrecioContenido:unContenido.
(unPrecio == -1) ifFalse:[
	|suscripcion|
	suscripcion :=self getSuscripcionActiva.
	unContenido necesitaComprobante ifTrue:[
	suscripcion añadirPago:(Pago crearPago:unPrecio deItem:unContenido   ySuscripcion:suscripcion).
		].
	].
^exito.
]

{ #category : #'as yet unclassified' }
Cliente >> compraSuscripcion:unaSuscripcion [
"Verificar que no exista en tu lista (:"
listaDeSuscripcion add:unaSuscripcion.
]

{ #category : #'as yet unclassified' }
Cliente >> crearColleciones [
listaDeSuscripcion :=SortedCollection sortBlock:[:f1 :f2 |f1 mayor:f2].
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
|temp suscripcion|
temp :=suscripcionItem.
listaDeSuscripcion isEmpty ifFalse:[
	suscripcion :=listaDeSuscripcion at:1.
	suscripcion vigente ifTrue:[temp :=suscripcion].
	].
^temp.
]

{ #category : #getters }
Cliente >> getSuscripciones_Compradas [
^listaDeSuscripcion.
]

{ #category : #initialization }
Cliente >> initialize [
super initialize.
suscripcionItem :=Item new.
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

{ #category : #'as yet unclassified' }
Cliente >> obtenerContenido:keyName [
|i flag data|
data := nil.
flag := true.
i :=1.
[i <= listaDeSuscripcion size & flag & listaDeSuscripcion isNotEmpty] whileTrue:[
	|unaSuscripcion|
	unaSuscripcion :=listaDeSuscripcion at:i.
	data :=unaSuscripcion obtenerPago:keyName.
	data isEmpty ifTrue:[
		data :=nil.
		]ifFalse:[
		flag:=false.
		].
	i:=i+1
	].
^ data.
]

{ #category : #gettersVisual }
Cliente >> obtenerDataCompra:keyName [
| pago data|
data :='Sin suscripcion'.
pago :=self obtenerContenido:keyName.
pago isNotEmpty ifTrue:[
	pago:=pago at:1.
	data:=DataCompra crearData:nombre  enFecha:pago getFecha  yTipo:pago getSuscripcion.
	].
^data.
]

{ #category : #accessing }
Cliente >> obtenerPrecioContenido: unContenido [
	| precio |
	precio := -1.
	(self poseeContenido: unContenido)
		ifFalse: [ | suscripcion |
			suscripcion := self getSuscripcionActiva.
			precio := suscripcion calcularPrecio: unContenido].
	^ precio 
]

{ #category : #'as yet unclassified' }
Cliente >> poseeContenido:contenido [
|flag test|
flag:=false.
test:=listaDeSuscripcion detect:[:unaSuscripcion|unaSuscripcion seCompro:contenido]ifNone:[nil].
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
