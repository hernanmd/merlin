Class {
	#name : #WizardLastPane,
	#superclass : #WizardPane,
	#instVars : [
		'terminateButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardLastPane >> displayButtons [

	self buttons: {cancelButton. self newPreviousButton. terminateButton := self newTerminateButton  }.
]

{ #category : #'morph creation' }
WizardLastPane >> newTerminateButton [
	

	^ self newButtonNamed: 'Terminate' withAction:   #terminateButtonAction.
]

{ #category : #actions }
WizardLastPane >> terminateButtonAction [
	"action executed when the terminate button is pressed "
	partsAndInformationsAssociated keysAndValuesDo: 
		[ :key :value | 
		self wizardControl 
			setInformation: value
			withValue: key outputValue ].
	self wizardControl performTerminateButtonAction
]
