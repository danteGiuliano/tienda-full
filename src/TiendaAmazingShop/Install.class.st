Class {
	#name : #Install,
	#superclass : #Object,
	#classVars : [
		'aModel',
		'userSesion'
	],
	#category : #'TiendaAmazingShop-Control'
}

{ #category : #'as yet unclassified' }
Install class >> AmazingShop [
[self installMySQl]fork.
[self preLoadTheme]fork.
]

{ #category : #'as yet unclassified' }
Install class >> installMySQl [
Metacello new
	repository: 'github://danteGiuliano/Pharo-MySQL';
	baseline: 'MySQL';
	load
]

{ #category : #'as yet unclassified' }
Install class >> preLoadTheme [
Theme defaultTheme.
]

{ #category : #'as yet unclassified' }
Install class >> resorces [
(FileSystem disk workingDirectory) openInOSFileBrowser.
]
