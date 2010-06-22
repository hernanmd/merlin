Class {
	#name : #PaneAbstractLine,
	#superclass : #Object,
	#instVars : [
		'parts',
		'pane',
		'subComponents'
	],
	#category : #'Merlin-PartsLayout'
}

{ #category : #'instance creation' }
PaneAbstractLine class >> fromPane: aWizardPane [

	^ super new pane: aWizardPane
]

{ #category : #'initialize-release' }
PaneAbstractLine >> initialize [

	subComponents := OrderedCollection new.
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
PaneAbstractLine >> numberOfSubComponents [

	^ self subComponents size
]

{ #category : #accessing }
PaneAbstractLine >> pane [

	^ pane  
]

{ #category : #accessing }
PaneAbstractLine >> pane: aWizardPane [

	pane := aWizardPane 
]

{ #category : #accessing }
PaneAbstractLine >> removeSubComponentAt: anInteger [
	"remove the subComponent of this this 'AbstractLine' located at the position an integer "
	| componentToRemove |
	componentToRemove := subComponents at: anInteger.
	subComponents remove: componentToRemove. 
]

{ #category : #accessing }
PaneAbstractLine >> subComponentAt: anInteger [
	"return the subComponent of this this 'AbstractLine' located at the position an integer "
	^ subComponents at: anInteger 
]

{ #category : #accessing }
PaneAbstractLine >> subComponents [
	"return the subComponents of this this 'AbstractLine'. For a row, it will be a collection of PaneColumns composing this row. For a column. it will be a collection of PaneRows composing this row "
	^ subComponents
]
