Class {
	#name : #MerlinMorphRadioButtonsWidget,
	#superclass : #MerlinMorphPartWidget,
	#instVars : [
		'radioButtons',
		'labelsAndModels'
	],
	#category : #'Merlin-Rendering'
}

{ #category : #'accessing - morph' }
MerlinMorphRadioButtonsWidget >> initializeRadioButtons [

	radioButtons := 
			self wizardPart options collect: [:aSymbol |
				|radioButton|
				self labelsAndModels at: aSymbol put: (ValueHolder new contents: false; yourself).
				radioButton := (self newRadionButtonFor: (self labelsAndModels at: aSymbol) getSelected: #contents  setSelected: #contents:  label: aSymbol).
				radioButton	 buttonMorph
						target: self;
						actionSelector: #updateButtonsWhenChangesOn:;
						arguments: {  aSymbol  }.
				radioButton 
			].
		
	^ radioButtons 
		
]

{ #category : #'accessing - morph' }
MerlinMorphRadioButtonsWidget >> labelsAndModels [ 

	^ labelsAndModels ifNil: [
		labelsAndModels := Dictionary new
		]
]

{ #category : #'accessing - morph' }
MerlinMorphRadioButtonsWidget >> radioButtons [

	^ radioButtons ifNil: [
		self initializeRadioButtons.
		]
]

{ #category : #rendering }
MerlinMorphRadioButtonsWidget >> specificMorphContents [ 

	self initializeRadioButtons.
	(self labelsAndModels at: self wizardPart option) contents: true.
	^ self newColumnWith: self radioButtons  
	
]

{ #category : #'accessing - morph' }
MerlinMorphRadioButtonsWidget >> updateButtonsWhenChangesOn: aLabel [

	|buttonContents|
	buttonContents := (self labelsAndModels at: aLabel) contents.
	self labelsAndModels keysAndValuesDo: [:aSymbol :aModel |
		aSymbol = aLabel ifFalse: [(self labelsAndModels at: aSymbol) contents: false].
		]. 
	self wizardPart updateButtonsWhenChangesOn: aLabel withContents: true 
]
