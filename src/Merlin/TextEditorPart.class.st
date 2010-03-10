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

	^ super new initializeInGroupboxNamed: aString withDefaultText: anotherString ; yourself.
]

{ #category : #'initialize-release' }
TextEditorPart >> initializeInGroupboxNamed: aString [

	super initialize.
	self populateContents: {
		self newGroupboxNamed: aString With:
			self newTextEditor. 
	}
]

{ #category : #'initialize-release' }
TextEditorPart >> initializeInGroupboxNamed: aString withDefaultText: anotherString [

	self initializeInGroupboxNamed: aString.
	self textEditorContents: anotherString .
	
]

{ #category : #'morph content setup tools' }
TextEditorPart >> newTextEditor [

	^ (self newTextEditorFor: self getText: #textEditorContents setText: #textEditorContents:)
		hResizing: #rigid;
		vResizing: #rigid;
		extent: 380@ 500 ;
		"width: 255;"
		yourself.

]

{ #category : #'accessing - wizard mangement' }
TextEditorPart >> outputValue [

	^ self textEditorContents.
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
