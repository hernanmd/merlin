Class {
	#name : #TextPart,
	#superclass : #WizardPart,
	#category : #Merlin
}

{ #category : #'instance creation' }
TextPart class >> on: stringText inGroupBoxNamed: groupBoxName [

	^ super new initializeWith: stringText inGrouopboxNamed: groupBoxName;yourself. 
]

{ #category : #'initialize-release' }
TextPart >> initializeWith: stringText inGrouopboxNamed: groupBoxName [

	self populateContents: { self newGroupboxNamed: groupBoxName  With: (self newText: stringText) }
]

{ #category : #'accessing - wizard mangement' }
TextPart >> outputValue [ 

	^ nil
]
