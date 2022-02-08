Class {
	#name : #BaselineOfTienda,
	#superclass : #BaselineOf,
	#category : #BaselineOfTienda
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
