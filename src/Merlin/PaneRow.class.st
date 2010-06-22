Class {
	#name : #PaneRow,
	#superclass : #PaneAbstractLine,
	#category : #'Merlin-PartsLayout'
}

{ #category : #'accessing - parts' }
PaneRow >> column: aBlockOrAPart [

	(aBlockOrAPart isKindOf: WizardPart)
		ifTrue: [
			partGroups add:  aBlockOrAPart.
			self pane setPart: aBlockOrAPart. 
			].
	(aBlockOrAPart isKindOf: BlockClosure)
		ifTrue: [
			|column|
			column := PaneColumn fromPane: self pane.
			aBlockOrAPart value: column.
			partGroups add: column. 
			"partGroups add: (aBlockOrAPart value: (PaneColumn fromPane: self pane))"
			]
]

{ #category : #'accessing - parts' }
PaneRow >> column: aWizardPart associatedTo: aSymbol [

	partGroups add:  aWizardPart.
	self pane setPart: aWizardPart associatedTo: aSymbol. 
	
]

{ #category : #'accessing - parts' }
PaneRow >> column: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [

	partGroups add:  aWizardPart.
	self pane setPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols. 
	
]

{ #category : #'accessing - parts' }
PaneRow >> genericAdd: aBlockOrAPart [

	^ self column: aBlockOrAPart.
]

{ #category : #'accessing - morph contents' }
PaneRow >> morphContents [

	"self parts size > 1
		ifFalse: [
			^ self newRowWith: {self parts first contents}
			]
		ifTrue: [
			^ self newRowWith: (self parts collect: [:aWizardPart | self newColumnWith: {aWizardPart contents} ])
			]."
		
	^ self newRowWith: (self partGroups collect: [:aPaneLine | self newColumnWith: {aPaneLine morphContents}])
]
