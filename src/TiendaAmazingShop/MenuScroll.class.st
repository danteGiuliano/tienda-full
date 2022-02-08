Class {
	#name : #MenuScroll,
	#superclass : #ScrollPane,
	#instVars : [
		'conteiner',
		'scroll'
	],
	#category : #'TiendaAmazingShop-Components'
}

{ #category : #'as yet unclassified' }
MenuScroll class >> aSize:aSize [
^self new defineMorph: aSize.
]

{ #category : #adding }
MenuScroll >> addElements:colectionMorph [
colectionMorph  do:[:contenido|
	conteiner addMenuItem:contenido.
	].
]

{ #category : #adding }
MenuScroll >> addItem:item [
conteiner addMenuItem: item.
]

{ #category : #adding }
MenuScroll >> clear [ 
|size|
size := conteiner extent.
conteiner delete.
conteiner :=MenuMorph new extent:size.
conteiner color:(Color transparent).
conteiner borderColor:(Color transparent ).
self scroller addMorph:conteiner.
]

{ #category : #initialization }
MenuScroll >> defineMorph:aSize [
conteiner :=MenuMorph new extent:aSize*0.80.
self extent:aSize.
self scroller addMorph:conteiner.
conteiner color:(Color transparent).
conteiner borderColor:(Color transparent ).
self borderColor:Color transparent.
scroller color:Color transparent.
]

{ #category : #initialization }
MenuScroll >> initialize [ 
super initialize.
]
