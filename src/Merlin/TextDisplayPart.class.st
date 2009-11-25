Class {
	#name : #TextDisplayPart,
	#superclass : #WizardPart,
	#category : #Merlin
}

{ #category : #'instance creation' }
TextDisplayPart class >> forText: aStringMessage [

	^ super new initialize: aStringMessage .
]

{ #category : #'initialize-release' }
TextDisplayPart >> initialize: aStringMessage [

	super initialize.
	self text: aStringMessage.
]

{ #category : #'morph content setup tools' }
TextDisplayPart >> newStringFor: aString [ 
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	^ StringMorph contents: aString
]

{ #category : #'accessing - wizard mangement' }
TextDisplayPart >> outputValue [
	^ nil
]

{ #category : #'accessing - morph' }
TextDisplayPart >> text: aString [ 
	| |
	self contents: {  (self newStringFor: aString)  }.
]
