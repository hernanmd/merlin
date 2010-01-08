"
A WizardPart represent a part of a WizardPane. It only provide one output (information), in other words, it deals with a maximum of one information to retrieve.However, a wizardPane can maybe deal with several output informations and should therefore be composed by several WizardPart.On the other hand, a WizardPart can require several input informations.

WizardPart is an abstract class that you should be subclassed to create your own component in the pane. It's up to you to build the morph contents of a WizardPart (even if some tools to create basic elements are provided by the abstract class). And it's up to you to specify what is the information you want to retrieve from this interface: to do that, you only have to implement the abstrat method 'outputValue' and put into the value you want to transmit (for example, if your wizardpart is composed by a simple drop list you may want to transmit the value of the item selected).
You may also want to override the method 'retrieveRequiredInput' to retrieve some informations and make what you want with it(by default it does nothing). This method is called by the wizardPane before each pane opening.

Instance Variables
	blockContents:		<PanelMorph>
	enableNextButton: <Boolean>

	wizardPane:		<WizardPane>

blockContents
	- is the morph contents of this wizard part. It will be added by wizardPane to the main dialog window contents .

enableNextButton:
	- is telling wether this wizard part authorize the wizardPane next button to be enable or not. By default, its value is true . But sometimes an information is required before going to the next wizard pane. In this case, override the initialize method and call the method 'enableNextButton: false'. Then, just call 'self enableNextButton: true' in your code when the next button has to enabled (for example, you can look at the class ListSelector)



wizardPane
	- the wizard pane controling this wizard part

"
Class {
	#name : #WizardPart,
	#superclass : #Object,
	#instVars : [
		'blockContents',
		'wizardPane',
		'enableNextButton'
	],
	#category : #Merlin
}

