Class {
	#name : #CompositePart,
	#superclass : #WizardPart,
	#instVars : [
		'tabGroup',
		'titlesAndParts'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'accessing - titlesAndParts' }
CompositePart >> addPart: aWizardPart [

	titlesAndParts add: (aWizardPart asString -> aWizardPart ). 
]

{ #category : #'accessing - titlesAndParts' }
CompositePart >> addTitleAndPart: anAssociation [

	titlesAndParts add: anAssociation. 
]

{ #category : #'initialize-release' }
CompositePart >> initializeTabGroup [

 	
	tabGroup := (self
		newTabGroupBoxFor: (self titlesAndParts collect: [:anAssoc | anAssoc key -> anAssoc value morphContents ])).
]

{ #category : #accessing }
CompositePart >> latePopulateContents [

	self titlesAndParts do: [:anAssoc | anAssoc value latePopulateContents].
	self initializeTabGroup. 
	
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: tabGroup}]
		ifNil: [self populateContents: {tabGroup }].
]

{ #category : #'morph content setup tools' }
CompositePart >> newTabGroupBoxFor: labelsAndControls [

	^(LinkedTabGroupMorph  new
		"font: self labelFont;"
		cornerStyle: #rounded;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		labelsAndPages: labelsAndControls)
		selectedPageIndex: (labelsAndControls isEmpty ifTrue: [0] ifFalse: [1])
]

{ #category : #'accessing - wizard management' }
CompositePart >> outputValue [

	^ self selectedPart  value outputValue  
]

{ #category : #'accessing - page selection' }
CompositePart >> selectedPageIndex [

	^ tabGroup selectedPageIndex
]

{ #category : #'accessing - page selection' }
CompositePart >> selectedPageIndex: anIndex [

	^ tabGroup selectedPageIndex: anIndex 
]

{ #category : #'accessing - page selection' }
CompositePart >> selectedPart [

	^ self titlesAndParts at: self selectedPageIndex
]

{ #category : #'accessing - titlesAndParts' }
CompositePart >> titlesAndParts [

	^ titlesAndParts  
]

{ #category : #'accessing - titlesAndParts' }
CompositePart >> withParts: aCollectionOfWizardParts [

	titlesAndParts := aCollectionOfWizardParts collect: [:aWizardPart | (aWizardPart asString -> aWizardPart) ]. 
]

{ #category : #'accessing - titlesAndParts' }
CompositePart >> withTitlesAndParts: aCollectionOfAssociations [

	titlesAndParts := aCollectionOfAssociations. 
]
