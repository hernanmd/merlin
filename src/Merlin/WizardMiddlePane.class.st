Class {
	#name : #WizardMiddlePane,
	#superclass : #WizardPane,
	#instVars : [
		'nextButton',
		'previousButton'
	],
	#category : #Merlin
}

{ #category : #'private - accessing' }
WizardMiddlePane >> displayButtons [

	self buttons: {cancelButton. previousButton := self newPreviousButton. nextButton := self newNextButton . }.
]

{ #category : #'initialize-release' }
WizardMiddlePane >> initialize [ 
	
	super initialize.

]
