Class {
	#name : #BaselineOfMerlin,
	#superclass : #BaselineOf,
	#category : #BaselineOfMerlin
}

{ #category : #baselines }
BaselineOfMerlin >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec 
				package: 'Merlin';
				package: 'Merlin-Tests'	with: [ spec requires: #(Merlin) ].
			spec 
				group: 'Core' 						with: #('Merlin');
				group: 'Tests' 						with: #('Merlin' 'Merlin-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
