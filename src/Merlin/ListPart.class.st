Class {
	#name : #ListPart,
	#superclass : #WizardPart,
	#instVars : [
		'list',
		'listMorph',
		'selectionIndex'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'initialize-release' }
ListPart >> initialize [

	super initialize.
	self list: #().
	listMorph := self newNormalListFor: self list: #list selected: #selectionIndex changeSelected: #selectionIndex:.

]

{ #category : #'initialize-release' }
ListPart >> latePopulateContents [

	|default|
	default := defaultValue meValue: self requiredInputs.
	default ifNotNilDo: [:anIndexOrAnObject |
		anIndexOrAnObject isNumber 
			ifTrue: [self selectionIndex: anIndexOrAnObject ]
			ifFalse: [self selectionIndex: (self list indexOf: anIndexOrAnObject)].	
		]. 
	
	"listMorph := self newNormalListFor: self list: #list selected: #selectionIndex changeSelected: #selectionIndex:."
	
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: listMorph}.]
		ifNil: [self populateContents: {listMorph }].
	
	
	

]

{ #category : #listControl }
ListPart >> list [
	"Answer the value of list"

	^ list
]

{ #category : #listControl }
ListPart >> list: anObject [
	"Set the value of list"

	list := anObject.
	self changed: #list
]

{ #category : #accessing }
ListPart >> listHeight: anInteger [

	self listMorph minHeight: anInteger 
]

{ #category : #accessing }
ListPart >> listMorph [ 

	^ listMorph
]

{ #category : #accessing }
ListPart >> listWidth: anInteger [

	self listMorph minWidth: anInteger 
]

{ #category : #'accessing - Wizard Management' }
ListPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	self list ifNotNilDo: [:tmpList | 
		
		^ "tmpList at:" self selectionIndex]
]

{ #category : #listControl }
ListPart >> selectedItem [
	"Answer the currently selected item or nil if none."

	^self selectionIndex = 0
		ifTrue: [nil]
		ifFalse: [self list at: self selectionIndex]
]

{ #category : #listControl }
ListPart >> selectionIndex [
	"Answer the value of selectionIndex"

	^ selectionIndex ifNil: [0] "if selectionIndex has not been yet initialized, we return 0 to avoid erros".
]

{ #category : #listControl }
ListPart >> selectionIndex: anObject [
	"Set the value of selectionIndex"

	selectionIndex := anObject.
	self changed: #selectionIndex.
	self hasChanged .
]
