Class {
	#name : #MerlinExamples,
	#superclass : #Object,
	#category : #'Merlin-Examples'
}

{ #category : #'basic examples' }
MerlinExamples class >> chooseFilePart [
	"self chooseFilePart"

	| wizardControl  wizardPane1  dropListPart checkboxPart textFieldPart compositePart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	checkboxPart := ChooseFilePart  new.
		
	wizardPane1 row: checkboxPart.	
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> compositePart [
	"self compositePart"

	| wizardControl  wizardPane1  dropListPart checkboxPart textFieldPart compositePart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	checkboxPart := CheckboxPart  new
									label: 'select / unselect';
									defaultValue: true
									yourself.
	
	dropListPart := DropListPart  new
									list: #(1 2 3 4);
									defaultValue: 2;
									yourself.
				
	textFieldPart := TextFieldPart new
									defaultValue: 'hey';
									"textFieldHorizontalSize: 100"
									yourself. 
									
	compositePart := CompositePart new
									withTitlesAndParts: {'with checkbox' -> checkboxPart . 'with dropList' -> dropListPart . 'with textField' -> textFieldPart}.
		
		
	wizardPane1 row: compositePart.	
	
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> compositePartWithoutSpecifyingTabTitles [
	"self compositePartWithoutSpecifyingTabTitles"

	| wizardControl  wizardPane1  dropListPart checkboxPart textFieldPart compositePart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	checkboxPart := CheckboxPart  new
									label: 'select / unselect';
									defaultValue: true
									yourself.
	
	dropListPart := DropListPart  new
									list: #(1 2 3 4);
									defaultValue: 2;
									yourself.
				
	textFieldPart := TextFieldPart new
									defaultValue: 'hey';
									"textFieldHorizontalSize: 100"
									yourself. 
									
	compositePart := CompositePart new
									withParts: {checkboxPart .  dropListPart .  textFieldPart}.
		
		
	wizardPane1 row: compositePart.	
	
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> compositeWithParametrizedParts [
	"self compositeWithParametrizedParts"

	| wizardControl  wizardPane1  dropListPart checkboxPart textFieldPart compositePart mainPart |
				
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	mainPart := DropListPart new
					list: #(true false);
					inGroupboxNamed: 'the selection will be propagated to all parts';
					defaultValue: 1;
					callback: [ :outputValue |
						checkboxPart selected: outputValue.
						dropListPart selectionIndex: (dropListPart list indexOf: outputValue).
						textFieldPart textEntryContents: outputValue asString. 
						];
					yourself.
	
	checkboxPart := CheckboxPart  new
									label: 'select / unselect';
									defaultValue: true;
									yourself.
	
	dropListPart := DropListPart  new
									list: #(true false);
									defaultValue: 2;
									yourself.
				
	textFieldPart := TextFieldPart new
									defaultValue: 'hey';
									"textFieldHorizontalSize: 100"
									yourself. 
									
	compositePart := CompositePart new
									withTitlesAndParts: {'with checkbox' -> checkboxPart . 'with dropList' -> dropListPart . 'with textField' -> textFieldPart}.
		
	wizardPane1 row: mainPart. 
	wizardPane1 row: compositePart.	
	
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'complete examples' }
MerlinExamples class >> numericalOperationsExample [
	"self numericalOperationsExample"
	| wizardControl firstPane middlePane lastPane firstNumberDropList operatorDropList secondNumberDropList |
	<lint: 'Long methods' rationale: 'Just an example of how to use the library ' author: 'cyrille.delaunay'>
	wizardControl := WizardControl new.
	firstPane := WizardFirstPane new.
	middlePane := WizardMiddlePane new.
	lastPane := WizardLastPane new.
	
	wizardControl addPane: firstPane.
	wizardControl addPane: middlePane.
	wizardControl addPane: lastPane.
	
	firstNumberDropList := NumberSelectorPart new
								list: #(1 2 3 4 5 6 7 8 9);
								useLatePopulateContents: false.
	operatorDropList := OperatorSelectorPart new
								list: #(+ - * / );
								useLatePopulateContents: false.
	secondNumberDropList := NumberSelectorPart new
								list: #(1 2 3 4 5 6 7 8 9);
								useLatePopulateContents: false.
								
	firstPane 
		row: firstNumberDropList
		associatedTo: #firstNumber.
	middlePane
		row: operatorDropList
		associatedTo: #operator.
	lastPane 
		row: secondNumberDropList
		associatedTo: #secondNumber.
	wizardControl atEndDo: [:aDictionaryOfOutputs |
		|result|
		result := Compiler evaluate: 
			(aDictionaryOfOutputs at: #firstNumber) asString,
			(aDictionaryOfOutputs at: #operator) asString,
			(aDictionaryOfOutputs at: #secondNumber) asString.
		UIManager inform: 'The result is: ', result asString.
		].
	wizardControl open
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedChexboxes [
	"self parametrizedChexboxes"

	| wizardControl  wizardPane1 wizardPane2 firstCheckBoxPart secondCheckBoxPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	firstCheckBoxPart := CheckboxPart new
									label: 'if selected, next one not selected';
									inGroupboxNamed: 'Test';
									defaultValue: true;
									useLatePopulateContents: false;
									yourself.
									
	secondCheckBoxPart := CheckboxPart new
									label: 'selected if previous one not selected';
									inGroupboxNamed: 'Test';
									defaultValue: [:inputs | (inputs at: #firstCheckbocValue) not];
									yourself.
		
		
	wizardPane1 row: firstCheckBoxPart associatedTo: #firstCheckbocValue.
	wizardPane2 row: secondCheckBoxPart associatedTo: #secondCheckbocValue requiring: {#firstCheckbocValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedDropLists [
	"self parametrizedDropLists"

	| wizardControl  wizardPane1 wizardPane2 firstDropListPartPart secondDropListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	firstDropListPartPart := DropListPart  new
									inGroupboxNamed: 'Select an item';
									list: #('un' 'deux' 'trois' 'quatre');
									defaultValue: 'trois';
									useLatePopulateContents: false;
									yourself.
									
	secondDropListPart := DropListPart  new
									inGroupboxNamed: 'Same selection than previous dropList';
									defaultValue: [:inputs | (inputs at: #firstDropListValue) ];
									list: #('un' 'deux' 'trois' 'quatre');
									yourself.
		
		
	wizardPane1 row: firstDropListPartPart associatedTo: #firstDropListValue.
	wizardPane2 row: secondDropListPart associatedTo: #secondDropListValue requiring: {#firstDropListValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedLists [
	"self parametrizedLists"

	| wizardControl  wizardPane1 wizardPane2 firstListPartPart secondListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	firstListPartPart := ListPart  new
									inGroupboxNamed: 'Select an item';
									list: #('un' 'deux' 'trois' 'quatre');
									defaultValue: 1;
									useLatePopulateContents: false;
									yourself.
									
	secondListPart := ListPart  new
									inGroupboxNamed: 'Same selection than previous dropList';
									defaultValue: [:inputs | (inputs at: #firstListValue) ];
									list: #('un' 'deux' 'trois' 'quatre');
									yourself.
		
		
	wizardPane1 row: firstListPartPart associatedTo: #firstListValue.
	wizardPane2 row: secondListPart associatedTo: #secondListValue requiring: {#firstListValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedListsUsingRefresh [
	"self parametrizedListsUsingRefresh"

	| wizardControl  wizardPane1 wizardPane2 firstListPartPart secondListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	firstListPartPart := ListPart  new
									inGroupboxNamed: 'Select an item';
									list: #('un' 'deux' 'trois' 'quatre');
									defaultValue: 1;
									useLatePopulateContents: false;
									callback: [:outputValue :thisPart |
										thisPart wizardPane refresh
										]
									yourself.
									
	secondListPart := ListPart  new
									inGroupboxNamed: 'Same selection than previous dropList';
									defaultValue: [:inputs | (inputs at: #firstListValue) ];
									list: #('un' 'deux' 'trois' 'quatre');
									yourself.
		
		
	wizardPane1 row: firstListPartPart associatedTo: #firstListValue.
	wizardPane2 row: secondListPart associatedTo: #secondListValue requiring: {#firstListValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedMorphDropLists [
	"self parametrizedMorphDropLists"

	| wizardControl  wizardPane1 wizardPane2 firstDropListPartPart secondDropListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.

	firstDropListPartPart := MorphDropListPart  new
									inGroupboxNamed: 'Select an item';
									list: ({Color red . Color yellow . Color blue } collect: [:c | Morph new extent: 80@12; color: c]);
									defaultValue: 2;
									useLatePopulateContents: false;
									yourself.
									
	secondDropListPart := MorphDropListPart  new
									inGroupboxNamed: 'Same selection than previous dropList';
									defaultValue: [:inputs | (inputs at: #firstDropListValue) ];
									list: ({Color red . Color yellow . Color blue } collect: [:c | Morph new extent: 80@12; color: c]);
									yourself.
		
		
	wizardPane1 row: firstDropListPartPart associatedTo: #firstDropListValue.
	wizardPane2 row: secondDropListPart associatedTo: #secondDropListValue requiring: {#firstDropListValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedPrefixedSuffixedTextFields [
	"self parametrizedPrefixedSuffixedTextFields"

	| wizardControl  wizardPane1 wizardPane2 firstTextFieldPart secondTextFieldPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	firstTextFieldPart := TextFieldPart  new
									inGroupboxNamed: 'yop';
									defaultValue: 'default';
									prefix: 'Enter text here : ';
									textFieldHorizontalSize: 100;
									useLatePopulateContents: false;
									yourself.
									
	secondTextFieldPart := TextFieldPart  new
									inGroupboxNamed: 'Same text than previous textField';
									suffix: ' is what you entered before';
									textFieldHorizontalSize: 100;
									defaultValue: [:inputs | (inputs at: #firstTextFieldValue) ];
									yourself.
		
		
	wizardPane1 row: firstTextFieldPart associatedTo: #firstTextFieldValue.
	wizardPane2 row: secondTextFieldPart associatedTo: #secondTextFieldValue requiring: {#firstTextFieldValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> parametrizedTextFields [
	"self parametrizedTextFields"

	| wizardControl  wizardPane1 wizardPane2 firstTextFieldPart secondTextFieldPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	firstTextFieldPart := TextFieldPart  new
									inGroupboxNamed: 'yop';
									defaultValue: 'default';
									useLatePopulateContents: false;
									yourself.
									
	secondTextFieldPart := TextFieldPart  new
									inGroupboxNamed: 'Same text than previous textField';
									defaultValue: [:inputs | (inputs at: #firstTextFieldValue) ];
									yourself.
		
		
	wizardPane1 row: firstTextFieldPart associatedTo: #firstTextFieldValue.
	wizardPane2 row: secondTextFieldPart associatedTo: #secondTextFieldValue requiring: {#firstTextFieldValue}.
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> usingCallbackAndRefresh [
	"self usingCallbackAndRefresh"

	| wizardControl  wizardPane1  firstDropListPartPart secondDropListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	firstDropListPartPart := DropListPart  new
									inGroupboxNamed: 'Select number of dropLists you want';
									list: #(1 2 3 4);
									defaultValue: 1;
									callback: [:outputValue | 
										wizardPane1 removeAllParts.
										wizardPane1 row: firstDropListPartPart.  
										1 to: outputValue do: [:index |
											wizardPane1 row: (DropListPart new list: #('hey' 'ho'); defaultValue: 1 ; inGroupboxNamed: index asString ; yourself). 
											].
										wizardPane1 refresh.
										];
									yourself.
									
	wizardPane1 row: firstDropListPartPart associatedTo: #firstDropListValue.
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> usingCallbackAndRefreshAndBlockAsDefaultValue [
	"self usingCallbackAndRefreshAndBlockAsDefaultValue"

	| wizardControl  wizardPane1  firstDropListPartPart secondDropListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	firstDropListPartPart := DropListPart  new
									inGroupboxNamed: 'Select number of dropLists you want';
									list: #(1 2 3 4);
									defaultValue: 1;
									callback: [:outputValue | 
										wizardPane1 removeAllParts.
										wizardPane1 row: firstDropListPartPart associatedTo: #firstDropListValue.  
										1 to: outputValue do: [:index |
											wizardPane1 row: (DropListPart new list: #(1 2 3 4); defaultValue: [:requiredInputs | requiredInputs at: #firstDropListValue] ; inGroupboxNamed: index asString ; yourself) associatedTo: #doesntMatter requiring: {#firstDropListValue}. 
											].
										wizardPane1 refresh.
										];
									yourself.
									
	wizardPane1 row: firstDropListPartPart associatedTo: #firstDropListValue.
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> usingCallbackOnCheckBox [
	"self usingCallbackOnCheckBox"

	| wizardControl  wizardPane1  firstDropCheckboxPart secondCheckboxPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	secondCheckboxPart := CheckboxPart  new
									inGroupboxNamed: 'Same selection than checkbox on top';
									label: 'is selected according the checkbox on top'
									yourself.
	
	firstDropCheckboxPart := CheckboxPart  new
									inGroupboxNamed: 'Select or unselect';
									defaultValue: true;
									label: 'will select the checkbox below';
									callback: [:outputValue |  secondCheckboxPart selected: outputValue.   ];
									yourself.
									
	
		
		
	wizardPane1 row: firstDropCheckboxPart associatedTo: #firstCheckboxValue.
	wizardPane1 row: secondCheckboxPart associatedTo: #secondCheckValue.
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> usingCallbackOnDropList [
	"self usingCallbackOnDropList"

	| wizardControl  wizardPane1  firstDropListPartPart secondDropListPart |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	
	firstDropListPartPart := DropListPart  new
									inGroupboxNamed: 'Select an item';
									list: #('un' 'deux' 'trois' 'quatre');
									defaultValue: 'trois';
									callback: [:outputValue | secondDropListPart selectionIndex: (secondDropListPart list indexOf: outputValue)];
									yourself.
									
	secondDropListPart := DropListPart  new
									inGroupboxNamed: 'Same selection than dropList on top';
									list: #('un' 'deux' 'trois' 'quatre');
									yourself.
		
		
	wizardPane1 row: firstDropListPartPart associatedTo: #firstDropListValue.
	wizardPane1 row: secondDropListPart associatedTo: #secondDropListValue.
		
	wizardControl 
		addPane: wizardPane1. 
		
	wizardControl open. 
	
	
]

{ #category : #'basic examples' }
MerlinExamples class >> usingRowsAndColumns [
	"self usingRowsAndColumns"

	| wizardControl  wizardPane1 wizardPane2 |
	wizardControl := WizardControl new.
	
	wizardPane1 := WizardFirstPane new.
	wizardPane2 := WizardLastPane new.
	
	wizardPane1 
		row: [:r | 
			r column: (TextFieldPart inGroupboxNamed: 'On my right: a DropList') ; column: (DropListPart new list: #(1 2 3 4 5); inGroupboxNamed: 'on my left: a textField')			
			];
		row: (TextPart on: 'I should be alone in the second row' inGroupBoxNamed: 'yep').
		
	wizardPane2 
		column: (TextPart on: 'I should be alone in the first column' inGroupBoxNamed: 'yep');
		column: [:r | 
			r row: (TextFieldPart inGroupboxNamed: 'Below me: a DropList') ; row: (DropListPart new list: #(1 2 3 4 5); inGroupboxNamed: 'On top of me: a textField')			
			].
		
	wizardControl 
		addPane: wizardPane1 ; 
		addPane: wizardPane2.
		
	wizardControl open. 
	
	
]
