"
A WizardPane is an abstract which represents a 'page' that will be displayed in a Wizard. A wizardPane doesn't contain any morph imformation itself: It is composed by several WizardParts, each one containing a specific morph contents. A wizardpane only provide the common set of buttons to naviguate between the panes ('next', 'previous' , 'cancel' , 'terminate' ). It also make the transmission between the wizardParts input and outputs and the WizardControl in which the values are stored.

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
		'wizardParts',
		'name'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
WizardPane class >> named: aString [

	^ super new  initialize ; name: aString ;yourself .
]

{ #category : #updating }
WizardPane >> adaptSize [
	"Adapt the size of the window to its contents. Usefull when you dynamically add elements to your window. (In fact simply re-open the window)"
	
	self builder openModal: self dialogWindow.
]

{ #category : #'addition-removal' }
WizardPane >> addPart: aWizardPart associatedTo: aSymbol [ 
	"when a wizard part is added to a WizardPane, an output is associated to it. Each part is associate to only one output"
	
	wizardParts add: aWizardPart.
	aWizardPart wizardPane: self.
	partsAndInformationsAssociated 
		at: aWizardPart
		put: aSymbol.
]

{ #category : #'addition-removal' }
WizardPane >> addPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [ 
	"when a wizard part is added to a WizardPane, an output is associated to it. Each part is associate to only one output but can require several inputs specified by aCollectionOfSymbols"

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
	contentMorph := self dialogWindow contentMorph.
	contentMorph notNil
		ifTrue: [self dialogWindow contentMorph: contentMorph; model: nil].
	
]

{ #category : #'morph creation' }
WizardPane >> backSign [
	^ '<< Back'
]

{ #category : #'private - actions' }
WizardPane >> buildDialogWindow [
	"this method fill in the contents of the dialog window with all the WizardPart morph contents. Each wizardPart will be displayed one under the other."
	
	| blocksContents |
	blocksContents := wizardParts collect: [ :each | each contents].
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
	
	self dialogWindow buttons: aCollectionOfButtons.
	self applyChanges.
	
]

{ #category : #actions }
WizardPane >> cancelButtonAction [
	"represent the action to execute when the cancel button is pressed"
	
	self dialogWindow close.
]

{ #category : #actions }
WizardPane >> checkForEnablingNextButton [
	"this method is called each time a wizard part change is state about enabling or not the next button. Just look if all wizard parts are 'ok'"
	
	wizardParts detect: [:each | each enableNextButtonValue = false ] ifNone: [^ self enableNextButton ].
	self disableNextButton.
]

{ #category : #'window control' }
WizardPane >> close [
	
	self dialogWindow close
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
	
	^self wizardControl dialogWindow.
]

{ #category : #actions }
WizardPane >> disableNextButton [
	"by default (if no next button is defined, do nothing)"
]

{ #category : #'private - actions' }
WizardPane >> displayButtons [
	"add buttons to the dialogWindow. each subclass know which buttons have to be added to their dialogWindow"
	
	self subclassResponsibility
]

{ #category : #actions }
WizardPane >> distributeRequiredInputs [

	wizardParts do: [:wizardPart |
		(partsAndRequiredInformations at: wizardPart ifAbsent: [nil]) ifNotNilDo: [ :collOfSymbols |
			collOfSymbols do: [:symbol |
				wizardPart requiredInputsAt: symbol put: (wizardControl wizardInformations at: symbol)].
			wizardPart retrieveInputRequired]]
]

{ #category : #actions }
WizardPane >> enableNextButton [
	"by default (if no next button is define, do nothing)"
]

{ #category : #'morph creation' }
WizardPane >> forwardSign [
	^ 'Next >>'
]

{ #category : #actions }
WizardPane >> hasChanged: aWizardPart [
	"this method is used by the sub parts to inform this pane that their output value has changed. Here , we push this value to the part requiring this information"

	| informationValue informationSymbol |
	informationValue := aWizardPart outputValue.
	informationSymbol := partsAndInformationsAssociated at: aWizardPart.	
	
	wizardControl information: informationSymbol withValue: informationValue.
	
	partsAndRequiredInformations keysAndValuesDo: [:key :value |
		(value includes: informationSymbol)
			ifTrue: [ aWizardPart requiredInputsAt: informationSymbol put: informationValue]]
	
]

{ #category : #'initialize-release' }
WizardPane >> initialize [
	"by default, the dialog window is a new empty pluggable dialog window "

	super initialize.
	name := ''.
	partsAndInformationsAssociated := Dictionary new.
	partsAndRequiredInformations := Dictionary new.	
	wizardParts := OrderedCollection new.
	cancelButton := self newCancelButton.
	
]

{ #category : #accessing }
WizardPane >> inputRequiredBy: aWizarPart [ 
	"enable a WizardPart to retrieve  from the wizard control an input required to perform its tasks."
	
	| informationsRequired |
	informationsRequired := partsAndRequiredInformations at: aWizarPart.
	^ informationsRequired collect: [ :each | self wizardControl valueOfInformation: each ]
]

{ #category : #accessing }
WizardPane >> name [

	^ name 
]

{ #category : #accessing }
WizardPane >> name: aString [

	name := aString
]

{ #category : #'contents setup tools' }
WizardPane >> newButtonNamed: aString withAction: selector [
	"use this method to create a new classic button that will execute the method designed by selector when clicked. The method selector must be defined and implemented."
	
	| button |
	button := PluggableButtonMorphPlus on: self getState: nil action: selector.
	button label: aString.
	^button
]

{ #category : #'morph creation' }
WizardPane >> newCancelButton [
	"Each kind of pane contain a cancel button that enable to close the dialog window"

	cancelButton := self newButtonNamed: 'Cancel' withAction: #cancelButtonAction.
	^cancelButton
]

{ #category : #'morph creation' }
WizardPane >> newNextButton [
	^ self newButtonNamed: self forwardSign withAction: #nextButtonAction
]

{ #category : #'morph creation' }
WizardPane >> newPreviousButton [
	^ self newButtonNamed: self backSign withAction: #previousButtonAction
]

{ #category : #actions }
WizardPane >> nextButtonAction [
	"action executed when the next button is pressed"
	
	partsAndInformationsAssociated keysAndValuesDo: 
		[ :key :value | 
		self wizardControl 
			information: value
			withValue: key outputValue ].
	self wizardControl performNextButtonAction
]

{ #category : #'window control' }
WizardPane >> open [
	"open this pane. To do that, we make sure that all the WizardParts retrieve the inputs they require and then, we display their morph contents"
	
	self distributeRequiredInputs .
	wizardParts do: [ :each | each retrieveInputRequired ].
	
	self  buildDialogWindow.
	self displayButtons.
	self checkForEnablingNextButton.
	wizardControl dialogWindowName: name.
	self builder openModal: self dialogWindow.
	
]

{ #category : #actions }
WizardPane >> previousButtonAction [
	"action executed when the previous button is pressed"
	
	self wizardControl performPreviousButtonAction 
]

{ #category : #'addition-removal' }
WizardPane >> removeAllParts [
	

	wizardParts removeAll.
	partsAndInformationsAssociated := Dictionary new.
	partsAndRequiredInformations := Dictionary new.
	
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
