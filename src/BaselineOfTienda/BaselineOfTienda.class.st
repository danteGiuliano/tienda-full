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
				package: 'TiendaAmazingShop';
				package: 'recursos']
]

{ #category : #accessing }
BaselineOfTienda >> projectClass [

	^ MetacelloCypressBaselineProject
]
