Class {
	#name : #MerlinMorphMultiPartsWidget,
	#superclass : #MerlinMorphPartWidget,
	#instVars : [
		'tabGroup'
	],
	#category : #'Merlin-Rendering'
}

{ #category : #'accessing - wizard management' }
MerlinMorphMultiPartsWidget >> populateWizardPartOutput [ 

	self wizardPart selectedPageIndex: self tabGroup selectedPageIndex.
	self wizardPart outputValue: self selectedPart outputValue
]

{ #category : #'accessing - wizard management' }
MerlinMorphMultiPartsWidget >> selectedPart [

	^ (self wizardPart titlesAndParts at: self tabGroup selectedPageIndex) value.  

	
]

{ #category : #'accessing - morph contents' }
MerlinMorphMultiPartsWidget >> specificMorphContents [ 

	self tabGroup selectedPageIndex: self wizardPart selectedPageIndex.   
	^ self tabGroup 
]

{ #category : #'accessing - morph contents' }
MerlinMorphMultiPartsWidget >> tabGroup [

	^ tabGroup ifNil: [
		tabGroup := self newTabGroupBoxFor: (self wizardPart titlesAndParts collect: [:anAssoc | anAssoc key -> anAssoc value merlinRendering morphContents ])
		].
]
