Class {
	#name : #TextDisplayPart,
	#superclass : #WizardPart,
	#category : #Merlin
}

{ #category : #'initialize-release' }
TextDisplayPart >> initialize [

	super initialize
]

{ #category : #'morph content setup tools' }
TextDisplayPart >> newStringFor: aString [ 
	^ StringMorph contents: aString
]

{ #category : #'accessing - morph' }
TextDisplayPart >> text: aString [ 
	| tmp |
	self contents: {  (tmp := self newStringFor: aString)  }.
	Transcript show: 'text:' , tmp asString
]
