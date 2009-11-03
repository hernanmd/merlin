Class {
	#name : #TestDropListBlock,
	#superclass : #WizardPart,
	#instVars : [
		'model'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
TestDropListBlock class >> on: aCollectionOfItems. [

	^ super new initialize; list: aCollectionOfItems .  
]

{ #category : #'instance creation' }
TestDropListBlock class >> on: aCollectionOfItems inGroupboxNamed: aString. [
	"the drop list will be put into a groupbox named aString. by default it is put into a groupbox named 'Choose an item'"

	^ super new initialize; list: aCollectionOfItems inGroupboxNamed: aString.  
]

{ #category : #'accessing - wizard mangement' }
TestDropListBlock >> informationValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	^ model list at: model selectionIndex  .
]

{ #category : #'initialize-release' }
TestDropListBlock >> initialize [

	super initialize.
	
]

{ #category : #'accessing - morph' }
TestDropListBlock >> list: aCollectionOfItems [

	self contents: {self newGroupboxNamed: 'Choose an item' With: (self newDropListFor: aCollectionOfItems)} .
]

{ #category : #'accessing - morph' }
TestDropListBlock >> list: aCollectionOfItems inGroupboxNamed: aString [

	self contents: {self newGroupboxNamed: aString With: (self newDropListFor: aCollectionOfItems)} .
]

{ #category : #'morph content setup tools' }
TestDropListBlock >> newDropListFor: aCollectionOfItems [
"^(DropListMorph
			on: (model := (ListModel new packagesList: aCollectionOfItems ))
			list: #list
			selected: #selectionIndex
			changeSelected: #selectionIndex:)"
			
| dropList |
dropList := (DropListMorph
			on: (model := (ListModel new packagesList: aCollectionOfItems ))
			list: #list
			selected: #selectionIndex
			changeSelected: #selectionIndex:
			useIndex: true)
		"selectionColor: self selectionColor;"
		"getEnabledSelector: enabledSel;"
		"font: self dropListFont;"
		cornerStyle: #rounded;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
		"setBalloonText: helpText"
		
	model selectionIndex: 1.
	^ dropList.
	
]
