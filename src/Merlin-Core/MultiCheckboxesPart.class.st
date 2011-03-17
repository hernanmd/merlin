Class {
	#name : #MultiCheckboxesPart,
	#superclass : #CheckboxPart,
	#instVars : [
		'checkboxParts',
		'answer',
		'labels'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'instance creation' }
MultiCheckboxesPart class >> withAll: aCollectionOfLabels [ 

	^ super new initialize: aCollectionOfLabels .
]

{ #category : #'morph content setup tools' }
MultiCheckboxesPart >> addVerticalSeparatorAtTheMiddleOf: aCollectionOfElements [

	"return a collection containing all initials morph elements from aCollectionOfElements including a vertical separator at the middle"
	|  index result result1 result2 collectionSize |
	collectionSize := aCollectionOfElements size.
	collectionSize even 
		ifTrue: [index :=  collectionSize // 2.]
		ifFalse: [index :=  collectionSize // 2 + 1.].
	
	result := OrderedCollection new.
	result1 := OrderedCollection new.
	result2 := OrderedCollection new.
	1 to: (index ) do: [:i | result1 add: (aCollectionOfElements at: i)].
	
	(index + 1) to: aCollectionOfElements size do: [:i | result2 add: (aCollectionOfElements at: i)].
	result add: (self newColumnWith:  result1 ); add: (self  newVerticalSeparator) ; add: (self newColumnWith:  result2 ). 
	^ result.
]

{ #category : #accessing }
MultiCheckboxesPart >> checkboxParts [

	^ checkboxParts
]

{ #category : #accessing }
MultiCheckboxesPart >> checkboxParts: aCollectionOfCheckboxPart [

	checkboxParts := aCollectionOfCheckboxPart
]

{ #category : #accessing }
MultiCheckboxesPart >> contents [

	^ self checkboxParts collect: [:each | each contents]  
]

{ #category : #accessing }
MultiCheckboxesPart >> contents: aCollectionOfBoolean [

	aCollectionOfBoolean with: self checkboxParts  do: [:aBoolean :aCheckboxPart |
		aCheckboxPart contents: aBoolean
		].
]

{ #category : #'initialize-release' }
MultiCheckboxesPart >> initialize: aCollectionOfLabels [

	| elements |
	allCheckboxes := OrderedCollection new.
	aCollectionOfLabels do: [:each |
		allCheckboxes add:
			(self 
				newCheckboxFor: (ValueHolder new contents: true) 
				getSelected: #contents 
				setSelected: #contents: 
				label: each).
		].
	
	elements := self addVerticalSeparatorAtTheMiddleOf: allCheckboxes .
	
	self contents:  {self newRowWith: elements} .
	
]

{ #category : #'initialize-release' }
MultiCheckboxesPart >> initialize: aCollectionOfLabels inGroupBoxNamed: aName [

	| elements |
	allCheckboxes := OrderedCollection new.
	aCollectionOfLabels do: [:each |
		self 
			newCheckboxFor: (ValueHolder new contents: true) 
			getSelected: #contents 
			setSelected: #contents: 
			label: each.
		].
	
	elements := self addVerticalSeparatorAtTheMiddleOf: allCheckboxes .
	
	self contents: {self newGroupboxNamed: aName  WithAll: elements}
	
]

{ #category : #'initialize-release' }
MultiCheckboxesPart >> initializeFromLabels: aCollectionOfString [

	"initialize the checkboxParts variable with a new CheckboxPart for each label-string in aCollectionOfString "
	|tmpParts|
	tmpParts := OrderedCollection new.
	aCollectionOfString do: [:aString |
		tmpParts add: (
			CheckboxPart new label: aString; parentComposite: self; yourself
			).
		].
	self checkboxParts: tmpParts.  
]

{ #category : #accessing }
MultiCheckboxesPart >> labels [ 

	^ labels
]

{ #category : #accessing }
MultiCheckboxesPart >> labels: aCollectionOfString [

	self initializeFromLabels: aCollectionOfString.  
	labels := aCollectionOfString
]

{ #category : #accessing }
MultiCheckboxesPart >> latePopulateContents [ 

	self checkboxParts do: [:each |
		each wizardPane: self wizardPane.
		each latePopulateContents.
		]  
]

{ #category : #'*merlin-rendering' }
MultiCheckboxesPart >> merlinRendering [

	^ self renderer merlinMultiCheckboxesRenderingFor: self
]

{ #category : #'morph content setup tools' }
MultiCheckboxesPart >> newVerticalSeparator [
	"Answer a new vertical separator."

	^SeparatorMorph new
		fillStyle: Color transparent;
		borderStyle: (BorderStyle inset baseColor: Color blue; width: 1);
		extent: 2@2;
		vResizing: #spaceFill
]

{ #category : #'accessing - wizard mangement' }
MultiCheckboxesPart >> outputValue [

	^ self checkboxParts collect: [:each | each label -> each outputValue].
]

{ #category : #'accessing - wizard mangement' }
MultiCheckboxesPart >> selectedItems [

	"return a collection containing symbols corresponding to the checkboxes selected"
	| result |
	result := OrderedCollection new.
	allCheckboxes do: [ :each | each buttonMorph selected ifTrue: [ result add: each label asSymbol ] ].
	^ result
]

{ #category : #'accessing - morph' }
MultiCheckboxesPart >> setActionToCheckboxes: actionSelector withArguments: aCollectionOfArguments [
	"initialize the action to do when clicking on a checkbox. actionSelector must be implemented in this class or its subclasses"
	allCheckboxes do: [ :each | 
		each buttonMorph
				target: self;
				actionSelector: actionSelector ;
				arguments: aCollectionOfArguments  ].
]
