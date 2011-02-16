Class {
	#name : #OperatorSelectorPart,
	#superclass : #DropListPart,
	#category : #'Merlin-Examples'
}

{ #category : #'initialize-release' }
OperatorSelectorPart >> initialize [
	super initialize.
	self listContents:  {'+'. '-'. '/'. '*'}.
]
