Class {
	#name : #PaneColumn,
	#superclass : #PaneAbstractLine,
	#category : #'Merlin-PartsLayout'
}

{ #category : #'accessing - parts' }
PaneColumn >> genericAdd: aBlockOrAPart [

	^ self row: aBlockOrAPart 
]

{ #category : #'accessing - morph contents' }
PaneColumn >> morphContents [

	"self parts size > 1
		ifFalse: [
			^ self newColumnWith: {self parts first contents}
			]
		ifTrue: [
			^ self newColumnWith: (self parts collect: [:aWizardPart | self newRowWith: {aWizardPart contents} ])
			]."
		
	^ self newColumnWith: (self partGroups collect: [:aPaneLine | self newRowWith: {aPaneLine morphContents}])
]

{ #category : #'accessing - parts' }
PaneColumn >> row: aBlockOrAPart [


	(aBlockOrAPart isKindOf: WizardPart)
		ifTrue: [
			partGroups add: aBlockOrAPart.
			self pane setPart: aBlockOrAPart. 
			].
	(aBlockOrAPart isKindOf: BlockClosure)
		ifTrue: [
			partGroups add: (aBlockOrAPart value: (PaneRow fromPane: self pane))
			].
	"parts add: aWizardPart" 
]

{ #category : #'accessing - parts' }
PaneColumn >> row: aWizardPart associatedTo: aSymbol [

	partGroups add: aWizardPart.
	self pane setPart: aWizardPart associatedTo: aSymbol. 
	
]

{ #category : #'accessing - parts' }
PaneColumn >> row: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbol [

	partGroups add: aWizardPart.
	self pane setPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbol. 
	
]
