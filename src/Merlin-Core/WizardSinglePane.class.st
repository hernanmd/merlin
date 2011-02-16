Class {
	#name : #WizardSinglePane,
	#superclass : #WizardPane,
	#instVars : [
		'terminateButton'
	],
	#category : #'Merlin-Panes'
}

{ #category : #'private - accessing' }
WizardSinglePane >> displayButtons [

	terminateButton := self newTerminateButton.
	self buttons: {cancelButton. terminateButton}.
]

{ #category : #'morph creation' }
WizardSinglePane >> newTerminateButton [
	
	^ self newButtonNamed: 'Terminate' withAction: #terminateButtonAction.
]

{ #category : #actions }
WizardSinglePane >> terminateButtonAction [
	"action executed when the terminate button is pressed"
	
	partsAndInformationsAssociated keysAndValuesDo: 
		[ :key :value | 
		self wizardControl 
			information: value
			withValue: key outputValue ].
	self wizardControl performTerminateButtonAction
]
