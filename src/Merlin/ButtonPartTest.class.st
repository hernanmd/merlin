Class {
	#name : #ButtonPartTest,
	#superclass : #WizardPartTest,
	#category : #'Merlin-Tests'
}

{ #category : #'as yet unclassified' }
ButtonPartTest >> testEnableAndDisable [

	| buttonPart |
	buttonPart := ButtonPart new.
	buttonPart enable.
	self assert: buttonPart buttonMorph enabled.
	buttonPart disable.
	self deny: buttonPart buttonMorph enabled.
]

{ #category : #'as yet unclassified' }
ButtonPartTest >> testLabel [

	| buttonPart |
	buttonPart := ButtonPart new.
	buttonPart label: 'something'.
	self assert: buttonPart buttonMorph label = 'something'.
]
