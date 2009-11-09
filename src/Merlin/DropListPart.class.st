Class {
	#name : #DropListPart,
	#superclass : #WizardPart,
	#instVars : [
		'model'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems [ 
	^ self new
		initialize;
		list: aCollectionOfItems ; yourself
]

{ #category : #'instance creation' }
DropListPart class >> on: aCollectionOfItems inGroupboxNamed: aString [ 
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"
	^ self new
		initialize;
		list: aCollectionOfItems
			inGroupboxNamed: aString ; yourself
]

{ #category : #'accessing - morph' }
DropListPart >> list: aCollectionOfItems [

	self contents: {self newGroupboxNamed: 'Choose an item' With: (self newDropListFor: aCollectionOfItems)} .
]

{ #category : #'accessing - morph' }
DropListPart >> list: aCollectionOfItems inGroupboxNamed: aString [

	self contents: {self newGroupboxNamed: aString With: (self newDropListFor: aCollectionOfItems)} .
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

{ #category : #'accessing - wizard mangement' }
DropListPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	^ model list at: model selectionIndex
]
