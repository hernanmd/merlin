Class {
	#name : #WizardSimpleTest,
	#superclass : #Object,
	#category : #Merlin
}

{ #category : #'as yet unclassified' }
WizardSimpleTest >> example [
	"WizardSimpleTest new example"
	| wizardControl firstPane lastPane block1 block2 block3 block4 middlePane1 middlePane2 |
	wizardControl := WizardControl new.
	firstPane := WizardFirstPane new.
	middlePane1 := WizardMiddlePane new.
	middlePane2 := WizardMiddlePane new.
	lastPane := WizardLastPane new.
	wizardControl addPane: firstPane.
	wizardControl addPane: middlePane1.
	wizardControl addPane: middlePane2.
	wizardControl addPane: lastPane.
	block1 := NumberSelectorPart named: 'block1'.
	block2 := OperatorSelectorPart named: 'block2'.
	block3 := NumberSelectorPart named: 'block3'.
	block4 := DisplayOperationResultPart named: 'block4'.
	firstPane 
		addPart: block1
		associatedTo: #firstNumber.
	middlePane1 
		addPart: block2
		associatedTo: #operator.
	middlePane2 
		addPart: block3
		associatedTo: #secondNumber.
	lastPane 
		addPart: block4
		associatedTo: nil
		requiring: {  #firstNumber. #operator. #secondNumber  }.
	wizardControl openFirstWizardPane
]
