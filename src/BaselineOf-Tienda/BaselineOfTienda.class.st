Class {
	#name : #BaselineOfTienda,
	#superclass : #BaselineOf,
	#category : #'BaselineOf-Tienda'
}

{ #category : #baselines }
BaselineOfTienda >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'TiendaAmazingShop']
]
