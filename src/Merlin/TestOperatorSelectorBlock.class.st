Class {
	#name : #TestOperatorSelectorBlock,
	#superclass : #TestDropListBlock,
	#category : #Merlin
}

{ #category : #'initialize-release' }
TestOperatorSelectorBlock >> initialize [

	self list: {'+'. '-'. '/'. '*'}.
]
