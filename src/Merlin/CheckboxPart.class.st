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
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user' author: 'cyrille.delaunay'>
	^ self new
		initialize;
		label: aString ; yourself
]

{ #category : #'instance creation' }
CheckboxPart class >> withLabel: aString inGroupboxNamed: anotherString [ 
	"the checkbox will be put into a groupbox named aString."
	^ self new
		initialize;
		label: aString
			inGroupboxNamed: anotherString ; yourself
]

{ #category : #accessing }
CheckboxPart >> label:  aLabel [
	label := aLabel.
	self contents: {self newCheckbox}
]

{ #category : #accessing }
CheckboxPart >> label:  aLabel inGroupboxNamed: aString [
	label := aLabel.
	self contents: {self newGroupboxNamed: aString With: self newCheckbox}
]

{ #category : #'morph content setup tools' }
CheckboxPart >> newCheckbox [
	"Return a checkbox that allow the user to choose between merging classes and metaclasses or not"

	| checkbox |
	checkbox := self 
				newCheckboxFor: (model := ValueHolder new contents: true)
				getSelected: #contents
				setSelected: #contents:
				label: label.
	checkbox buttonMorph selected: true.
	^checkbox
]

{ #category : #'accessing - wizard mangement' }
CheckboxPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	^ model contents
]
