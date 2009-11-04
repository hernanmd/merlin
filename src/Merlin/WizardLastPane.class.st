Class {
	#name : #WizardLastPane,
	#superclass : #WizardPane,
	#instVars : [
		'previousButton',
		'terminateButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardLastPane >> displayButtons [

	self buttons: {cancelButton. previousButton := self newPreviousButton. terminateButton := self newTerminateButton  }.
]

{ #category : #'initialize-release' }
WizardLastPane >> initialize [

	super initialize .


	
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
		wizardControl 
			setInformation: value
			withValue: key outputValue ].
	wizardControl performTerminateButtonAction
]
