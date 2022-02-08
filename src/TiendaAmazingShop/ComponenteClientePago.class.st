Class {
	#name : #ComponenteClientePago,
	#superclass : #Morph,
	#instVars : [
		'inputDNI',
		'buttonSearch',
		'menuScroll',
		'page',
		'collecionPago',
		'collecionBoton'
	],
	#category : #'TiendaAmazingShop-services'
}

{ #category : #operations }
ComponenteClientePago class >> create [.
^self new openInHand.
]

{ #category : #initialization }
ComponenteClientePago >> addButton [ 
buttonSearch :=Button create:'Buscar pagos' size:90@30.
self addMorph:buttonSearch.
Helper border:buttonSearch  aColor:buttonSearch color. 
]

{ #category : #initialization }
ComponenteClientePago >> addMenuScroll [
menuScroll :=MenuScroll aSize:150@230.
menuScroll color:Theme buttom.
Helper border: menuScroll  aColor:menuScroll color.
self addMorph: menuScroll.

 
]

{ #category : #adding }
ComponenteClientePago >> addPage [
page:=RubScrolledTextMorph new extent:150@200.
self addMorph: page.
page color:Color transparent.
page beReadOnly.
]

{ #category : #initialization }
ComponenteClientePago >> addPlaceHolder [
inputDNI :=TextBox create:'Ingrese un DNI' size:200@30.
self addMorph:inputDNI.
]

{ #category : #initialization }
ComponenteClientePago >> defineMorph [ 
self extent:350@300.
self color:Theme morph.
Helper border: self aColor:self color. 
]

{ #category : #initialization }
ComponenteClientePago >> initialize [ 
super initialize.
self defineMorph.
self addButton.
self addPlaceHolder.
self addMenuScroll.
self addPage.
self logic.
self style.
]

{ #category : #initialization }
ComponenteClientePago >> logic [ 
buttonSearch mouseAction:[
	|cliente|
	menuScroll clear.
	cliente :=Control modelFuntionReturn:[:h| h searchDNI:inputDNI input].
	collecionPago :=cliente colleccionPago.
	collecionPago do:[:pago|
		|buton|
		buton :=Button create:'Ver Pago | ',pago getItem size:135@30.
		buton mouseAction:[[:value|page setText:value toString]value:pago].
		menuScroll addItem:buton.
		].
	]
]

{ #category : #initialization }
ComponenteClientePago >> style [ 

buttonSearch top:self top+10;left:self left+10.
inputDNI center:buttonSearch center;left:buttonSearch right +10.
menuScroll center:self center;left:self left+10;bottom:self bottom-15.
page center:menuScroll  center;left:menuScroll right +10.
]
