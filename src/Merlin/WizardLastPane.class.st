Class {
	#name : #WizardLastPane,
	#superclass : #WizardPane,
	#instVars : [
		'terminateButton'
	],
	#category : #'Merlin-Panes'
}

{ #category : #'private - accessing' }
WizardLastPane >> displayButtons [

	terminateButton := self newTerminateButton.
	self buttons: {cancelButton. self newPreviousButton. terminateButton}.
]

{ #category : #'morph creation' }
WizardLastPane >> newTerminateButton [
	
	^ self newButtonNamed: 'Terminate' withAction: #terminateButtonAction.
]

{ #category : #actions }
WizardLastPane >> terminateButtonAction [
	"action executed when the terminate button is pressed"
	
	partsAndInformationsAssociated keysAndValuesDo: 
		[ :key :value | 
		self wizardControl 
			information: value
			withValue: key outputValue ].
	self wizardControl performTerminateButtonAction
]
