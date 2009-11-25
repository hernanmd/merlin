"
A WizardControl is the object controling the differents panes (WizardPane) that will be displayed in a Wizard. It make all the transition between those panes when button like 'next' or 'previous' are pressed. Those transitions are composed by opening and closing the panes but also by managing their inputs and outputs. Values of those outputs (representing the information you want to retrieve at the end of the wizard operation) are all stored in the WizardControl.

Instance Variables
	builder:		<StandardWindow>
	currentPane:		<Integer>
	dialogWindow:		<PluggableDialogWindow>
	
	wizardInformations:		<Dictionary>
	wizardPanes:		<OrderedCollection>

builder
	- the main window (common to all panes) in which we plugg a dialogWindow

currentPane
	- an index pointing on the current displayed pane.

dialogWindow
	- in which panes will position their elements (WizardPart). The dialog window is also common to all panes so that the wizard panes windows stay at the same position. (Create a new dialog window for each pane open a window at different positions each times)



wizardInformations
	- A dictionary to memorize output from the different panes. The keys of this dictionary are define when you create a WizardPart (object that composed a WizardPane).

wizardPanes
	- the different panes that composed a wizard. Those panes will be displayed in the order specify by this OrderedCollection. 

"
Class {
	#name : #WizardControl,
	#superclass : #Object,
	#instVars : [
		'currentPane',
		'wizardPanes',
		'builder',
		'wizardInformations',
		'dialogWindow'
	],
	#category : #Merlin
}

{ #category : #example }
WizardControl class >> example [
	"self example"
	| wizardControl firstPane lastPane part1 part2 part3 part4 middlePane1 middlePane2 |
	<lint: 'Long methods' rationale: 'Just an example of how to use the library ' author: 'cyrille.delaunay'>
	wizardControl := self new.
	firstPane := WizardFirstPane new.
	middlePane1 := WizardMiddlePane new.
	middlePane2 := WizardMiddlePane new.
	lastPane := WizardLastPane new.
	
	wizardControl addPane: firstPane.
	wizardControl addPane: middlePane1.
	wizardControl addPane: middlePane2.
	wizardControl addPane: lastPane.
	
	part1 := NumberSelectorPart new.
	part2 := OperatorSelectorPart new.
	part3 := NumberSelectorPart new.
	part4 := DisplayOperationResultPart new.
	
	firstPane 
		addPart: part1
		associatedTo: #firstNumber.
	middlePane1 
		addPart: part2
		associatedTo: #operator.
	middlePane2 
		addPart: part3
		associatedTo: #secondNumber.
	lastPane 
		addPart: part4
		associatedTo: nil
		requiring: {  #firstNumber. #operator. #secondNumber  }.
	wizardControl openFirstWizardPane
]

{ #category : #'instance creation' }
WizardControl class >> new [

	^super new initialize.
]

{ #category : #accessing }
WizardControl >> addPane: aWizardPane [  
	"add the WizardPane aWizardPane at the end of the panes list of this wizard control. Therefore, this pane will be the last one to be displayed "
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .

]

{ #category : #accessing }
WizardControl >> builder [ 

	^ builder
]

{ #category : #accessing }
WizardControl >> dialogWindow [
	
	"return the dialog window of this WizardControl. This dialog window is common to all the panes composing the wizard so that each pane can be open at the same position"
	^ dialogWindow 
]

{ #category : #accessing }
WizardControl >> dialogWindowName: aString [
	
	"set the name of the dialogWindow"
	dialogWindow title: aString
]

{ #category : #'initialize-release' }
WizardControl >> initialize [
	
	super initialize.
	builder := StandardWindow new.
	
	dialogWindow :=  PluggableDialogWindow new.
	dialogWindow contentMorph: (dialogWindow newColumn: {   }).
	
	wizardInformations := Dictionary new.

	wizardPanes := OrderedCollection new.



]

{ #category : #start }
WizardControl >> openFirstWizardPane [
	"launch the wizard system by opening the first wizard pane."
	wizardPanes isEmpty ifTrue: [ ^ self ].
	currentPane := 1.
	(wizardPanes at: currentPane) open
]

{ #category : #'wizard panes transition' }
WizardControl >> performNextButtonAction [
	"this method is run when a next button is pressed"
	(wizardPanes at: currentPane) close.
	currentPane := currentPane  + 1.
	(wizardPanes at: currentPane ) open. 
]

{ #category : #'wizard panes transition' }
WizardControl >> performPreviousButtonAction [
	"this method is run when a previous button is pressed"
	(wizardPanes at: currentPane) close.
	currentPane := currentPane  - 1.
	(wizardPanes at: currentPane ) open. 
]

{ #category : #'wizard panes transition' }
WizardControl >> performTerminateButtonAction [

	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
		(wizardPanes at: currentPane) close.
		
]

{ #category : #accessing }
WizardControl >> setInformation: aSymbol withValue: value [ 
	"set the value of the information designed by aSymbol. It is used by a pane when a next button or a terminate button is clicked to spread its output information"
	wizardInformations 
		at: aSymbol
		put: value
]

{ #category : #accessing }
WizardControl >> valueOfInformation: aSymbol [
	"return the value of the output information named aSymbol"
	^ wizardInformations at: aSymbol.
]

{ #category : #accessing }
WizardControl >> wizardInformations [ 
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"return a Dictionary containing the ids of the informations retrieved by the wizard and their values"
	^ wizardInformations 
]

{ #category : #accessing }
WizardControl >> wizardPanes: anOrderedCollection [
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"set all the wizard panes controled by this wizard control. Those panes will be display in the same order than the one of anOrderedCollection"
	^wizardPanes := anOrderedCollection
]
