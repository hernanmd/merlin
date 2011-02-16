Class {
	#name : #ButtonPart,
	#superclass : #WizardPart,
	#instVars : [
		'buttonMorph'
	],
	#category : #'Merlin-Parts'
}

{ #category : #accessing }
ButtonPart >> buttonMorph [ 

	^ buttonMorph
]

{ #category : #accessing }
ButtonPart >> disable [

	self buttonMorph disable.
]

{ #category : #accessing }
ButtonPart >> enable [

	self buttonMorph enable.
]

{ #category : #'initialize-release' }
ButtonPart >> initialize [

	super initialize.
	buttonMorph := self newButtonNamed: 'Default name' withAction: #hasChanged.
]

{ #category : #accessing }
ButtonPart >> label: aString [

	buttonMorph label: aString
]

{ #category : #accessing }
ButtonPart >> latePopulateContents [
	
	|default|
	default := defaultValue meValue: self requiredInputs.
	
	default ifNotNilDo: [:aString |
		self label: aString
		]. 
	
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: buttonMorph}]
		ifNil: [self populateContents: {buttonMorph }].
	
]

{ #category : #'accessing - wizard management' }
ButtonPart >> outputValue [ 

	^ nil
]
