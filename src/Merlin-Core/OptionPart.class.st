Class {
	#name : #OptionPart,
	#superclass : #WizardPart,
	#instVars : [
		'options'
	],
	#category : #'Merlin-Parts'
}

{ #category : #accessing }
OptionPart >> options [
	
	^ options
]

{ #category : #accessing }
OptionPart >> options: aCollection [

	options := (aCollection collect: [:each | each copy])
]
