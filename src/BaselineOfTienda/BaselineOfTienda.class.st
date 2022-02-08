Class {
	#name : #BaselineOfTienda,
	#superclass : #BaselineOf,
	#category : #BaselineOfTienda
}

{ #category : #baselines }
BaselineOfTienda >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'TiendaAmazingShop'].
]
