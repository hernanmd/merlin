Class {
	#name : #PaneColumn,
	#superclass : #PaneAbstractLine,
	#category : #'Merlin-PartsLayout'
}

{ #category : #'accessing - morph contents' }
PaneColumn >> morphContents [

	"self parts size > 1
		ifFalse: [
			^ self newColumnWith: {self parts first contents}
			]
		ifTrue: [
			^ self newColumnWith: (self parts collect: [:aWizardPart | self newRowWith: {aWizardPart contents} ])
			]."
		
	^ self newColumnWith: (self subComponents collect: [:aPaneLine | self newRowWith: {aPaneLine morphContents}])
]

{ #category : #accessing }
PaneColumn >> removeRowAt: anInteger [

	^ self removeSubComponentAt: anInteger
]

{ #category : #'accessing - parts' }
PaneColumn >> row: aBlockOrAPart [


	(aBlockOrAPart isKindOf: WizardPart)
		ifTrue: [
			subComponents add: aBlockOrAPart.
			self pane setPart: aBlockOrAPart. 
			].
	(aBlockOrAPart isKindOf: BlockClosure)
		ifTrue: [
			|row|
			row := (PaneRow fromPane: self pane).
			"partGroups add: (aBlockOrAPart value: (PaneRow fromPane: self pane))"
			aBlockOrAPart value: row.
			subComponents add: row
			
			].

]

{ #category : #'accessing - parts' }
PaneColumn >> row: aWizardPart associatedTo: aSymbol [

	subComponents add: aWizardPart.
	self pane setPart: aWizardPart associatedTo: aSymbol. 
	
]

{ #category : #'accessing - parts' }
PaneColumn >> row: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbol [

	subComponents add: aWizardPart.
	self pane setPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbol. 
	
]

{ #category : #accessing }
PaneColumn >> rowAt: anInteger [

	^ self subComponentAt: anInteger
]
