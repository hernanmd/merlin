Class {
	#name : #WizardControl2,
	#superclass : #Object,
	#instVars : [
		'currentPane',
		'wizardPanes',
		'builder',
		'panesAndInformationsAssociated',
		'paneCompter',
		'wizardInformations',
		'panesAndRequiredInformations',
		'dialogWindow'
	],
	#category : #Merlin
}

{ #category : #'as yet unclassified' }
WizardControl2 class >> new [

	^super new initialize.
]

{ #category : #accessing }
WizardControl2 >> addFirstPane: aWizardPane  associatedTo: aCollectionOfSymbols. [
	"when a pane is added to a WizardControl, a set a informations is associated to this pane. Each pane controls a number variable of informations,datas "
	panesAndInformationsAssociated at: #firstPane put: aCollectionOfSymbols .
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .
]

{ #category : #accessing }
WizardControl2 >> addLastPane: aWizardPane  associatedTo: aCollectionOfSymbols. [
	"when a pane is added to a WizardControl, a set a informations is associated to this pane. Each pane controls a number variable of informations,datas "
	panesAndInformationsAssociated at: #lastPane put: aCollectionOfSymbols .
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .
]

{ #category : #accessing }
WizardControl2 >> addLastPane: aWizardPane  associatedTo: aCollectionOfSymbols requiring: anotherCollectionOfSymbols. [
	"when a pane is added to a WizardControl, a set a informations is associated to this pane. Each pane controls a number variable of informations,datas "
	panesAndInformationsAssociated at: #lastPane put: aCollectionOfSymbols .
	panesAndRequiredInformations  at: #lastPane put: anotherCollectionOfSymbols .
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .
]

{ #category : #accessing }
WizardControl2 >> addMiddlePane: aWizardPane  associatedTo: aCollectionOfSymbols. [
	"when a pane is added to a WizardControl, a set a informations is associated to this pane. Each pane controls a number variable of informations,datas "
	panesAndInformationsAssociated at: ('middlePane' , paneCompter asString) asSymbol put: aCollectionOfSymbols .
	
	paneCompter := paneCompter + 1.
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .
]

{ #category : #accessing }
WizardControl2 >> addMiddlePane: aWizardPane  associatedTo: aCollectionOfSymbols requiring: anotherCollectionOfSymbols. [
	"when a pane is added to a WizardControl, a set a informations is associated to this pane. Each pane controls a number variable of informations,datas "
	panesAndInformationsAssociated at: ('middlePane' , paneCompter asString) asSymbol put: aCollectionOfSymbols .
	panesAndRequiredInformations at: ('middlePane' , paneCompter asString) asSymbol put: anotherCollectionOfSymbols .
	paneCompter := paneCompter + 1.
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .
]

{ #category : #accessing }
WizardControl2 >> addPane: aWizardPane [  
	
	aWizardPane wizardControl: self.
	wizardPanes add: aWizardPane .

]

{ #category : #accessing }
WizardControl2 >> builder [ 

	^ builder
]

{ #category : #'initialize-release' }
WizardControl2 >> initialize [
	
	super initialize.
	builder := StandardWindow new.
	dialogWindow :=  PluggableDialogWindow new.
	wizardInformations := Dictionary new.
	panesAndInformationsAssociated := Dictionary new.
	panesAndRequiredInformations := Dictionary new.
	wizardPanes := OrderedCollection new.
	paneCompter := 1.	


]

{ #category : #start }
WizardControl2 >> openFirstWizardPane [
	
	(wizardPanes size = 0)
		ifFalse: [
			currentPane := 1.
			(wizardPanes at: currentPane ) open
			]
	
]

{ #category : #'wizard panes transition' }
WizardControl2 >> performNextButtonAction [

	(wizardPanes at: currentPane) close.
	currentPane := currentPane  + 1.
	(wizardPanes at: currentPane ) open. 
]

{ #category : #'wizard panes transition' }
WizardControl2 >> performPreviousButtonAction [

	(wizardPanes at: currentPane) close.
	currentPane := currentPane  - 1.
	(wizardPanes at: currentPane ) open. 
]

{ #category : #'wizard panes transition' }
WizardControl2 >> performTerminateButtonAction [

	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
		"^self subclassResponsibility"
		(wizardPanes at: currentPane) close.
		
]

{ #category : #accessing }
WizardControl2 >> setInformationsSymbols: aCollectionOfSymbol [ 
	"set the value of the keys in wizardInformations corresponding to a kind of ID to all informations that have to be retrieve all along the wizard processus."
	aCollectionOfSymbol do: 
		[ :each | 
		wizardInformations 
			at: each
			put: nil ]
]

{ #category : #accessing }
WizardControl2 >> setValue: value toInformation: aSymbol [

	"fill in the value of the information designed by aSymbol. It is used by a pane when a next button or a terminate button is clicked to spread the information"
	wizardInformations at: aSymbol put: value.
]

{ #category : #accessing }
WizardControl2 >> valueOfInformation: aSymbol [

	^ wizardInformations at: aSymbol.
]

{ #category : #accessing }
WizardControl2 >> wizardInformations [ 
	"return a Dictionary containing the ids of the informations retrieve by the wizard and their values"
	^ wizardInformations 
]

{ #category : #accessing }
WizardControl2 >> wizardPanes [

	^wizardPanes 
]

{ #category : #accessing }
WizardControl2 >> wizardPanes: anOrderedCollection [

	^wizardPanes := anOrderedCollection
]
