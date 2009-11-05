Class {
	#name : #WizardMiddlePane,
	#superclass : #WizardPane,
	#instVars : [
		'nextButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardMiddlePane >> displayButtons [

	self buttons: {cancelButton.  self newPreviousButton. nextButton := self newNextButton . }.
]
