Class {
	#name : #TestTextDisplayBlock,
	#superclass : #WizardPart,
	#category : #Merlin
}

{ #category : #'initialize-release' }
TestTextDisplayBlock >> initialize [

	super initialize
]

{ #category : #'morph content setup tools' }
TestTextDisplayBlock >> newStringFor: aString [ 
	^ StringMorph contents: aString
]

{ #category : #'accessing - morph' }
TestTextDisplayBlock >> text: aString [ 
	| tmp |
	self contents: {  (tmp := self newStringFor: aString)  }.
	Transcript show: 'text:' , tmp asString
]
