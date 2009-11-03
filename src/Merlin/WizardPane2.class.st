Class {
	#name : #WizardPane2,
	#superclass : #Object,
	#instVars : [
		'wizardControl',
		'cancelButton',
		'dialogWindow',
		'wizardMorphBlocks',
		'contents',
		'blocksAndInformationsAssociated',
		'wizardBlocks',
		'blocksAndRequiredInformations'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
WizardPane2 class >> dependingOn: aWizardControl. [

	^ super new wizarControl: aWizardControl ; initialize .
]

{ #category : #'instance creation' }
WizardPane2 class >> new [

	^ super new  initialize .
]

{ #category : #updating }
WizardPane2 >> adaptSize [

	self builder openModal: self dialogWindow .
]

{ #category : #accessing }
WizardPane2 >> addBlock: aWizardBlock associatedTo: aSymbol [ 
	"when a block is added to a WizardPane, a set a informations is associated to this pane. Each block  only one information "
	wizardBlocks add: aWizardBlock.
	aWizardBlock wizardPane: self.
	blocksAndInformationsAssociated 
		at: aWizardBlock 
		put: aSymbol
]

{ #category : #accessing }
WizardPane2 >> addBlock: aWizardBlock associatedTo: aSymbol requiring: aCollectionOfSymbols [
	"when a block is added to a WizardPane, a set a informations is associated to this pane. Each block  only one information "
	wizardBlocks add: aWizardBlock.
	aWizardBlock wizardPane: self.
	
	blocksAndInformationsAssociated 
		at: aWizardBlock 
		put: aSymbol.
	
	blocksAndRequiredInformations
		at: aWizardBlock 
		put: aCollectionOfSymbols .
		
	
]

{ #category : #updating }
WizardPane2 >> applyChanges [
"we make sure that all changes become visible in the frame"
	
	| contentMorph |
	contentMorph := self dialogWindow   contentMorph .
	contentMorph notNil
		ifTrue: [self dialogWindow   contentMorph: contentMorph; model: nil].
	
]

{ #category : #'morph creation' }
WizardPane2 >> buildDialogWindow [
	"this method fill the contents of the dialog window with the combinaison of the blocks contents dispatched in the specified way. "
	
	| blocksContents |
	blocksContents := wizardBlocks collect: [:each | each contents].
	"Transcript show: blocksContents asString."
	self contents: blocksContents asOrderedCollection.
	self applyChanges .
]

{ #category : #'as yet unclassified' }
WizardPane2 >> builder [

	^ wizardControl builder.
]

{ #category : #'private - accessing' }
WizardPane2 >> buttons: aCollectionOfButtons [
	"set the value of the buttons that will be visible at the right end of the WizardPane "
	
	self dialogWindow   buttons: aCollectionOfButtons .
	self applyChanges .
	
]

{ #category : #actions }
WizardPane2 >> cancelButtonAction [

	self dialogWindow  close.
]

{ #category : #'window control' }
WizardPane2 >> close [
	self dialogWindow  close
]

{ #category : #'contents setup tools' }
WizardPane2 >> contents: aCollectionOfMorphElements [

	contents := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8.

	aCollectionOfMorphElements do: [:each | contents addMorphBack: each].
	self dialogWindow  contentMorph: contents.
	^contents

	
]

{ #category : #accessing }
WizardPane2 >> dialogWindow [ 		
	
	^dialogWindow .
]

{ #category : #'private - accessing' }
WizardPane2 >> dialogWindow: aDialogWindow [ 
	dialogWindow := aDialogWindow.
	"we fix the buttons of the previous dialog window to the new dialog window "
	self displayButtons
]

{ #category : #'private - accessing' }
WizardPane2 >> displayButtons [
	"add buttons to the dialogWindow. each subclass now which buttons have to be added to their dialogWindow"
	self subclassResponsibility
]

{ #category : #accessing }
WizardPane2 >> getInformationRequiredBy: aWizarBlock [

	| informationsRequired |
	informationsRequired := blocksAndRequiredInformations at: aWizarBlock .
	
	^informationsRequired collect: [:each |wizardControl valueOfInformation: each ]
	
]

{ #category : #'initialize-release' }
WizardPane2 >> initialize [
	"by default, the dialog window is a new empty pluggable dialog window "
	dialogWindow := PluggableDialogWindow new.
	dialogWindow contentMorph: (dialogWindow newColumn: {   }).
	wizardMorphBlocks := Dictionary new.
	blocksAndInformationsAssociated := Dictionary new.
	blocksAndRequiredInformations := Dictionary new.
	wizardBlocks := OrderedCollection new.
	cancelButton := self newCancelButton
]

{ #category : #'contents setup tools' }
WizardPane2 >> newButtonNamed: aString withAction: selector [
	"use this method to create a new classic button that will execute the method designed by selector when clicked. The method selector must define and implemented in the subclass"
	
	| button |
	button := PluggableButtonMorphPlus
			on: self getState: nil action: selector.
	button label: aString.
	^ button
]

{ #category : #'morph creation' }
WizardPane2 >> newCancelButton [
	"Each kind of pane contain a cancel button that enable to close the dialog window"

	cancelButton := self newButtonNamed: 'Cancel' withAction:   #cancelButtonAction.
	
	^cancelButton
]

{ #category : #'contents setup tools' }
WizardPane2 >> newColumn: aSymbol with: aMorphBlock [

	"enable the user to devide vertically the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	wizardMorphBlocks at: aSymbol put: aMorphBlock .

	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8.
	answer addMorphBack: aMorphBlock contents.
	^answer
]

{ #category : #'contents setup tools' }
WizardPane2 >> newColumn: aSymbol withAll: aCollectionOfMorphElements [

	"enable the user to devide vertically the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	wizardMorphBlocks at: aSymbol put: aCollectionOfMorphElements  .

	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8.
	aCollectionOfMorphElements do: [ :each | answer addMorphBack: each ].
	^answer
]

{ #category : #'morph creation' }
WizardPane2 >> newNextButton [
	"Each kind of pane contain a cancel button that enable to close the dialog window"

	^ self newButtonNamed: 'Next' withAction:   #nextButtonAction.

]

{ #category : #'morph creation' }
WizardPane2 >> newPreviousButton [
	"Each kind of pane contain a cancel button that enable to close the dialog window"

	^ self newButtonNamed: 'Previous' withAction:   #previousButtonAction.

]

{ #category : #'contents setup tools' }
WizardPane2 >> newRow: aSymbol with: aMorphBlock [

	"enable the user to devide horizontaly the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	wizardMorphBlocks at: aSymbol put: aMorphBlock .
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8.
	answer addMorphBack: aMorphBlock contents.
	^answer
]

{ #category : #'contents setup tools' }
WizardPane2 >> newRow: aSymbol withAll: aCollectionOfMorphElements [

	"enable the user to devide horizontaly the frame. aSymbol will be used to identify this row (corresponding to a new morph ) and therefore keep a link to it."
	|answer|
	wizardMorphBlocks at: aSymbol put: aCollectionOfMorphElements .
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8.
	aCollectionOfMorphElements do: [:each | answer addMorphBack: each].
	^answer
]

{ #category : #'window control' }
WizardPane2 >> open [

	wizardBlocks do: [:each | each retrieveInformationRequired ].
	self buildDialogWindow .
	self builder openModal: self dialogWindow .
]

{ #category : #accessing }
WizardPane2 >> wizardControl [

	^ wizardControl 
]

{ #category : #accessing }
WizardPane2 >> wizardControl: aWizardControl [

	^ wizardControl := aWizardControl.
]
