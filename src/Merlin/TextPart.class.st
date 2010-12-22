Class {
	#name : #TextPart,
	#superclass : #WizardPart,
	#instVars : [
		'text',
		'partValue'
	],
	#category : #'Merlin-Parts'
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


	partValue isNil 
		ifFalse: [
			partValue isBlock
			ifTrue: [
				self text: (partValue value: self requiredInputs). 
				]
			ifFalse: [
				self text: partValue 
				].
			]
		ifTrue: [
			|default|
			default := defaultValue meValue: self requiredInputs.
			groupBoxName 
				ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: (self newText: self text)}.]
				ifNil: [self populateContents: {self newText: self text}].
	
			]
	
]

{ #category : #'accessing - wizard mangement' }
TextPart >> morphContents [

	self latePopulateContents.
	^ blockContents.  
]

{ #category : #'accessing - wizard mangement' }
TextPart >> outputValue [ 

	^ self text
]

{ #category : #accessing }
TextPart >> text [ 

	^ text ifNil: ['']
]

{ #category : #accessing }
TextPart >> text: aString [
	
	text := aString.
	self populateContents: { self newGroupboxNamed: groupBoxName  With: (self newText: aString) }
]
