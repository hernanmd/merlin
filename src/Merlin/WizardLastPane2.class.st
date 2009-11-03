Class {
	#name : #WizardLastPane2,
	#superclass : #WizardPane2,
	#instVars : [
		'previousButton',
		'terminateButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardLastPane2 >> displayButtons [

	self buttons: {cancelButton. previousButton := self newPreviousButton. terminateButton := self newTerminateButton  }.
]

{ #category : #'initialize-release' }
WizardLastPane2 >> initialize [

	super initialize .
	self displayButtons 

	
]

{ #category : #'morph creation' }
WizardLastPane2 >> newTerminateButton [
	"Each kind of pane contain a cancel button that enable to close the dialog window"

	^ self newButtonNamed: 'Terminate' withAction:   #terminateButtonAction.
]

{ #category : #actions }
WizardLastPane2 >> previousButtonAction [

	"self subclassResponsibility "
	wizardControl performPreviousButtonAction 
]

{ #category : #actions }
WizardLastPane2 >> terminateButtonAction [

	"self subclassResponsibility "
	blocksAndInformationsAssociated keysAndValuesDo: [:key :value | wizardControl setValue: key informationValue  toInformation: value ].
	wizardControl performTerminateButtonAction .
	
]
