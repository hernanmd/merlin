Class {
	#name : #WizardFirstPane2,
	#superclass : #WizardPane2,
	#instVars : [
		'nextButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardFirstPane2 >> displayButtons [
	"add buttons to the dialogWindow. each subclass now which buttons have to be added to their dialogWindow"
	
	self buttons: { cancelButton. nextButton:= self newNextButton  
	}
]

{ #category : #'initialize-release' }
WizardFirstPane2 >> initialize [

	super initialize .
	nextButton := self newNextButton .
	
	
]

{ #category : #actions }
WizardFirstPane2 >> nextButtonAction [

	"self subclassResponsibility ."
	blocksAndInformationsAssociated keysAndValuesDo: [:key :value | wizardControl setValue: key informationValue  toInformation: value ].
	wizardControl performNextButtonAction .
]
