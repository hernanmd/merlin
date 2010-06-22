Class {
	#name : #ButtonPart,
	#superclass : #WizardPart,
	#instVars : [
		'button'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'initialize-release' }
ButtonPart >> initialize [

	super initialize.
	button := self newButtonNamed: 'Default name' withAction: #hasChanged.
]

{ #category : #accessing }
ButtonPart >> label: aString [

	button label: aString
]

{ #category : #accessing }
ButtonPart >> latePopulateContents [
	
	|default|
	default := defaultValue meValue: self requiredInputs.
	
	default ifNotNilDo: [:aString |
		self label: aString
		]. 
	
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: button}]
		ifNil: [self populateContents: {button }].
	
]

{ #category : #'accessing - wizard management' }
ButtonPart >> outputValue [ 

	^ nil
]
