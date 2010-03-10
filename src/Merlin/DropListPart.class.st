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
	#category : #Merlin
}

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems [ 
	^ self new
		initialize; listContents: aCollectionOfItems ; yourself
]

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString [ 
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; yourself
]

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString defaultItemSelected: anItem [
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; defaultItemSelected: anItem ;  yourself
]

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString defaultSelected: anIndex [
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; defaultIndexSelected: anIndex ;  yourself
]

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString defaultSelectedBlock: aBlock [
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; defaultBlock: aBlock ;useRequiredInputAsDefault: true ;   yourself
]

{ #category : #accessing }
DropListPart >> defaultBlock: aBlock [
"this method enable to compute the default text by computing the value of a block. Using a block is usefull, for example, to specify required value in its contents. Since this block will only be evaluated when this part will retrieve its required inputs, all will works well"
	defaultBlock := aBlock.
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
	useRequiredInputAsDefault := false.
	
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

	self contents: { (self newDropListSelfControllingFor: aCollectionOfItems)} .
]

{ #category : #'morph content setup tools' }
DropListPart >> newDropListFor: aCollectionOfItems [
			
	| dropList |
	dropList := (DropListMorph
			on: (model := (ListModel new list: aCollectionOfItems ))
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
		
	model selectionIndex: 1.
	^ dropList.
	
]

{ #category : #'morph content setup tools' }
DropListPart >> newDropListSelfControllingFor: aCollectionOfItems [
			
	self list: aCollectionOfItems .
	self selectionIndex: 1.
	dropList := (DropListMorph
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
		
	
	^ dropList.
	
]

{ #category : #'accessing - wizard mangement' }
DropListPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	^ self list at: self selectionIndex
]

{ #category : #'accessing - wizard mangement' }
DropListPart >> retrieveInputRequired [
	"this method is an abstract method as only the subclass itself know what to do with the input that it needs to make its work "
	"by default do nothing"
	"make here all the thing required to build or make run this wizard part. This method will be clalled by wizardPane before opening the 'page'"
		

	useRequiredInputAsDefault ifTrue: [
		self selectionIndex: (defaultBlock valueWithArguments: {self.}).
		]
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

{ #category : #accessing }
DropListPart >> useRequiredInputAsDefault: trueOrFalse [

	useRequiredInputAsDefault := trueOrFalse.
]
