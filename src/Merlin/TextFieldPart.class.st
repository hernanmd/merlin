Class {
	#name : #TextFieldPart,
	#superclass : #WizardPart,
	#instVars : [
		'textField',
		'textEntryContents',
		'useRequiredInputAsDefault',
		'defaultBlock'
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

{ #category : #'instance creation' }
TextFieldPart class >> inGroupboxNamed: aString withComputedDefaultText: aBlock [

	^ super new inGroupboxNamed: aString  ; defaultBlock: aBlock ; useRequiredInputAsDefault: true ; yourself.
]

{ #category : #'instance creation' }
TextFieldPart class >> usingRequiredInputAsDefaultInGroupboxNamed: aString [ 

	^ super new inGroupboxNamed: aString  ; useRequiredInputAsDefault: true ; yourself.
]

{ #category : #accessing }
TextFieldPart >> defaultBlock: aBlock [
"this method enable to compute the default text by computing the value of a block. Using a block is usefull, for example, to specify required value in its contents. Since this block will only be evaluated when this part will retrieve its required inputs, all will works well"
	defaultBlock := aBlock.
]

{ #category : #'initialize-release' }
TextFieldPart >> inGroupboxNamed: aString [

	self populateContents: {self newGroupboxNamed: aString With: self newTextEntry }.
]

{ #category : #'initialize-release' }
TextFieldPart >> initialize [ 

	super initialize.
	useRequiredInputAsDefault := false.
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
		"textField  acceptTextInModel."
		"^ textEntryContents ."
		"^textField textMorph asText"
		^ (ObjectStringConverter forClass: String) stringAsObject: textField textMorph asText asString
]

{ #category : #'accessing - wizard mangement' }
TextFieldPart >> retrieveInputRequired [
	"this method is an abstract method as only the subclass itself know what to do with the input that it needs to make its work "
	"by default do nothing"
	"make here all the thing required to build or make run this wizard part. This method will be clalled by wizardPane before opening the 'page'"
		

	useRequiredInputAsDefault ifTrue: [
		self textEntryContents: (defaultBlock valueWithArguments: {self.}).
		textField  acceptTextInModel .
		]
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
	wizardPane ifNotNil: 
		[self hasChanged ].
	self changed: #textEntryContents.
	
]

{ #category : #accessing }
TextFieldPart >> textField [ 
	^ textField 
]

{ #category : #accessing }
TextFieldPart >> useRequiredInputAsDefault: trueOrFalse [

	useRequiredInputAsDefault := trueOrFalse.
]
