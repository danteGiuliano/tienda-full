Class {
	#name : #ComponenteContenido,
	#superclass : #BorderedMorph,
	#instVars : [
		'table',
		'keyName',
		'nombre',
		'precio',
		'fechaInicio',
		'verCompras',
		'tipo'
	],
	#category : #'TiendaAmazingShop-components tienda'
}

{ #category : #'as yet unclassified' }
ComponenteContenido class >> createComponentAName:aName aPrecio:aPrice aFecha:aFecha yTipo:unTipo [
|temp|
temp := self new.
temp initializeName:aName aPrice:aPrice aFecha:aFecha tipo:unTipo.
^temp .
]

{ #category : #'as yet unclassified' }
ComponenteContenido class >> createComponentModel:contenidoModel [
| aName aPrice aFecha unTipo|
aName :=contenidoModel name.
aPrice :=contenidoModel precio.
aFecha :=contenidoModel fecha.
unTipo :=(contenidoModel class)asString.
^self createComponentAName:aName aPrecio:aPrice  aFecha:aFecha yTipo:unTipo.
]

{ #category : #initialization }
ComponenteContenido >> data:aName aPrice:aPrice aFecha:aFecha yTipo:unTipo [.
nombre contents:nombre contents,' ',aName.
precio  contents:precio contents,' ',aPrice asString.
fechaInicio  contents:fechaInicio contents,' ',aFecha.
tipo contents:unTipo.

]

{ #category : #initialization }
ComponenteContenido >> defineMorph [
self extent:600@100.
verCompras:=Button create:'Ver Compras' size:100@30.

nombre :=StringMorph new contents:'Nombre: '.
fechaInicio :=StringMorph new contents:'Fecha Inicio: '.
precio :=StringMorph new contents:'Precio: '.
tipo :=StringMorph new .

Helper addLeftTopMorphic: nombre in: self.
Helper addLeftBottomMorph: fechaInicio in: self.
Helper addLeftCenterMorph: precio in: self.
Helper addLeftCenterMorph: tipo in: self.
 
Helper addRightCenterMorph: verCompras in:self. 

]

{ #category : #initialization }
ComponenteContenido >> initializeName:aName aPrice:aPrice aFecha:aFecha tipo:unTipo [.
super initialize.
self defineMorph.
self style.
keyName:=aName.
self data:aName aPrice:aPrice aFecha:aFecha yTipo:unTipo.
self logicSubMenu.
]

{ #category : #initialization }
ComponenteContenido >> logicSubMenu [
|clientes  collectionDataCompra|
verCompras mouseAction:[
	collectionDataCompra :=OrderedCollection new.
	clientes :=Control modelFuntionReturn:[:h| h getComprasContenido:keyName].
	clientes do:[:unCliente||temp|
		temp:=(unCliente obtenerDataCompra:keyName).
		temp isNotNil ifTrue:[collectionDataCompra add:temp].
		  ].
	table updateData:(DataCompra elements: collectionDataCompra).
	].
]

{ #category : #initialization }
ComponenteContenido >> style [ 
nombre left:self left +30.
nombre top:self top+15.

precio left:nombre left.
fechaInicio left:nombre left.

precio top:nombre bottom+5.
fechaInicio top:precio bottom +5.

verCompras right:self right -60.

tipo top:precio top.
tipo right: verCompras left-80.

"Style morph"
self color:(Theme morph).
Helper border: self aColor: (Theme morph)  rad:3. 

verCompras  color:(Theme buttom ).
verCompras textColor:(Theme buttomText).

Helper border: verCompras aColor:(Theme buttom) rad:3.

nombre font:StandardFonts  codeFont.
fechaInicio  font:StandardFonts  codeFont.
precio font:StandardFonts  codeFont.
tipo font:StandardFonts codeFont.
]

{ #category : #initialization }
ComponenteContenido >> table:aTable [
table:=aTable.
]
