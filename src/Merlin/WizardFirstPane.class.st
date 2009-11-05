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

	"by default (if no next button is define, do nothing)"
	nextButton disable
]

{ #category : #'private - accessing' }
WizardFirstPane >> displayButtons [
	"add buttons to the dialogWindow. each subclass now which buttons have to be added to their dialogWindow"
	
	self buttons: { cancelButton. nextButton:= self newNextButton  
	}
]

{ #category : #actions }
WizardFirstPane >> enableNextButton [

	"by default if no next button is defined, do nothing"
	nextButton enable.
	
]

{ #category : #'initialize-release' }
WizardFirstPane >> initialize [

	super initialize .
	nextButton := self newNextButton .
	
	
]
