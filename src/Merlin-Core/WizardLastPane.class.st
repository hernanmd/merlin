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

{ #category : #'*merlin-rendering' }
WizardLastPane >> merlinSpecificRenderer [ 
	^ MerlinMorphicLastPaneRenderer new 
]

{ #category : #'morph creation' }
WizardLastPane >> newTerminateButton [
	
	^ self newButtonNamed: 'Terminate' withAction: #terminateButtonAction.
]

{ #category : #'*merlin-rendering' }
WizardLastPane >> renderOnMerlinRenderer: aMerlinRenderer [

	^ aMerlinRenderer renderMerlinLastPane: self  
]

{ #category : #actions }
WizardLastPane >> terminateButtonAction [
	"action executed when the terminate button is pressed"
	
	self retrievePartsOutputs. 
	self wizardControl performTerminateButtonAction
]
