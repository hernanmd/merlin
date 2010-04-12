Class {
	#name : #Examples,
	#superclass : #Object,
	#category : #'Merlin-Examples'
}

{ #category : #'basic examples' }
Examples class >> usingRowsAndColumns [
	"self usingRowsAndColumns"

	| wizardControl  wizardPane1 wizardPane2 |
	wizardControl := WizardControl new.
	
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	wizardPane1 
		row: [:r | 
			r column: (TextFieldPart inGroupboxNamed: 'On my right: a DropList') ; column: (DropListPart on: #(1 2 3 4 5) inGroupboxNamed: 'on my left: a textField')			
			];
		row: (TextPart on: 'I should be alone in the second row' inGroupBoxNamed: 'yep').
		
	wizardPane2 
		column: (TextPart on: 'I should be alone in the first column' inGroupBoxNamed: 'yep');
		column: [:r | 
			r row: (TextFieldPart inGroupboxNamed: 'Below me: a DropList') ; row: (DropListPart on: #(1 2 3 4 5) inGroupboxNamed: 'On top of me: a textField')			
			].
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]
