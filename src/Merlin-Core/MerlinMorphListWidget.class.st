Class {
	#name : #MerlinMorphListWidget,
	#superclass : #MerlinMorphPartWidget,
	#instVars : [
		'list',
		'listMorph'
	],
	#category : #'Merlin-Rendering'
}

{ #category : #'accessing - morph contents' }
MerlinMorphListWidget >> listMorph [

	^ listMorph ifNil: [listMorph := self newNormalListFor: self wizardPart  list: #list selected: #selectionIndex changeSelected: #selectionIndex:]
]

{ #category : #'accessing - morph contents' }
MerlinMorphListWidget >> setMorphSize [

	self wizardPart horizontalSize isNil ifFalse: [
		self listMorph minWidth: self wizardPart listWidth
		].
	self wizardPart verticalSize isNil ifFalse: [
		self listMorph minHeight: self wizardPart minHeight
		].
]

{ #category : #'accessing - morph contents' }
MerlinMorphListWidget >> specificMorphContents [ 

	self setMorphSize.
	^ self listMorph

]
