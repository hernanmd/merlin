Class {
	#name : #WizardMiddlePane,
	#superclass : #WizardPane,
	#instVars : [
		'nextButton'
	],
	#category : #'Merlin-Panes'
}

{ #category : #'private - accessing' }
WizardMiddlePane >> displayButtons [

	nextButton := self newNextButton.
	self buttons: {cancelButton . self newPreviousButton . nextButton}.
]

{ #category : #'*merlin-rendering' }
WizardMiddlePane >> merlinSpecificRenderer [ 

	^ MerlinMorphicMiddlePaneRenderer new .
]

{ #category : #'*merlin-rendering' }
WizardMiddlePane >> renderOnMerlinRenderer: aMerlinRenderer [

	^ aMerlinRenderer renderMerlinMiddlePane: self  
]
