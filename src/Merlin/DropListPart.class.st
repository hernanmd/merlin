Class {
	#name : #DropListPart,
	#superclass : #WizardPart,
	#instVars : [
		'model',
		'list',
		'selectionIndex',
		'useRequiredInputAsDefault',
		'defaultBlock',
		'dropList'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems [ 
	^ self new
		initialize; listContents: aCollectionOfItems ; yourself
]

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString defaultSelected: anIndex [
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; defaultIndexSelected: anIndex ;  yourself
]

{ #category : #'accessing - morph' }
DropListPart >> defaultIndexSelected: anIndex [

	self selectionIndex: anIndex
]

{ #category : #'accessing - morph' }
DropListPart >> defaultItemSelected: anItem [

	self selectionIndex: (self list indexOf: anItem)
]

{ #category : #accessing }
DropListPart >> dropList [

	^ dropList
]

{ #category : #accessing }
DropListPart >> horizontalSize: anInteger [

	"if the default size (computed according your wizard global size) doesn't correspond to what you were expecting, you this method to fix yourself the width of the dropListMorph"
	dropList 
		hResizing: #rigid;
		vResizing: #spaceFill;
		width: anInteger.
]

{ #category : #'initialize-release' }
DropListPart >> initialize [ 

	super initialize.
	self initializeDropList.
	
]

{ #category : #'initialize-release' }
DropListPart >> initializeDropList [

	dropList := self newDropListSelfControllingFor: {''}.
	
]

{ #category : #accessing }
DropListPart >> latePopulateContents [
	
	|default|
	default := defaultValue meValue: self requiredInputs.
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: self dropList}.]
		ifNil: [self populateContents: {self dropList}].
	
	default ifNotNilDo: [:anIndexOrAnObject |
		anIndexOrAnObject isNumber 
			ifTrue: [self selectionIndex: anIndexOrAnObject ]
			ifFalse: [self selectionIndex: (self list indexOf: anIndexOrAnObject)].	
		]. 
	
	
]

{ #category : #'list control' }
DropListPart >> list [
	"Answer the value of list"

	^ list
]

{ #category : #'list control' }
DropListPart >> list: anObject [
	"Set the value of list"

	list := anObject.
	self changed: #list
]

{ #category : #'accessing - morph' }
DropListPart >> list: aCollectionOfItems inGroupboxNamed: aString [

	self populateContents: {self newGroupboxNamed: aString With: (self newDropListSelfControllingFor: aCollectionOfItems)} .
]

{ #category : #'accessing - morph' }
DropListPart >> listContents: aCollectionOfItems [

	self populateContents: { (self newDropListSelfControllingFor: aCollectionOfItems)} .
]

{ #category : #'morph content setup tools' }
DropListPart >> newDropListSelfControllingFor: aCollectionOfItems [
			
	|morph|
	"self list: aCollectionOfItems .
	aCollectionOfItems ifEmpty: [
		self list: {''} .
		]."
	self list: aCollectionOfItems. 
	self selectionIndex: 1.
	morph := (DropListMorph
			on: (self)
			list: #list
			selected: #selectionIndex
			changeSelected: #selectionIndex:
			useIndex: true)
		"selectionColor: self selectionColor;"
		"getEnabledSelector: enabledSel;"
		"font: self dropListFont;"
		cornerStyle: #rounded;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		"setBalloonText: helpText"
		yourself.
		
	
	^ morph.
	
]

{ #category : #'accessing - wizard mangement' }
DropListPart >> outputValue [

	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	self list ifNotNilDo: [: Name  | ^ list at: self selectionIndex]
]

{ #category : #'accessing - wizard mangement' }
DropListPart >> retrieveInputRequired [
	"this method is an abstract method as only the subclass itself know what to do with the input that it needs to make its work "
	"by default do nothing"
	"make here all the thing required to build or make run this wizard part. This method will be clalled by wizardPane before opening the 'page'"
		
]

{ #category : #'list control' }
DropListPart >> selectedItem [
	"Answer the currently selected item or nil if none."

	^self selectionIndex = 0
		ifTrue: [nil]
		ifFalse: [self list at: self selectionIndex]
]

{ #category : #'list control' }
DropListPart >> selectionIndex [
	"Answer the value of selectionIndex"

	^ selectionIndex
]

{ #category : #'list control' }
DropListPart >> selectionIndex: anObject [
	"Set the value of selectionIndex"

	selectionIndex := anObject.
	self hasChanged .
	self changed: #selectionIndex
]
