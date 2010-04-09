Class {
	#name : #TextFieldWithPrefixAnsSuffixLabelsPart,
	#superclass : #TextFieldPart,
	#category : #'Merlin-Parts'
}

{ #category : #'instance creation' }
TextFieldWithPrefixAnsSuffixLabelsPart class >> inGroupboxNamed: aString defaultText: anotherString [

	^ (super new inGroupboxNamed: aString) initialize: anotherString ; yourself.
]

{ #category : #'instance creation' }
TextFieldWithPrefixAnsSuffixLabelsPart class >> inGroupboxNamed: aString defaultText: anotherString prefix: prefixString suffix: suffixString [

	^ (super new inGroupboxNamed: aString prefix: prefixString suffix: suffixString) initialize: anotherString ; yourself.
]

{ #category : #'instance creation' }
TextFieldWithPrefixAnsSuffixLabelsPart class >> inGroupboxNamed: aString prefix: prefixString suffix: suffixString [

	^ super new inGroupboxNamed: aString prefix: prefixString suffix: suffixString.
]

{ #category : #'instance creation' }
TextFieldWithPrefixAnsSuffixLabelsPart class >> prefix: prefixString suffix: suffixString [

	^ super new prefix: prefixString suffix: suffixString; yourself.
]

{ #category : #'instance creation' }
TextFieldWithPrefixAnsSuffixLabelsPart class >> prefix: prefixString suffix: suffixString defaultText: aString [

	^ (super new prefix: prefixString suffix: suffixString) initialize: aString; yourself.
]

{ #category : #'initialize-release' }
TextFieldWithPrefixAnsSuffixLabelsPart >> inGroupboxNamed: aString prefix: prefixString suffix: suffixString [

	self populateContents: {self newGroupboxNamed: aString With: (self newRowWith:{ self newLabel:prefixString. self newTextEntry. self newLabel:suffixString. })}.
]

{ #category : #'initialize-release' }
TextFieldWithPrefixAnsSuffixLabelsPart >> prefix: prefixString suffix: suffixString [

	self populateContents: {(self newRowWith:{ self newLabel:prefixString. self newTextEntry. self newLabel:suffixString. })}.
]
