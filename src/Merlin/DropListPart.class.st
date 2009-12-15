Class {
	#name : #DropListPart,
	#superclass : #WizardPart,
	#instVars : [
		'model',
		'list',
		'selectionIndex'
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
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString defaultSelected: anIndex [
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; defaultItemSelected: anIndex ;  yourself
]

{ #category : #'accessing - morph' }
DropListPart >> defaultItemSelected: anIndex [
	self selectionIndex: anIndex
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

	self contents: {self newGroupboxNamed: aString With: (self newDropListSelfControllingFor: aCollectionOfItems)} .
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
			
	| dropList |
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
	self changed: #selectionIndex
]
