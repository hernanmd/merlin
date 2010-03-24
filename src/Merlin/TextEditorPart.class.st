Class {
	#name : #TextEditorPart,
	#superclass : #WizardPart,
	#instVars : [
		'contents',
		'textEditorContents',
		'textEditor'
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

	^ textEditor := (self newTextEditorFor: self getText: #textEditorContents setText: #textEditorContents:)
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
		

]

{ #category : #'accessing - wizard mangement' }
TextEditorPart >> outputValue [

	"^ self textEditorContents."
	^ (ObjectStringConverter forClass: String) stringAsObject: textEditor textMorph asText asString
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

{ #category : #accessing }
TextEditorPart >> textEditorHorizontalSize: anInteger [ 

	textEditor 
		hResizing: #rigid;
		width: anInteger .
]

{ #category : #accessing }
TextEditorPart >> textEditorVerticalSize: anInteger [ 

	textEditor 
		vResizing: #rigid;
		height: anInteger .
]
