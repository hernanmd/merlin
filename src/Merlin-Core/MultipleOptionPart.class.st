Class {
	#name : #MultipleOptionPart,
	#superclass : #OptionPart,
	#instVars : [
		'selectedOptions',
		'optionsAndModels'
	],
	#category : #'Merlin-Parts'
}

{ #category : #accessing }
MultipleOptionPart >> deselectAllOptions [

	self optionsAndModels valuesDo: [:aModel |
		aModel contents: false
		]
]

{ #category : #accessing }
MultipleOptionPart >> deselectOption: anOption [

	self setOption: anOption to: false   
]

{ #category : #accessing }
MultipleOptionPart >> modelOfOption: anOption [

	^ self optionsAndModels at: anOption
]

{ #category : #accessing }
MultipleOptionPart >> options: aCollectionOfValues [

	|tmpDictionary|
	tmpDictionary := IdentityDictionary new.
	super options: aCollectionOfValues.
	self options do: [:anObject |
		tmpDictionary at: anObject put: (MerlinOptionValueHolder new option: anObject; contents: true; addDependent: self; yourself)
		].
	self optionsAndModels: tmpDictionary
]

{ #category : #accessing }
MultipleOptionPart >> optionsAndModels [

	^ optionsAndModels 
]

{ #category : #accessing }
MultipleOptionPart >> optionsAndModels: aDictionary [

	optionsAndModels :=  aDictionary 
]

{ #category : #accessing }
MultipleOptionPart >> selectAllOptions [

	self optionsAndModels valuesDo: [:aModel |
		aModel contents: true
		]
]

{ #category : #accessing }
MultipleOptionPart >> selectOption: anOption [

	self setOption: anOption to: true   
]

{ #category : #accessing }
MultipleOptionPart >> selectedOptions [

	^ selectedOptions ifNil: [selectedOptions := OrderedCollection new]
]

{ #category : #accessing }
MultipleOptionPart >> setOption: anOption to: trueOrFalse [

	(self optionsAndModels at: anOption) contents: trueOrFalse 
]

{ #category : #accessing }
MultipleOptionPart >> setOptions: aCollectionOfOptions to: trueOrFalse [

	aCollectionOfOptions do: [:anOption |
		self setOption: anOption to: trueOrFalse   
		]
]

{ #category : #updating }
MultipleOptionPart >> update: aChange [

	(self options includes: aChange) ifTrue: [
		self hasChanged: (aChange -> (self modelOfOption: aChange) contents)  
		] 
]
