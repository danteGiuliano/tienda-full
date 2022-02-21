Class {
	#name : #MenuSuscripcion,
	#superclass : #SubMenuView,
	#instVars : [
		'subMenu',
		'addSuscription',
		'promocion',
		'tablePromocion',
		'tableSuscripcion'
	],
	#category : #'TiendaAmazingShop-view'
}

{ #category : #'as yet unclassified' }
MenuSuscripcion class >> createMenuSuscripcionIn:aContent [
|temp|
temp := self new.
^temp initialize:aContent.
]

{ #category : #initialization }
MenuSuscripcion >> addPromocion [
promocion:=ComponenetePromocion new.
subMenu addMorph:promocion.
promocion addDependent:self.
 
]

{ #category : #initialization }
MenuSuscripcion >> addSuscription [
addSuscription :=ModalSuscripcion call.
subMenu addMorph:addSuscription.
addSuscription addDependent:self.

]

{ #category : #initialization }
MenuSuscripcion >> aplicarPromociones [
|button|
button :=Button create:'Aplicar promociones' size:200@60.
subMenu addMorph:button.
button top:promocion bottom+20.
button left:promocion left.
button color:(Theme morphContrast).
button textColor:(Theme morph).
button mouseAction:[Control modelFuntion:[:h| h aplicarPromociones].button color:Theme buttom. button textColor:Theme buttomText.].
]

{ #category : #initialization }
MenuSuscripcion >> initialize:aContent [
super initialize.
subMenu :=aContent.
self addSuscription.
self loadTableSuscripcions.
self loadTablePromociones.
self addPromocion.
self style.
self aplicarPromociones
]

{ #category : #initialization }
MenuSuscripcion >> loadTablePromociones [
| aNamesColumnTable promociones|
aNamesColumnTable:= #( 'Suscripcion' 'Cantidad Articulos' 'Nueva suscripcion' 'Descuento Promocion' 'meses')asOrderedCollection.
promociones :=Control modelFuntionReturn:[:h| h getPromociones].
tablePromocion := Table create: (Promocion elements:(promociones)) aCollums: aNamesColumnTable  aSize:(800@350).
"Style"
Helper addCenterMorph: tablePromocion in:subMenu.
Helper border: tablePromocion aColor:tablePromocion color.
tablePromocion headerBorder:0.95. 
]

{ #category : #initialization }
MenuSuscripcion >> loadTableSuscripcions [
| aNamesColumnTable temp|
temp  :=Control modelFuntionReturn:[:tienda| tienda getSuscripciones].
aNamesColumnTable:= #( 'Nombre' 'Descuento Libro' 'Descuento Pelicula' 'Descuento Aplicacion'  'Precio')asOrderedCollection.
tableSuscripcion := Table create: (Descuento elements:(temp)) aCollums: aNamesColumnTable  aSize:(800@200).
"Style"
Helper addCenterMorph: tableSuscripcion in:subMenu.
Helper border: tableSuscripcion aColor: tableSuscripcion color.
tableSuscripcion headerBorder:0.95. 
]

{ #category : #initialization }
MenuSuscripcion >> style [ 
addSuscription left:subMenu left+10;top:subMenu top.
tableSuscripcion left:addSuscription right +10;top:subMenu  top.
promocion top:addSuscription bottom+10;left:addSuscription left.
tablePromocion top:promocion top;left:promocion right+10. 
]

{ #category : #initialization }
MenuSuscripcion >> update:aObject [
tablePromocion delete.tableSuscripcion delete.self loadTableSuscripcions. self loadTablePromociones.self style.
]
