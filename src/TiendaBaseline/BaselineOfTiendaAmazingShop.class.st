Class {
	#name : #BaselineOfTiendaAmazingShop,
	#superclass : #BaselineOf,
	#category : #TiendaBaseline
}

{ #category : #baselines }
BaselineOfTiendaAmazingShop >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'TiendaAmazingShop']
]
