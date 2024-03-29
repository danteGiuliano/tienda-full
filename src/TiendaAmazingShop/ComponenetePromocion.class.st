"
self call openInHand
"
Class {
	#name : #ComponenetePromocion,
	#superclass : #BorderedMorph,
	#instVars : [
		'inputSuscripcion',
		'cantidad',
		'inputOtraSuscripcion',
		'descuento',
		'cantidadMeses',
		'aplicar'
	],
	#category : #'TiendaAmazingShop-components tienda'
}

{ #category : #'ffi-calls' }
ComponenetePromocion class >> call [
^self new.
]

{ #category : #initialization }
ComponenetePromocion >> addButtom [
aplicar :=Button create:'APLICAR' size:60@30. 
self addMorph:aplicar.
aplicar color:Color transparent;borderColor:Color transparent.
aplicar addDependent:self.
]

{ #category : #adding }
ComponenetePromocion >> addInputs [
inputSuscripcion :=TextBox create:'Suscripcion' size: 200@30.
cantidad :=TextBox create:'Cantidad Articulos' size:200@30.
inputOtraSuscripcion :=TextBox create:'Otra suscripcipon' size:200@30.
descuento :=TextBox create:'Descuento promo' size:200@30.
cantidadMeses :=TextBox create:'Cantidad meses' size:200@30.

self addMorph:inputSuscripcion;addMorph:cantidad;addMorph:inputOtraSuscripcion;addMorph:descuento
;addMorph:cantidadMeses
]

{ #category : #initialization }
ComponenetePromocion >> addPromotion [
|promotion fechaFin|
fechaFin :=Date today.
fechaFin:=fechaFin  addMonths:(cantidadMeses input)asNumber.
promotion :=Promocion crearPromoDescuento:(descuento input) fechaInicio:(Date today yyyymmdd)  fechaFin:fechaFin yyyymmdd deCantidad:(cantidad input)  yNuevaSuscripcion: (inputOtraSuscripcion input) deSuscripcionBase:(inputSuscripcion input).
Control modelFuntion:[:h|h addPromocion:promotion ].
DataBase registerPromocion: promotion.
]

{ #category : #initialization }
ComponenetePromocion >> changed [ 
self changed:self.
]

{ #category : #initialization }
ComponenetePromocion >> defineMorph [
self extent:300@350.
self color:Theme morph.
Helper border:self aColor:self color  rad:8. 
]

{ #category : #initialization }
ComponenetePromocion >> initialize [ 
super initialize.
self defineMorph.
self addInputs.
self addButtom.
self style.
self logic.
]

{ #category : #initialization }
ComponenetePromocion >> logic [ 
|blockCondition inputs validate|
aplicar mouseAction:[
"Verify inputs not nils"
inputs:={inputOtraSuscripcion.inputSuscripcion.cantidad.cantidadMeses.descuento}.

blockCondition :=[:input|input isEmpty].

validate :=inputs select:[:input|blockCondition value:input].

validate isEmpty ifTrue:[
	"Test pased."
	self addPromotion.
	MessageDialogWindow new text:'Promocion aceptada';title:'';openCenteredInWorld.
	inputs do:[:input| input clear].
	]ifFalse:[
	"Alert!"
	AlertDialogWindow new text:'Campos vacios ';title:'';openCenteredInWorld.
	]
].

]

{ #category : #initialization }
ComponenetePromocion >> style [
inputSuscripcion top:self top+20;left:self left+15.
cantidad top:inputSuscripcion bottom+20;left:inputSuscripcion left.
inputOtraSuscripcion top:cantidad bottom+40;left: cantidad left.
descuento top:inputOtraSuscripcion bottom+20;left:inputOtraSuscripcion left.
cantidadMeses top:descuento bottom+20;left:descuento left.
aplicar right:self right -10;bottom:self bottom-10.
aplicar textSize:12;textColor:Theme buttomText.
]

{ #category : #initialization }
ComponenetePromocion >> update:aBoton [.
self changed.
]
