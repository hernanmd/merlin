Class {
	#name : #TextFieldPart,
	#superclass : #WizardPart,
	#instVars : [
		'textField',
		'textEntryContents'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
TextFieldPart class >> inGroupboxNamed: aString [

	^ super new inGroupboxNamed: aString.
]

{ #category : #'instance creation' }
TextFieldPart class >> inGroupboxNamed: aString defaultText: anotherString [

	^ (super new inGroupboxNamed: aString) initialize: anotherString ; yourself.
]

{ #category : #'initialize-release' }
TextFieldPart >> inGroupboxNamed: aString [

	self contents: {self newGroupboxNamed: aString With: self newTextEntry }.
]

{ #category : #'initialize-release' }
TextFieldPart >> initialize [ 

	super initialize.
	"self enableNextButton: false."
]

{ #category : #'initialize-release' }
TextFieldPart >> initialize: defaultText [

	self initialize.
	self textEntryContents: defaultText
	
]

{ #category : #'morph content setup tools' }
TextFieldPart >> newTextEntry [

		
	| pt |
	pt := PluggableTextFieldMorph new
		convertTo: String;
		alwaysAccept: true;
		on: self
		text: #textEntryContents
		accept: #textEntryContents:
		readSelection: nil
		menu: nil;
		acceptOnCR: true;
		"getEnabledSelector: enabledSel;"
		font: Preferences standardDefaultTextFont;
		cornerStyle:  #rounded;
		hResizing: #spaceFill;
		vResizing: #rigid;
		borderStyle: (BorderStyle inset width: 1);
		color: Color white;
		"selectionColor: self selectionColor;"
		hideScrollBarsIndefinitely;
		extent: 24@(Preferences standardDefaultTextFont height + 8);
		"setBalloonText: helpText."
		yourself.
	pt textMorph
		autoFit: true;
		wrapFlag: false;
		margins: (2@1 corner: 2@1).
		
	^ textField := pt.
]

{ #category : #'accessing - wizard mangement' }
TextFieldPart >> outputValue [ 

		"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
		textField  acceptTextInModel.
		^ textEntryContents .
]

{ #category : #'text entry control' }
TextFieldPart >> textEntryContents [
	"return the contents of the text entry "
	^ textEntryContents
]

{ #category : #'text entry control' }
TextFieldPart >> textEntryContents: newContents [ 
	"set the content of the text entry "
	textEntryContents := newContents.
	self changed: #textEntryContents.
	
]
