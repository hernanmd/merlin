Class {
	#name : #TextPart,
	#superclass : #WizardPart,
	#instVars : [
		'text',
		'groupBoxName',
		'partValue'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
TextPart class >> on: blockOrStringText inGroupBoxNamed: groupBoxName [

	^ super new initializeWith: blockOrStringText inGrouopboxNamed: groupBoxName;yourself. 
]

{ #category : #'accessing - wizard mangement' }
TextPart >> contents [

	self latePopulateContents.
	^ blockContents.  
]

{ #category : #'initialize-release' }
TextPart >> initializeWith: blockOrStringText inGrouopboxNamed: anotherString [
	
	groupBoxName := anotherString .
	partValue := blockOrStringText .
]

{ #category : #private }
TextPart >> latePopulateContents [

	partValue isBlock
		ifTrue: [
			self text: (partValue value: self requiredInputs). 
			]
		ifFalse: [
			self text: partValue 
			].
]

{ #category : #'accessing - wizard mangement' }
TextPart >> outputValue [ 

	^ text
]

{ #category : #accessing }
TextPart >> text: aString [
	
	text := aString.
	self populateContents: { self newGroupboxNamed: groupBoxName  With: (self newText: aString) }
]
