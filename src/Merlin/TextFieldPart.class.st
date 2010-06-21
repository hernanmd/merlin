Class {
	#name : #TextFieldPart,
	#superclass : #WizardPart,
	#instVars : [
		'textField',
		'textEntryContents',
		'useRequiredInputAsDefault',
		'defaultBlock',
		'prefix',
		'suffix',
		'returnSuffixAndPrefix'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'instance creation' }
TextFieldPart class >> inGroupboxNamed: aString [

	^ super new inGroupboxNamed: aString.
]

{ #category : #accessing }
TextFieldPart >> defaultBlock: aBlock [
	
	"this method enable to compute the default text by computing the value of a block. Using a block is usefull, for example, to specify required value in its contents. Since this block will only be evaluated when this part will retrieve its required inputs, all will works well"
	defaultBlock := aBlock.
]

{ #category : #'initialize-release' }
TextFieldPart >> initialize [ 

	super initialize.
	textField := self newTextEntry. 
	returnSuffixAndPrefix := false.
	
]

{ #category : #'initialize-release' }
TextFieldPart >> initialize: defaultText [

	self initialize.
	self textEntryContents: defaultText
	
]

{ #category : #accessing }
TextFieldPart >> latePopulateContents [
	
	|default morphContents|
	defaultValue isSymbol 
		ifTrue: [default := defaultValue ]
		ifFalse: [default := defaultValue meValue: self requiredInputs.].
	
	prefix isNil
		ifTrue: [
			suffix isNil
				ifTrue: [morphContents := self textField]
				ifFalse: [morphContents := self newRowWith: {self textField . ((self newLabel:suffix) disable; yourself) }]
			]
		ifFalse: [
			suffix isNil
				ifTrue: [morphContents := self newRowWith: {(self newLabel: prefix) disable; yourself . self textField}]
				ifFalse: [morphContents := self newRowWith: {(self newLabel: prefix) disable; yourself . self textField . (self newLabel:suffix) disable; yourself }]
			].
		
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: morphContents}.]
		ifNil: [self populateContents: { morphContents }].
				
	default ifNotNilDo: [:aString |
		self textEntryContents: aString 	
		]. 
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
		hResizing: #spaceFill"#rigid";
		vResizing: #rigid;
		borderStyle: (BorderStyle inset width: 1);
		color: Color white;
		"selectionColor: self selectionColor;"
		hideScrollBarsIndefinitely;
		extent: 24@ (Preferences standardDefaultTextFont height + 8);
		"setBalloonText: helpText."
		yourself.
	pt textMorph
		autoFit: true;
		wrapFlag: false;
		margins: (2@1 corner: 2@1).
		
	^ pt.
]

{ #category : #'accessing - wizard mangement' }
TextFieldPart >> outputValue [ 

		"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
		"textField  acceptTextInModel."
		"^ textEntryContents ."
		"^textField textMorph asText"
		returnSuffixAndPrefix 
			ifTrue: [
				^ prefix, (ObjectStringConverter forClass: String) stringAsObject: textField textMorph asText asString , suffix. 
				]
			ifFalse: [
				^ (ObjectStringConverter forClass: String) stringAsObject: textField textMorph asText asString
				]
		
]

{ #category : #accessing }
TextFieldPart >> prefix: aString [

	prefix := aString.
]

{ #category : #'accessing - wizard mangement' }
TextFieldPart >> retrieveInputRequired [
	"this method is an abstract method as only the subclass itself know what to do with the input that it needs to make its work "
	"by default do nothing"
	"make here all the thing required to build or make run this wizard part. This method will be clalled by wizardPane before opening the 'page'"
		

	
]

{ #category : #accessing }
TextFieldPart >> returnSuffixAndPrefix: trueOrFalse [

	returnSuffixAndPrefix := trueOrFalse. 
]

{ #category : #accessing }
TextFieldPart >> suffix: aString [

	suffix := aString.
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
TextFieldPart >> textFieldHorizontalSize: anInteger [ 

	textField 
		hResizing: #rigid;
		width: anInteger .
]

{ #category : #accessing }
TextFieldPart >> useRequiredInputAsDefault: trueOrFalse [

	useRequiredInputAsDefault := trueOrFalse.
]
