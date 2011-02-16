Class {
	#name : #CheckboxPart,
	#superclass : #WizardPart,
	#instVars : [
		'label',
		'model',
		'checkbox',
		'contents'
	],
	#category : #'Merlin-Parts'
}

{ #category : #'checkbox control' }
CheckboxPart >> contents [

	^contents
]

{ #category : #'checkbox control' }
CheckboxPart >> contents: newContents [

	contents := newContents.
	self contentsChanged.
	self hasChanged
]

{ #category : #'initialize-release' }
CheckboxPart >> initialize [ 

	super initialize.
	contents := true.	
	checkbox := self newCheckbox. 
	
]

{ #category : #accessing }
CheckboxPart >> label:  aLabel [

	checkbox label: aLabel.
]

{ #category : #accessing }
CheckboxPart >> latePopulateContents [
	
	|default|
	default := defaultValue meValue: self requiredInputs.
	
	default ifNotNilDo: [:aBoolean |
		self selected: aBoolean.	
		]. 
	
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: checkbox}]
		ifNil: [self populateContents: {checkbox }].
	
]

{ #category : #'morph content setup tools' }
CheckboxPart >> newCheckbox [
	
	| checkboxMorph |
	
	checkboxMorph := self 
				newCheckboxFor: (self)
				getSelected: #contents
				setSelected: #contents:
				label: ('').
	"checkboxMorph buttonMorph selected: true."
	^checkboxMorph
]

{ #category : #'accessing - wizard mangement' }
CheckboxPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	"return true or false according the checkbox is selected or not"
	^ self contents
]

{ #category : #accessing }
CheckboxPart >> selected [
	"return true if the checkBox button morph is selected "
	
	^ self contents

	
]

{ #category : #accessing }
CheckboxPart >> selected: trueOrFalse [
	"select or unselect the checkbox according the value of trueOrFalse "
	
	self contents: trueOrFalse.
	checkbox updateSelection

	
]
