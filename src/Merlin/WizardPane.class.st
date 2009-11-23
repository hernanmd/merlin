"
A WizardPane represent a 'page' that will be displayed in a Wizard. A wizardPane doesn't contain any morph imformation itself: It is composed by several WizardParts , each one containing a specific morph contents. A wizardpane only provide the common set of buttons to naviguate between the panes ('next', 'previous' , 'cancel' , 'terminate' ). It also make the transmission between the wizardParts input and outputs and the WizardControl in which the values are stored.

Instance Variables
	partsAndInformationsAssociated:		<Dictionary>
	partsAndRequiredInformations:		<Dictionary>
	cancelButton:		<Object>
	contents:		<Object>
	wizardParts:		<OrderedCollection>
	wizardControl:		<WizardControl>

partsAndInformationsAssociated
	- a dictionary to store the differents wizardParts and the SINGLE output identifiant associated.

partsAndRequiredInformations
	- a dictionary to store the differents wizardParts and the inputs identifiants required by this WizardPart .

cancelButton
	- xxxxx

contents
	- xxxxx

wizardParts
	- the differents WizardParts that composed this WizardPane

wizardControl
	- the WizardControl controlling this pane.

"
Class {
	#name : #WizardPane,
	#superclass : #Object,
	#instVars : [
		'wizardControl',
		'cancelButton',
		'partsAndInformationsAssociated',
		'partsAndRequiredInformations',
		'wizardParts'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
WizardPane class >> new [

	^ super new  initialize .
]

{ #category : #updating }
WizardPane >> adaptSize [
	"adapt the size of the window to its contents. Usefull when you dynamically add elements to your window.(In fact simply re-open the window)"
	self builder openModal: self dialogWindow .
]

{ #category : #accessing }
WizardPane >> addPart: aWizardPart associatedTo: aSymbol [ 
	"when a wizard part is added to a WizardPane, an output is associated to it. Each part is associate to only one output "
	wizardParts add: aWizardPart.
	aWizardPart wizardPane: self.
	partsAndInformationsAssociated 
		at: aWizardPart
		put: aSymbol.
]

{ #category : #accessing }
WizardPane >> addPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [ 
	"when a wizard part is added to a WizardPane, an output is associated to it. Each part is associate to only one output but can require several inputs specified by aCollectionOfSymbols "
	wizardParts add: aWizardPart.
	aWizardPart wizardPane: self.
	partsAndInformationsAssociated 
		at: aWizardPart
		put: aSymbol.
	partsAndRequiredInformations 
		at: aWizardPart
		put: aCollectionOfSymbols.
	
]

{ #category : #updating }
WizardPane >> applyChanges [
	"make sure that all changes become visible in the frame"
	
	| contentMorph |
	contentMorph := self dialogWindow   contentMorph .
	contentMorph notNil
		ifTrue: [self dialogWindow   contentMorph: contentMorph; model: nil].
	
]

{ #category : #'private - actions' }
WizardPane >> buildDialogWindow [
	"this method fill in the contents of the dialog window with all the WizardPart morph contents. Each wizardPart will be displayed one under the other. "
	| blocksContents |
	blocksContents := wizardParts collect: [ :each | each contents ].
	self contents: blocksContents asOrderedCollection.
	self applyChanges
]

{ #category : #accessing }
WizardPane >> builder [
	"return the builder stored in the WizardControl"
	^ self wizardControl builder.
]

{ #category : #'private - accessing' }
WizardPane >> buttons: aCollectionOfButtons [
	"set the value of the buttons that will be visible at the right end of the WizardPane "
	
	self dialogWindow   buttons: aCollectionOfButtons .
	self applyChanges .
	
]

{ #category : #actions }
WizardPane >> cancelButtonAction [
	"represent the action to execute when the cancel button is pressed"
	self dialogWindow  close.
]

{ #category : #actions }
WizardPane >> checkForEnablingNextButton [

	"this method is called each time a wizard part change is state about enabling or not the next button. Just look if all wizard parts are 'ok'"
	
	wizardParts detect: [:each | each enableNextButtonValue = false ] ifNone: [^ self enableNextButton ].
	self disableNextButton .
]

{ #category : #'window control' }
WizardPane >> close [
	"close this pane"
	self dialogWindow  close
]

{ #category : #'private - accessing' }
WizardPane >> contents: aCollectionOfMorphElements [
	"fill in the morph contents of the dialog window with morphs from aCollectionOfMorpElements. aCollectionOfMorpElements represent the morph contents of all wizard parts composing this wizardPane. Used in the method open. Each element will be diplayed one under the other"
	|contents|
	contents := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.

	aCollectionOfMorphElements do: [:each | contents addMorphBack: each].
	self dialogWindow  contentMorph: contents.
	^contents

	
]

{ #category : #accessing }
WizardPane >> dialogWindow [ 		
	"return the common dialog window store ine the wizard control"
	^self wizardControl dialogWindow .
]

{ #category : #actions }
WizardPane >> disableNextButton [

	"by default (if no next button is define, do nothing)"
]

{ #category : #'private - actions' }
WizardPane >> displayButtons [
	"add buttons to the dialogWindow. each subclass know which buttons have to be added to their dialogWindow"
	self subclassResponsibility
]

{ #category : #actions }
WizardPane >> enableNextButton [

	"by default (if no next button is define, do nothing)"
]

{ #category : #accessing }
WizardPane >> getInputRequiredBy: aWizarPart [ 
	"enable a WizardPart to retrieve  from the wizard control an input required to perform its tasks."
	| informationsRequired |
	informationsRequired := partsAndRequiredInformations at: aWizarPart.
	^ informationsRequired collect: [ :each | self wizardControl valueOfInformation: each ]
]

{ #category : #'initialize-release' }
WizardPane >> initialize [
	"by default, the dialog window is a new empty pluggable dialog window "
	partsAndInformationsAssociated := Dictionary new.
	partsAndRequiredInformations := Dictionary new.

	
	wizardParts := OrderedCollection new.
	cancelButton := self newCancelButton
]

{ #category : #'contents setup tools' }
WizardPane >> newButtonNamed: aString withAction: selector [
	"use this method to create a new classic button that will execute the method designed by selector when clicked. The method selector must be defined and implemented."
	| button |
	button := PluggableButtonMorphPlus
			on: self getState: nil action: selector.
	button label: aString.
	^button
]

{ #category : #'morph creation' }
WizardPane >> newCancelButton [
	"Each kind of pane contain a cancel button that enable to close the dialog window"

	cancelButton := self newButtonNamed: 'Cancel' withAction:   #cancelButtonAction.
	
	^cancelButton
]

{ #category : #'contents setup tools' }
WizardPane >> newColumn: aSymbol with: aMorphBlock [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"enable the user to devide vertically the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	"wizardMorphBlocks at: aSymbol put: aMorphBlock ."

	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.
	answer addMorphBack: aMorphBlock contents.
	^answer
]

{ #category : #'contents setup tools' }
WizardPane >> newColumn: aSymbol withAll: aCollectionOfMorphElements [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"enable the user to devide vertically the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	"wizardMorphBlocks at: aSymbol put: aCollectionOfMorphElements  ."

	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [ :each | answer addMorphBack: each ].
	^answer
]

{ #category : #'morph creation' }
WizardPane >> newNextButton [

	^ (self newButtonNamed: 'Next >>' withAction:   #nextButtonAction) .

]

{ #category : #'morph creation' }
WizardPane >> newPreviousButton [

	^ self newButtonNamed: '<< Back' withAction:   #previousButtonAction.

]

{ #category : #'contents setup tools' }
WizardPane >> newRow: aSymbol with: aMorphBlock [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"enable the user to devide horizontaly the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
"	wizardMorphBlocks at: aSymbol put: aMorphBlock ."
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8; yourself.
	answer addMorphBack: aMorphBlock contents.
	^answer
]

{ #category : #'contents setup tools' }
WizardPane >> newRow: aSymbol withAll: aCollectionOfMorphElements [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"enable the user to devide horizontaly the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	"wizardMorphBlocks at: aSymbol put: aCollectionOfMorphElements ."
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [:each | answer addMorphBack: each].
	^answer
]

{ #category : #actions }
WizardPane >> nextButtonAction [
	"action executed when the next button is pressed"
	partsAndInformationsAssociated keysAndValuesDo: 
		[ :key :value | 
		self wizardControl 
			setInformation: value
			withValue: key outputValue ].
	self wizardControl performNextButtonAction
]

{ #category : #'window control' }
WizardPane >> open [
	"open this pane. To do that, we make sure that all the WizardParts retrieve the inputs they require and then, we display their morph contents"
	wizardParts do: [ :each | each retrieveInputRequired ].
	"wizardParts  detect: [:each | each enableNextButton  = false  ]  ifNone: [self enableNextButton ]".
	self  buildDialogWindow.
	self displayButtons.
	self checkForEnablingNextButton .
	self builder openModal: self dialogWindow.
	
]

{ #category : #actions }
WizardPane >> previousButtonAction [

	"action executed when the previous button is pressed"
	self wizardControl performPreviousButtonAction 
]

{ #category : #accessing }
WizardPane >> wizardControl [
	"return the WizardControl controling this pane"
	^ wizardControl 
]

{ #category : #accessing }
WizardPane >> wizardControl: aWizardControl [
	"set the WizardControl controling this pane"
	^ wizardControl := aWizardControl.
]
