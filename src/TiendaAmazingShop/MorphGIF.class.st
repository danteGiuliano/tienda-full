Class {
	#name : #MorphGIF,
	#superclass : #AnimatedImageMorph,
	#instVars : [
		'temp'
	],
	#category : #'TiendaAmazingShop-services'
}

{ #category : #'as yet unclassified' }
MorphGIF class >> gifFromString:aStringRouteFile [
|fs gif |
fs := aStringRouteFile asFileReference binaryReadStream.
gif := GIFReadWriter on: fs.
gif
   readHeader;
   readBody.
^self fromGIFReader:gif.
]
