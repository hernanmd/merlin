Class {
	#name : #TestDisplayOperationResultBlock,
	#superclass : #TestTextDisplayBlock,
	#category : #Merlin
}

{ #category : #'accessing - wizard mangement' }
TestDisplayOperationResultBlock >> informationValue [

	^ nil
]

{ #category : #'initialize-release' }
TestDisplayOperationResultBlock >> initialize [
	super initialize.
]

{ #category : #'initialize-release' }
TestDisplayOperationResultBlock >> retrieveInformationRequired [
	| secondeNumber firstNumber informationRequired |
	informationRequired := wizardPane getInformationRequiredBy: self.
	firstNumber := (informationRequired at: 1) asInteger.
	secondeNumber := (informationRequired at: 3) asInteger.
	Transcript show: (informationRequired at: 2) asString.
	(informationRequired at: 2) = '*' 
		ifTrue: [ self text: 'the result is : ',(firstNumber * secondeNumber) asString ].
	(informationRequired at: 2) = '+' 
		ifTrue: [ self text: 'the result is : ', (firstNumber + secondeNumber) asString ].
	(informationRequired at: 2) = '/' 
		ifTrue: [ self text: 'the result is : ' ,(firstNumber / secondeNumber) asString ].
	(informationRequired at: 2) = '-' 
		ifTrue: [ self text: 'the result is : ',(firstNumber - secondeNumber) asString]
]
