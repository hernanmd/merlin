Class {
	#name : #WizardFirstPane,
	#superclass : #WizardPane,
	#instVars : [
		'nextButton'
	],
	#category : #Merlin
}

{ #category : #actions }
WizardFirstPane >> disableNextButton [

	""
	nextButton disable.
]

{ #category : #'private - accessing' }
WizardFirstPane >> displayButtons [
	"add buttons to the dialogWindow. each subclass now which buttons have to be added to their dialogWindow"
	
	self buttons: { cancelButton. nextButton:= self newNextButton  
	}
]

{ #category : #actions }
WizardFirstPane >> enableNextButton [

	""
	nextButton enable.
	
]

{ #category : #'initialize-release' }
WizardFirstPane >> initialize [

	super initialize .
	nextButton := self newNextButton .
	
	
]
