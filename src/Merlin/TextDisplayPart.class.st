Class {
	#name : #TextDisplayPart,
	#superclass : #WizardPart,
	#category : #Merlin
}

{ #category : #'morph content setup tools' }
TextDisplayPart >> newStringFor: aString [ 
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	^ StringMorph contents: aString
]

{ #category : #'accessing - morph' }
TextDisplayPart >> text: aString [ 
	| |
	self contents: {  (self newStringFor: aString)  }.
]
