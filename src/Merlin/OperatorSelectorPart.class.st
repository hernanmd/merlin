Class {
	#name : #OperatorSelectorPart,
	#superclass : #DropListPart,
	#category : #Merlin
}

{ #category : #'initialize-release' }
OperatorSelectorPart >> initialize [
	super initialize.
	self listContents:  {'+'. '-'. '/'. '*'}.
]
