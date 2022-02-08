Class {
	#name : #TiendaBaseline,
	#superclass : #BaselineOf,
	#category : #TiendaBaseline
}

{ #category : #baselines }
TiendaBaseline >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'TiendaAmazingShop']
]
