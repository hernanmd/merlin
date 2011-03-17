Class {
	#name : #RadioButtonsPart,
	#superclass : #WizardPart,
	#instVars : [
		'option',
		'options'
	],
	#category : #'Merlin-Parts'
}

{ #category : #accessing }
RadioButtonsPart >> latePopulateContents [ 

	(self valueOf: self defaultValue) 
		ifNotNilDo: [:aSymbol |
			self option: aSymbol
		]
		ifNil: [
			self option: self options first
			]   
]

{ #category : #'*merlin-rendering' }
RadioButtonsPart >> merlinRendering [

	^ self renderer merlinRadioButtonsRenderingFor: self
]

{ #category : #'control - radio buttons' }
RadioButtonsPart >> option [ 

	^ option
]

{ #category : #'control - radio buttons' }
RadioButtonsPart >> option: aSymbol [
	"Set the value of option"

	option := aSymbol.
	self
		changed: #option.
]

{ #category : #accessing }
RadioButtonsPart >> options [

	^ options.
]

{ #category : #accessing }
RadioButtonsPart >> options: aCollectionOfSymbol [

	options := aCollectionOfSymbol .
]

{ #category : #'accessing - wizard management' }
RadioButtonsPart >> outputValue [

	^ self option
]

{ #category : #accessing }
RadioButtonsPart >> updateButtonsWhenChangesOn: aLabel withContents: buttonContents [ 

	self option: aLabel
]
