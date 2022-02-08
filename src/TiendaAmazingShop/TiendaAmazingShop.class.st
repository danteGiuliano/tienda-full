Class {
	#name : #TiendaAmazingShop,
	#superclass : #BaselineOf,
	#category : #TiendaAmazingShop
}

{ #category : #baselines }
TiendaAmazingShop >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'TiendaAmazingShop']
]
