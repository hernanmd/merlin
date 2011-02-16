Class {
	#name : #NumberSelectorPart,
	#superclass : #DropListPart,
	#category : #'Merlin-Examples'
}

{ #category : #'initialize-release' }
NumberSelectorPart >> initialize [
	super initialize .
	self listContents:  {1. 2. 3. 4. 5. 6. 7. 8. 9.}.
]
