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
				package: 'Tienda|Dante Giuliano-Components genericos';
				package: 'Tienda|Dante Giuliano-Components tienda';
				package: 'Tienda|Dante Giuliano-Control';
				package: 'Tienda|Dante Giuliano-Model';
				package: 'Tienda|Dante Giuliano-Services';
				package: 'Tienda|Dante Giuliano-manifiest';
				package:  'Tienda|Dante Giuliano-view']
]
