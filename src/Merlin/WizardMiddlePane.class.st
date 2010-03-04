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

	nextButton := self newNextButton.
	self buttons: {cancelButton . self newPreviousButton . nextButton}.
]
