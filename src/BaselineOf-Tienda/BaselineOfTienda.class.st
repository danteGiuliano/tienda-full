Class {
	#name : #BaselineOfTienda,
	#superclass : #BaselineOf,
	#category : #'BaselineOf-Tienda'
}

{ #category : #baselines }
BaselineOfTienda >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			"Packages"
			spec
				package: 'TiendaAmazingShop']
]

{ #category : #accessing }
BaselineOfTienda >> projectClass [

	^ MetacelloCypressBaselineProject
]
