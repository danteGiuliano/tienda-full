Class {
	#name : #Icon,
	#superclass : #ImageMorph,
	#instVars : [
		'aBlock',
		'id'
	],
	#category : #'TiendaAmazingShop-Components'
}

{ #category : #'as yet unclassified' }
Icon class >> stringRoute:aStringRoute [
^self fromStream:((File named:aStringRoute asFileReference fullName ) readStream)
]
