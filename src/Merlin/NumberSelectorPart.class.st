Class {
	#name : #NumberSelectorPart,
	#superclass : #DropListPart,
	#category : #Merlin
}

{ #category : #'initialize-release' }
NumberSelectorPart >> initialize [
	super initialize .
	self list: {1. 2. 3. 4. 5. 6. 7. 8. 9.}.
]
