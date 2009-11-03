Class {
	#name : #WizardPart,
	#superclass : #Object,
	#instVars : [
		'morphElements',
		'title',
		'blockContents',
		'wizardPane',
		'name'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
WizardPart class >> named: aString [

	^ super new initialize; name: aString .
]

{ #category : #'accessing - morph' }
WizardPart >> contents [
	"this method should return a morph containing all the elements of this block. It is an abstract method as you should decide the way those elements will be display (for example in a simple PanelMorph or maybe in a GroupBoxMorph or anything else). Use methods like #newRowWith: or #newColumnWith: to dispatch those elements in the way you want. The result should be pluggable to a standard window"
	"^ self subclassResponsibility "
	^   blockContents. 
	
]

{ #category : #'accessing - morph' }
WizardPart >> contents: aCollectionOfMorphElement [
	"this method should return a morph containing all the elements of this block. It is an abstract method as you should decide the way those elements will be display (for example in a simple PanelMorph or maybe in a GroupBoxMorph or anything else). Use methods like #newRowWith: or #newColumnWith: to dispatch those elements in the way you want. The result should be pluggable to a standard window"
	 	
	blockContents := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8.
		
	aCollectionOfMorphElement do: [:each | blockContents addMorphBack: each ].
	^blockContents
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> getInformationRequired [
	"this method is an abstract method as only the subclass itself know what to do with the information that it need to make its work "
	self subclassResponsibility
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> informationValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	self subclassResponsibility .
]

{ #category : #'initialize-release' }
WizardPart >> initialize [

	super initialize.
	morphElements := OrderedCollection new.
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> name [

	^name.
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> name: aString [

	name := aString
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
	"use this method to create a new classic button that will execute the method designed by selector when clicked. The method selector must define and implemented in the subclass"
	
	| button |
	button := PluggableButtonMorphPlus
			on: self getState: nil action: selector.
	button label: aString.
	button arguments: aCollectionOfArguments .
	^button
]

{ #category : #'morph content setup tools' }
WizardPart >> newCheckboxFor: aModel getSelected: getSel setSelected: setSel label: label [

	^(CheckboxMorph
			on: aModel selected: getSel changeSelected: setSel)
		font: Preferences standardDefaultTextFont;
		label: label;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]

{ #category : #'morph content setup tools' }
WizardPart >> newColumnWith: aCollectionOfMorphElements [
		"use this method to create a new column in your block"
	|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
]

{ #category : #'morph content setup tools' }
WizardPart >> newGroupboxNamed: aString [ 
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

	^LabelMorph contents: aString font: Preferences standardDefaultTextFont
]

{ #category : #'morph content setup tools' }
WizardPart >> newListFor: aModel list: listSelector selected: getSelector changeSelected: setSelector [
	
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
		vResizing: #spaceFill.
		"getEnabledSelector: enabledSel;
		setBalloonText: helpText"
]

{ #category : #'morph content setup tools' }
WizardPart >> newRowWith: aCollectionOfMorphElements [
	"use this method to create a new row in your block"
		|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> retrieveInformationRequired [
	"this method is an abstract method as only the subclass itself know what to do with the information that it need to make its work "
	"by default do nothing"
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> wizardPane [ 

	^wizardPane 
]

{ #category : #'accessing - wizard mangement' }
WizardPart >> wizardPane: aWizardPane [ 

	^wizardPane := aWizardPane 
]
