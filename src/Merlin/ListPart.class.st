Class {
	#name : #ListPart,
	#superclass : #WizardPart,
	#instVars : [
		'list',
		'listMorph',
		'selectionIndex'
	],
	#category : #Merlin
}

{ #category : #'initialize-release' }
ListPart >> initinializeWith: aList inGroupBoxNamed: aString [

	self list: aList .
	aList ifEmpty: [
		self list: {''} .
		].
	self selectionIndex: 1.
	listMorph := self newNormalListFor: self list: list selected: #selectionIndex changeSelected: #selectionIndex.
	
	self populateContents: (self newGroupboxNamed: aString With: listMorph)
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

{ #category : #'accessing - Wizard Management' }
ListPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	self list ifNotNilDo: [:list | ^ list at: self selectionIndex]
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

	^ selectionIndex
]

{ #category : #listControl }
ListPart >> selectionIndex: anObject [
	"Set the value of selectionIndex"

	selectionIndex := anObject.
	self hasChanged .
	self changed: #selectionIndex
]