{ #category : #'accessing - morph' }
WizardPart >> contents [
	"return the morph contents of this WizardPart."

	^   blockContents. 
	
]

{ #category : #'accessing - morph' }
WizardPart >> contents: aCollectionOfMorphElement [
	"Set the morph contents Of this WizardPart. Create a panel morph containing all the elements in aCollectionOfMorphElements one under the other"
	 	
	blockContents := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.
		
	aCollectionOfMorphElement do: [:each | blockContents addMorphBack: each ].
	^blockContents
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> enableNextButton: trueOrFalse [
	" set the value of enableNextButton and update the next button in the wizard pane (if the wizard pane is yet initialized)"
	enableNextButton := trueOrFalse.

	self wizardPane ifNotNil: [self wizardPane checkForEnablingNextButton ]
		


]

{ #category : #'accessing - wizard mangement' }
WizardPart >> enableNextButtonValue [
	" return true if the next button in the wizard pane should be enable"
	^ enableNextButton.
	
	


]

{ #category : #'initialize-release' }
WizardPart >> initialize [
	
	super initialize.
	"by default, a wizard part doesn't require anything to enable the next button of the wizard pane"
	self enableNextButton:  true.
]

{ #category : #'morph content setup tools' }
WizardPart >> newButtonNamed: aString withAction: selector [
	"use this method to create a new classic button that will execute the method designed by selector when clicked. The method selector must be defined and implemented in the subclass"
	
	| button |
	button := PluggableButtonMorphPlus
			on: self getState: nil action: selector.
	button label: aString.
	^button
]

{ #category : #'morph content setup tools' }
WizardPart >> newButtonNamed: aString withAction: selector andArguments: aCollectionOfArguments [
	<lint: 'Methods implemented but not sent' rationale: 'method provided  to the user of the library' author: 'cyrille.delaunay'>
	"use this method to create a new classic button that will execute the method designed by selector when pressed with the arguments aCollectionOfArguments. The method selector must define and implemented in the subclass"
	
	| button |
	button := PluggableButtonMorphPlus
			on: self getState: nil action: selector.
	button label: aString.
	button arguments: aCollectionOfArguments .
	^button
]

{ #category : #'morph content setup tools' }
WizardPart >> newCheckboxFor: aModel getSelected: getSel setSelected: setSel label: label [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	"return a checkbox with the label label. the value of the checkbox will be accessed by the selector getSel (send to aModel) and set by the selector setSel (send to aModel)."
	^(CheckboxMorph
			on: aModel selected: getSel changeSelected: setSel)
		font: Preferences standardDefaultTextFont;
		label: label;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #'morph content setup tools' }
WizardPart >> newColumnWith: aCollectionOfMorphElements [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	"use this method to create a new column in your block"
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

{ #category : #'morph content setup tools' }
WizardPart >> newGroupboxNamed: aString [ 
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	"Answer a groupbox with the given label."
	^ GroupboxMorph new
		cornerStyle: #rounded;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		label: aString;
		yourself
		

]

{ #category : #'morph content setup tools' }
WizardPart >> newGroupboxNamed: aString With: aMorph [ 
	"Answer a groupbox with the given label and control."
	^ (self newGroupboxNamed: aString)
		addContentMorph: aMorph;
		yourself
]

{ #category : #'morph content setup tools' }
WizardPart >> newGroupboxNamed: aString WithAll: aCollectionOfMorph [ 
	"Answer a groupbox with the given label and controls."
	^ (self newGroupboxNamed: aString)
		addContentMorph: (self newColumnWith: aCollectionOfMorph);
		yourself
]

{ #category : #'morph content setup tools' }
WizardPart >> newLabel: aString [
	"return a simple label displaying the text aString"
	^LabelMorph contents: aString font: Preferences standardDefaultTextFont
]

{ #category : #'morph content setup tools' }
WizardPart >> newListFor: aModel list: listSelector selected: getSelector changeSelected: setSelector [
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	"return a PluggableListMorph. the value of the list will be accessed by the selector listSelector (send to aModel). the index of the current item selected will be accessed by getSelector (send to aModel) and set by the selector setSelector (send to aModel)."
	^PluggableListMorph new
		"selectionColor: self selectionColor;"
		font: Preferences standardDefaultTextFont;
		on: aModel
		list: listSelector
		selected: getSelector
		changeSelected: setSelector
		menu: nil
		keystroke: nil;
		autoDeselect: false;
		cornerStyle: #rounded;
		color: Color white;
		borderStyle: (BorderStyle inset width: 1);
		hResizing: #spaceFill;
		vResizing: #spaceFill; yourself.
		"getEnabledSelector: enabledSel;
		setBalloonText: helpText"
]

{ #category : #'morph content setup tools' }
WizardPart >> newMultiSelectionListFor: aModel list: listSelector primarySelection: primarySelectionSelector changePrimarySelection: changePrimarySelectionSelector listSelection: listSelectionSelector changeListSelection: changeListSelectionSelector [

^ (PluggableListMorphOfMany
		on: aModel
		list: listSelector 
		primarySelection: primarySelectionSelector 
		changePrimarySelection: changePrimarySelectionSelector 
		listSelection: listSelectionSelector 
		changeListSelection: changeListSelectionSelector
		menu: nil )
		font: Preferences standardDefaultTextFont;
		autoDeselect: false;
		cornerStyle: #rounded;
		color: Color white;
		borderStyle: (BorderStyle inset width: 1);
		hResizing: #spaceFill;
		vResizing: #spaceFill; yourself.
]

{ #category : #'morph content setup tools' }
WizardPart >> newRadionButtonFor: aModel getSelected: getSel setSelected: setSel label: aString [


	^(CheckboxMorph
			on: aModel selected: getSel changeSelected: setSel)
		"getEnabledSelector: enabledSel;"
		"font: self labelFont;"
		label: aString;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		"setBalloonText: helpText;"
		beRadioButton
]

{ #category : #'morph content setup tools' }
WizardPart >> newRowWith: aCollectionOfMorphElements [
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

{ #category : #'morph content setup tools' }
WizardPart >> newTextEditorFor: aModel getText: getSel setText: setSel [
	"Answer a text editor for the given model."

	^ (PluggableTextEditorMorph new)
		on: aModel
			text: getSel
			accept: setSel
			readSelection: nil
			menu: nil;
		"font: self textFont;"
		cornerStyle: #rounded;
		hResizing: #rigid;
		vResizing: #spaceFill;
		borderStyle: (BorderStyle inset width: 1);
		"extent: 800@(Preferences standardDefaultTextFont height + 8);"
		color: Color white.
		"selectionColor: self selectionColor"	
			"getEnabledSelector: enabledSel;" 
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	self subclassResponsibility
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> retrieveInputRequired [
	"this method is an abstract method as only the subclass itself know what to do with the input that it needs to make its work "
	"by default do nothing"
	"make here all the thing required to build or make run this wizard part. This method will be clalled by wizardPane before opening the 'page'"
	
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> wizardPane [ 
	"return the wizard pane controling this wizard part"
	^wizardPane 
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> wizardPane: aWizardPane [ 
	"set the wizard pane controling this wizard part"
	^wizardPane := aWizardPane 
]
