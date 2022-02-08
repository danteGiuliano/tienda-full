Class {
	#name : #MenuCliente,
	#superclass : #SubMenuView,
	#instVars : [
		'table',
		'subMenu',
		'addCliente',
		'searchCliente',
		'addSuscription',
		'buyContenido',
		'searchPagos'
	],
	#category : #'TiendaAmazingShop-view'
}

{ #category : #'as yet unclassified' }
MenuCliente class >> createMenuClienteIn:aContent [
|temp|
temp := self new.
^temp initialize:aContent.
]

{ #category : #initialization }
MenuCliente >> addOptions [
	addCliente := ModalCliente call.
	searchCliente := ModalBuscarCliente call.
	addSuscription := ModalAñadirSuscripcion call.
	buyContenido :=ComponenetCompraContenido call.
	searchPagos :=ComponenteClientePago create.
	subMenu addMorph:addCliente;addMorph:searchCliente ;addMorph:addSuscription;addMorph:buyContenido;addMorph:searchPagos.
]

{ #category : #initialization }
MenuCliente >> initialize: aContent [
	super initialize.
	subMenu := aContent.
	self loadTable.
	self addOptions.
	self style.
]

{ #category : #initialization }
MenuCliente >> loadTable [
	| aNamesColumnTable temp |
	temp := Control modelFuntionReturn: [ :tienda | tienda getClients ].
	aNamesColumnTable := #('nombre' 'dni' 'email') asOrderedCollection.
	table := Table
		create: (Cliente elements: temp)
		aCollums: aNamesColumnTable
		aSize: 400 @ 300.
	Helper addLeftTopMorphic: table in: subMenu.
	Helper border: table aColor: table color.
	table headerBorder:0.98.
]

{ #category : #initialization }
MenuCliente >> style [
table left:subMenu left+30.
	
	searchCliente top: table bottom + 10.
	searchCliente left: table left.
	buyContenido bottom:searchCliente bottom.
	buyContenido left:searchCliente  right+10.
	addCliente bottom:buyContenido top-20 .
	addCliente left: buyContenido  left.

	addSuscription left:addCliente  right+10.
	addSuscription top:table top.
	
	searchPagos bottom:buyContenido bottom.
	searchPagos left:buyContenido right +10.
]
