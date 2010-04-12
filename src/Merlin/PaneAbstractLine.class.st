Class {
	#name : #PaneAbstractLine,
	#superclass : #Object,
	#instVars : [
		'parts',
		'pane',
		'partGroups'
	],
	#category : #'Merlin-PartsLayout'
}

{ #category : #'instance creation' }
PaneAbstractLine class >> fromPane: aWizardPane [

	^ super new pane: aWizardPane
]

{ #category : #'accessing - parts' }
PaneAbstractLine >> genericAdd: aBlockOrAPart [

	 ^ self subclassResponsibility 
]

{ #category : #'initialize-release' }
PaneAbstractLine >> initialize [

	parts := OrderedCollection new.
	partGroups := OrderedCollection new.
]

{ #category : #'morph tools' }
PaneAbstractLine >> newColumnWith: aCollectionOfMorphElements [
	"use this method to create a new column in your block"
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	
	|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
]

{ #category : #'morph tools' }
PaneAbstractLine >> newRowWith: aCollectionOfMorphElements [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	"use this method to create a new row in your block"
	
	|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
]

{ #category : #accessing }
PaneAbstractLine >> pane [

	^ pane  
]

{ #category : #accessing }
PaneAbstractLine >> pane: aWizardPane [

	pane := aWizardPane 
]

{ #category : #'accessing - parts' }
PaneAbstractLine >> partGroups [
	
	^ partGroups
]

{ #category : #'accessing - parts' }
PaneAbstractLine >> parts [ 
	
	^ parts
]
