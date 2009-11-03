Class {
	#name : #WizardMiddlePane2,
	#superclass : #WizardPane2,
	#instVars : [
		'nextButton',
		'previousButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardMiddlePane2 >> displayButtons [

	self buttons: {cancelButton. previousButton := self newPreviousButton. nextButton := self newNextButton . }.
]

{ #category : #'initialize-release' }
WizardMiddlePane2 >> initialize [ 
	
	super initialize.
	self diplayButtons 
]

{ #category : #actions }
WizardMiddlePane2 >> nextButtonAction [


	blocksAndInformationsAssociated keysAndValuesDo: [:key :value | wizardControl setValue: key informationValue  toInformation: value ].
	wizardControl performNextButtonAction .
]

{ #category : #actions }
WizardMiddlePane2 >> previousButtonAction [

	wizardControl performPreviousButtonAction .
]
