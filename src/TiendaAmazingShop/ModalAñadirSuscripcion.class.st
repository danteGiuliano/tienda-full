Class {
	#name : #'ModalAñadirSuscripcion',
	#superclass : #BorderedMorph,
	#instVars : [
		'inputDNI',
		'addSuscription',
		'search',
		'textBox',
		'model',
		'instanceClient',
		'addSuscriptionPromo'
	],
	#category : #'TiendaAmazingShop-components tienda'
}

{ #category : #'as yet unclassified' }
ModalAñadirSuscripcion class >> call [
^self new.

]

{ #category : #'as yet unclassified' }
ModalAñadirSuscripcion class >> call:aModel [
	|temp|.
temp :=self new.
temp initialize:aModel.
temp openCenteredInWorld.

]

{ #category : #initialization }
ModalAñadirSuscripcion >> addBottoms [ 
addSuscription :=Button create: 'Anadir Suscripcion' size:120@30.
addSuscriptionPromo :=Button create: 'Tiene Promocion' size:120@30.
search :=Button create:'BUSCAR' size:70@20.

addSuscription color:(Theme buttom);textColor:(Theme buttomText). 
addSuscriptionPromo color:(Theme buttom);textColor:(Theme buttomText). 
search color:(Theme buttom);textColor:(Theme buttomText).

Helper border: search  aColor:search color  rad:2. 
Helper border: addSuscription   aColor: addSuscription color rad:3.
Helper border: addSuscriptionPromo   aColor: addSuscription color rad:3.

Helper addRightTopMorph: search  in:self.
Helper addCenterMorph: addSuscription  in:self.  
Helper addCenterMorph: addSuscriptionPromo  in:self.  
 
]

{ #category : #initialization }
ModalAñadirSuscripcion >> addInputText [
inputDNI :=TextBox create: 'Ingrese DNI' size:200@30.
Helper addCenterMorph: inputDNI  in:self.
  
]

{ #category : #initialization }
ModalAñadirSuscripcion >> addTextBox [
textBox :=RubScrolledTextMorph new.
textBox extent:280@200.
textBox color:(Theme morphContrast ).

Helper border: textBox  aColor:textBox color. 
Helper addCenterMorph: textBox  in:self.

"No write"
textBox setText:'informacion de cliente'.
textBox beReadOnly.
]

{ #category : #initialization }
ModalAñadirSuscripcion >> defineMorph [
self extent:300@300.
self color:(Theme morph).
]

{ #category : #initialization }
ModalAñadirSuscripcion >> initialize [
super initialize.
self defineMorph.
self addInputText.
self addTextBox.
self addBottoms.
self style.
self logic.

]

{ #category : #initialization }
ModalAñadirSuscripcion >> logic [
search mouseAction:[
self updateTextBox:(Control modelFuntionReturn:[:h| h searchDNI:(inputDNI text)asString])].
addSuscription mouseAction:[self updateAddSuscripcion.]
]

{ #category : #'as yet unclassified' }
ModalAñadirSuscripcion >> ofrecerPromos:promos [
|names selection promo|
addSuscriptionPromo textColor:Color green .
addSuscriptionPromo mouseAction: [ 
	names :=promos collect:[:aSuscription|aSuscription getNuevaSuscripcion].
	selection:=PopupChoiceDialogWindow chooseFrom:names lines:#() title:'Promociones'.
	promo:=promos detect:[:p|p equals:selection].
	Control modelFuntion:[:h | h comprarSuscripcionDescuento:promo enCliente:instanceClient ]
	 ].
	

]

{ #category : #initialization }
ModalAñadirSuscripcion >> style [
"Boton search"
search right:self right -10.
search top:self top+10.
"input addDni"
inputDNI bottom:search bottom.
inputDNI right:search left-5.
"Text box"
textBox left: self top+10.
"Boton add suscription"
addSuscription top:textBox bottom+5.
addSuscription left:textBox left.
addSuscriptionPromo right:textBox  right.
addSuscriptionPromo bottom:addSuscription bottom.
addSuscription disable.
Helper border:self aColor:self color.
]

{ #category : #initialization }
ModalAñadirSuscripcion >> updateAddSuscripcion [
instanceClient ifNotNil:[
	|selection suscriptions names suscription aColection suscriptionBuy|
	aColection :=OrderedCollection new.
	suscriptions :=Control modelFuntionReturn:[:h| h getSuscripciones. ].
	names :=suscriptions collect:[:aSuscription|aSuscription getNombre].
	selection:=PopupChoiceDialogWindow chooseFrom:names lines:#() title:'Suscripciones'.
	suscription:=suscriptions detect:[:aSuscription|aSuscription equals:selection].
	
	aColection add:selection.
	aColection add:(instanceClient getDni)asString.
	aColection add:suscription getPrecio.
	
	suscriptionBuy :=SuscripcionComprada crearSuscripcion:suscription deNombre:selection.
	"Realiza un control de que el cliente no la tiene antes de agregar dante"
	Control modelFuntion:[:h | h añadirSuscripcionComprada:suscriptionBuy aCliente:instanceClient].
	DataBase registerSuscripcion_Comprada: aColection.
	
]
]

{ #category : #initialization }
ModalAñadirSuscripcion >> updateTextBox:aClient [
aClient ifNil:[textBox setText:'Usuario no encontrado'.addSuscription textColor:(Color gray).
	instanceClient :=nil.
	]ifNotNil:[
	|promos|
	instanceClient :=aClient.
	promos :=Control modelFuntionReturn:[:h| h tienePromocion:instanceClient].
	promos isEmpty ifFalse:[self ofrecerPromos:promos].
	textBox setText:aClient getData.
	addSuscription textColor:(Color green).
	].
]
