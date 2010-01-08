Class {
	#name : #TextEditorPart,
	#superclass : #WizardPart,
	#instVars : [
		'contents',
		'textEditorContents'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
TextEditorPart class >> inGroupboxNamed: aString [

	^ super new initializeInGroupboxNamed: aString; yourself.
]

{ #category : #'instance creation' }
TextEditorPart class >> inGroupboxNamed: aString defaultText: anotherString [

	^ super new initializeInGroupboxNamed: aString; yourself.
]

{ #category : #'initialize-release' }
TextEditorPart >> initializeInGroupboxNamed: aString [

	super initialize.
	self contents: {
		self newGroupboxNamed: aString With:
			self newTextEditor. 
	}
]

{ #category : #'morph content setup tools' }
TextEditorPart >> newTextEditor [

	^ (self newTextEditorFor: self getText: #textEditorContents setText: #textEditorContents:)
		width: 255;
		yourself.

]

{ #category : #'accessing - wizard mangement' }
TextEditorPart >> outputValue [

	^ self contents.
]

{ #category : #'text editor control' }
TextEditorPart >> textEditorContents [
	^textEditorContents
]

{ #category : #'text editor control' }
TextEditorPart >> textEditorContents: newContents [
	textEditorContents := newContents.
	self changed: #textEditorContents
]
