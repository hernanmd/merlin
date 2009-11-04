Class {
	#name : #CheckboxPart,
	#superclass : #WizardPart,
	#instVars : [
		'label',
		'model'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
CheckboxPart class >> withLabel: aString [

	^ super new initialize ; label: aString .
]

{ #category : #'instance creation' }
CheckboxPart class >> withLabel: aString inGroupboxNamed: anotherString [
	"the checkbox will be put into a groupbox named aString."
	^ super new initialize ; label: aString inGroupboxNamed: anotherString  .
]

{ #category : #accessing }
CheckboxPart >> label:  aLabel [
	label := aLabel.
	self contents: {self newMergeClassAndMetaClassCheckbox}
]

{ #category : #accessing }
CheckboxPart >> label:  aLabel inGroupboxNamed: aString [
	label := aLabel.
	self contents: {self newGroupboxNamed: aString With: self newMergeClassAndMetaClassCheckbox}
]

{ #category : #'morph content setup tools' }
CheckboxPart >> newMergeClassAndMetaClassCheckbox [
	"Return a checkbox that allow the user to choose between merging classes et metaclasses or not"
	| checkbox |
	checkbox := self newCheckboxFor:   
	( model := (ValueHolder new contents: false))
		getSelected: #contents
		setSelected: #contents:
		label: label.
		
	checkbox buttonMorph selected: true.
	^checkbox .
]

{ #category : #'accessing - wizard mangement' }
CheckboxPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	^ model contents
]
