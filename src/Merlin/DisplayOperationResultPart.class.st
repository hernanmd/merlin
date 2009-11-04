Class {
	#name : #DisplayOperationResultPart,
	#superclass : #TextDisplayPart,
	#category : #Merlin
}

{ #category : #'initialize-release' }
DisplayOperationResultPart >> initialize [
	super initialize.
]

{ #category : #'accessing - wizard mangement' }
DisplayOperationResultPart >> outputValue [
	^ nil
]

{ #category : #'initialize-release' }
DisplayOperationResultPart >> retrieveInputRequired [
	| secondeNumber firstNumber informationRequired |
	informationRequired := wizardPane getInputRequiredBy: self.
	firstNumber := (informationRequired at: 1) asInteger.
	secondeNumber := (informationRequired at: 3) asInteger.
	(informationRequired at: 2) = '*' ifTrue: 
		[ self text: 'the result is : ' , (firstNumber * secondeNumber) asString ].
	(informationRequired at: 2) = '+' ifTrue: 
		[ self text: 'the result is : ' , (firstNumber + secondeNumber) asString ].
	(informationRequired at: 2) = '/' ifTrue: 
		[ self text: 'the result is : ' , (firstNumber / secondeNumber) asString ].
	(informationRequired at: 2) = '-' ifTrue: 
		[ self text: 'the result is : ' , (firstNumber - secondeNumber) asString ]
]
