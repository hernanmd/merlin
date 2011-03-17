Class {
	#name : #MerlinMorphDroplListWidget,
	#superclass : #MerlinMorphPartWidget,
	#instVars : [
		'dropList'
	],
	#category : #'Merlin-Rendering'
}

{ #category : #'accessing - morph contents' }
MerlinMorphDroplListWidget >> dropList [

	^ dropList ifNil: [dropList := self newDropListOn: self wizardPart ]
]

{ #category : #'accessing - morph contents' }
MerlinMorphDroplListWidget >> setMorphSize [

	self wizardPart horizontalSize isNil ifFalse: [
		(self dropList)
		hResizing: #rigid;
		vResizing: #shrinkWrap;
		width: self wizardPart horizontalSize
		].
]

{ #category : #'accessing - morph contents' }
MerlinMorphDroplListWidget >> specificMorphContents [ 

	self setMorphSize.
	^ self dropList 
]
