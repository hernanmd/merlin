Class {
	#name : #DisplayOperationResultPart,
	#superclass : #TextDisplayPart,
	#category : #Merlin
}

{ #category : #'accessing - wizard mangement' }
DisplayOperationResultPart >> outputValue [
	^ nil
]

{ #category : #'accessing - wizard mangement' }
DisplayOperationResultPart >> retrieveInputRequired [
	<lint: 'Uses "size = 0", "= nil",  or "at: 1" instead of "isEmpty",  "isNil", or "first"' rationale: 'I prefer use "at:" for every elements of my collection (even the first) ' author: 'cyrille.delaunay'>
	| secondeNumber firstNumber informationRequired |
	informationRequired := self wizardPane getInputRequiredBy: self.
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
