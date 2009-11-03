Class {
	#name : #WizardSimpleTest,
	#superclass : #Object,
	#category : #Merlin
}

{ #category : #'as yet unclassified' }
WizardSimpleTest >> example [
	"WizardSimpleTest new example"
	| wizardControl firstPane lastPane block1 block2 block3 block4 middlePane1 middlePane2 |
	wizardControl := WizardControl2 new.

	firstPane := WizardFirstPane2 new.
	middlePane1 := WizardMiddlePane2 new.
	middlePane2 := WizardMiddlePane2 new.
	lastPane := WizardLastPane2 new.
	wizardControl 
		addPane: firstPane.
	wizardControl 
		addPane: middlePane1.
	wizardControl 
		addPane: middlePane2.
	wizardControl 
		addPane: lastPane.
		
	block1 := TestNumberSelectorBlock named: 'block1'.
	block2 := TestOperatorSelectorBlock named: 'block2'.
	block3 := TestNumberSelectorBlock named: 'block3'.
	block4 := TestDisplayOperationResultBlock named: 'block4'.
	firstPane 
		addBlock: block1
		associatedTo: #firstNumber.
	middlePane1 
		addBlock: block2
		associatedTo: #operator.
	middlePane2 
		addBlock: block3
		associatedTo: #secondNumber.
	lastPane 
		addBlock: block4
		associatedTo: nil
		requiring: {  #firstNumber. #operator. #secondNumber  }.
	wizardControl openFirstWizardPane
]
