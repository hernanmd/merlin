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
		'name',
		'displayLayout',
		'mainPaneLine'
	],
	#category : #'Merlin-Core'
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
	(mainPaneLine ifNil: [mainPaneLine := PaneColumn fromPane: self])
		row: aWizardPart.
	partsAndInformationsAssociated 
		at: aWizardPart
		put: aSymbol.
]

{ #category : #'addition-removal' }
WizardPane >> addPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [ 
	"when a wizard part is added to a WizardPane, an output is associated to it. Each part is associate to only one output but can require several inputs specified by aCollectionOfSymbols"

	wizardParts add: aWizardPart.
	aWizardPart wizardPane: self.
	(mainPaneLine ifNil: [mainPaneLine := PaneColumn fromPane: self])
		row: aWizardPart.
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
	
	
	"self contents:  (partsGroups collect: [:aPaneAbstractLine |  aPaneAbstractLine morphContents])."
	self dialogWindow  contentMorph: mainPaneLine morphContents.
	self applyChanges 
	
	
	
	"| blocksContents rightBlocksContents |
	blocksContents := wizardParts collect: [ :each | each contents].
	rightBlocksContents := wizardRightParts collect: [ :each | each contents].
	rightBlocksContents 
		ifEmpty: [self contents: blocksContents asOrderedCollection.]
		ifNotEmpty: [self leftContents: blocksContents asOrderedCollection rightContents: rightBlocksContents asOrderedCollection.].
	
	self applyChanges."
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

{ #category : #'addition-removal' }
WizardPane >> column: aBlockOrAPart [

	mainPaneLine 
		ifNotNilDo: [:aPaneRow |
			aPaneRow column: aBlockOrAPart 
			]  
		ifNil: [
			mainPaneLine := PaneRow fromPane: self.
			mainPaneLine column: aBlockOrAPart 
			].

]

{ #category : #'addition-removal' }
WizardPane >> column: aWizardPart associatedTo: aSymbol [

	"use this method to add a part (using aBlockOrAPart as a WizardPart) or several parts (using aBlockOrAPart as a block ([:row | row column: aPart ; column: anotherPart]) ) to the pane, in a new row. You should always manage the layout of the pane in the same way: you decide to divide the pane in rows and for each row you can add several columns. In this case you will always use a method begining with 'way'. If you decide to divide you pane in columns, you will always use a method begining with: 'column:'. If you try another way to dispatch the parts, the order you might want will not be guaranteed "

	mainPaneLine 
		ifNotNilDo: [:aPaneRow |
			aPaneRow column: aWizardPart 
			]  
		ifNil: [
			mainPaneLine := PaneRow fromPane: self.
			mainPaneLine column: aWizardPart 
			].
		
	"we now focus on the information management (made by the is wizardPane itself): "
	self setPart: aWizardPart associatedTo: aSymbol 
		
	
]

{ #category : #'addition-removal' }
WizardPane >> column: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [

	"use this method to add a part (using aBlockOrAPart as a WizardPart) or several parts (using aBlockOrAPart as a block ([:row | row column: aPart ; column: anotherPart]) ) to the pane, in a new row. You should always manage the layout of the pane in the same way: you decide to divide the pane in rows and for each row you can add several columns. In this case you will always use a method begining with 'way'. If you decide to divide you pane in columns, you will always use a method begining with: 'column:'. If you try another way to dispatch the parts, the order you might want will not be guaranteed "

	mainPaneLine 
		ifNotNilDo: [:aPaneRow |
			aPaneRow column: aWizardPart 
			]  
		ifNil: [
			mainPaneLine := PaneRow fromPane: self.
			mainPaneLine column: aWizardPart 
			].
		
	"we now focus on the information management (made by the is wizardPane itself): "
	self setPart: aWizardPart associatedTo: aSymbol  requiring: aCollectionOfSymbols
		
	
]

{ #category : #'private - accessing' }
WizardPane >> contents: aCollectionOfMorphElements [ 
	"fill in the morph contents of the dialog window with morphs from aCollectionOfMorpElements. aCollectionOfMorpElements represent the morph contents of all wizard parts composing this wizardPane. Used in the method open. Each element will be diplayed one under the other"
	
	"|contents|
	contents := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; 
		changeTableLayout;
		cellInset: 8; yourself.

	aCollectionOfMorphElements do: [:each | contents addMorphBack: each].
	self dialogWindow  contentMorph: contents."
	|contents|
	(displayLayout = #column)
		ifTrue: [
			contents := self newRowWith: aCollectionOfMorphElements .
			]
		ifFalse: [
			contents := self newColumnWith: aCollectionOfMorphElements .
			]. 
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
			wizardPart retrieveInputRequired]].
	
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
	"this method is used by the sub parts to inform this pane that their output value has changed. Here , we push this value to parts requiring this information"

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

{ #category : #'private - accessing' }
WizardPane >> leftContents: aCollectionOfMorphElements rightContents: anotherCollectionOfMorph [
	"fill in the morph contents of the dialog window with morphs from aCollectionOfMorpElements. aCollectionOfMorpElements represent the morph contents of all wizard parts composing this wizardPane. Used in the method open. Each element will be diplayed one under the other"
	
	|globalContents leftContents rightContents|
	leftContents := self newColumnWith: aCollectionOfMorphElements.
	rightContents := self newColumnWith: anotherCollectionOfMorph .
	
	globalContents := self newRowWith: {leftContents. rightContents}.
	self dialogWindow  contentMorph: globalContents.
	^globalContents

	
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
WizardPane >> newColumnWith: aCollectionOfMorphElements [
	"use this method to create a new column in your block"
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	
	|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
]

{ #category : #'morph creation' }
WizardPane >> newNextButton [
	^ self newButtonNamed: self forwardSign withAction: #nextButtonAction
]

{ #category : #'morph creation' }
WizardPane >> newPreviousButton [
	^ self newButtonNamed: self backSign withAction: #previousButtonAction
]

{ #category : #'morph creation' }
WizardPane >> newRowWith: aCollectionOfMorphElements [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	"use this method to create a new row in your block"
	
	|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
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

{ #category : #updating }
WizardPane >> refresh [
	self open
]

{ #category : #'addition-removal' }
WizardPane >> removeAllParts [
	

	wizardParts removeAll.
	mainPaneLine := nil.
	partsAndInformationsAssociated := Dictionary new.
	partsAndRequiredInformations := Dictionary new.
	
]

{ #category : #'addition-removal' }
WizardPane >> row: aBlockOrAPart [

	"use this method to add a part (using aBlockOrAPart as a WizardPart) or several parts (using aBlockOrAPart as a block ([:row | row column: aPart ; column: anotherPart]) ) to the pane, in a new row. You should always manage the layout of the pane in the same way: you decide to divide the pane in rows and for each row you can add several columns. In this case you will always use methods begining with 'row'. If you decide to divide your pane in columns, you will always use methods begining with: 'column:'. If you try another way to dispatch the parts, the order you  want might not be guaranteed "
	mainPaneLine 
		ifNotNilDo: [:aPaneColumn |
			aPaneColumn row: aBlockOrAPart 
			]  
		ifNil: [
			mainPaneLine := PaneColumn fromPane: self.
			mainPaneLine row: aBlockOrAPart 
			].
		
	

]

{ #category : #'addition-removal' }
WizardPane >> row: aWizardPart associatedTo: aSymbol [

	"use this method to add a part (using aBlockOrAPart as a WizardPart) or several parts (using aBlockOrAPart as a block ([:row | row column: aPart ; column: anotherPart]) ) to the pane, in a new row. You should always manage the layout of the pane in the same way: you decide to divide the pane in rows and for each row you can add several columns. In this case you will always use a method begining with 'way'. If you decide to divide you pane in columns, you will always use a method begining with: 'column:'. If you try another way to dispatch the parts, the order you might want will not be guaranteed "

	mainPaneLine 
		ifNotNilDo: [:aPaneColumn |
			aPaneColumn row: aWizardPart 
			]  
		ifNil: [
			mainPaneLine := PaneColumn fromPane: self.
			mainPaneLine row: aWizardPart 
			].
		
	"we now focus on the information management (made by the is wizardPane itself): "
	self setPart: aWizardPart associatedTo: aSymbol  
		
	
]

{ #category : #'addition-removal' }
WizardPane >> row: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [

	"use this method to add a part (using aBlockOrAPart as a WizardPart) or several parts (using aBlockOrAPart as a block ([:row | row column: aPart ; column: anotherPart]) ) to the pane, in a new row. You should always manage the layout of the pane in the same way: you decide to divide the pane in rows and for each row you can add several columns. In this case you will always use a method begining with 'way'. If you decide to divide you pane in columns, you will always use a method begining with: 'column:'. If you try another way to dispatch the parts, the order you might want will not be guaranteed "

	mainPaneLine 
		ifNotNilDo: [:aPaneColumn |
			aPaneColumn row: aWizardPart 
			]  
		ifNil: [
			mainPaneLine := PaneColumn fromPane: self.
			mainPaneLine row: aWizardPart 
			].
		
	"we now focus on the information management (made by the is wizardPane itself): "
	self setPart: aWizardPart associatedTo: aSymbol  requiring: aCollectionOfSymbols
		
	
]

{ #category : #'addition-removal' }
WizardPane >> setPart: aWizardPart [ 

	wizardParts add: aWizardPart.
	aWizardPart wizardPane: self.	
	
		
	
]

{ #category : #'addition-removal' }
WizardPane >> setPart: aWizardPart associatedTo: aSymbol [ 

	self setPart: aWizardPart.	
	partsAndInformationsAssociated 
		at: aWizardPart
		put: aSymbol.
	
		
	
]

{ #category : #'addition-removal' }
WizardPane >> setPart: aWizardPart associatedTo: aSymbol requiring: aCollectionOfSymbols [

	self setPart: aWizardPart  associatedTo: aSymbol.
	partsAndRequiredInformations 
		at: aWizardPart
		put: aCollectionOfSymbols.
		
	
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
