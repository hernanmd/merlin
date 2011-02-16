Class {
	#name : #WizardFirstPane,
	#superclass : #WizardPane,
	#instVars : [
		'nextButton'
	],
	#category : #'Merlin-Panes'
}

{ #category : #actions }
WizardFirstPane >> disableNextButton [
	nextButton disable.
]

{ #category : #'private - accessing' }
WizardFirstPane >> displayButtons [
	"add buttons to the dialogWindow. each subclass now which buttons have to be added to their dialogWindow"
	
	nextButton := self newNextButton. 
	self buttons: {cancelButton . nextButton}
]

{ #category : #actions }
WizardFirstPane >> enableNextButton [

	nextButton enable.
	
]

{ #category : #'initialize-release' }
WizardFirstPane >> initialize [

	super initialize.
	nextButton := self newNextButton.
	
	
]
