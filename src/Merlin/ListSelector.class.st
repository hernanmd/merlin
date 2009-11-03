Class {
	#name : #ListSelector,
	#superclass : #WizardPart,
	#instVars : [
		'addButton',
		'selectionList',
		'selectionListSelectionIndex',
		'removeButton',
		'initialList',
		'initialListSelectionIndex'
	],
	#category : #Merlin
}

{ #category : #'instance creation' }
ListSelector class >> on: initialList [

	^super new initialize ;initialList: initialList; boxInitialization .
]

{ #category : #'private - customization' }
ListSelector >> addRowWithAll: collectionOfMorphElements withTitle: aString [
	"enable the customization of this PackageSelector. Add a new row under the packages list with all elements contained in collectionOfMorphElements "
	| tmpBuilderMainContent |
	tmpBuilderMainContent := self contents submorphs asOrderedCollection .
	tmpBuilderMainContent add: 
		(self newRowWith: { 
			(self 
				newGroupboxNamed: aString
				WithAll: {  (self newRowWith: collectionOfMorphElements )  }).
			(self newColumnWith: {   }).
			(self newColumnWith: {   })
		}).

	self contents:(  
		tmpBuilderMainContent asArray
	).

]

{ #category : #'private - customization' }
ListSelector >> addStringMessage: aString ForRowIndexedBy: anIndex [
	"allow the user to dynamically add a message (wich can be for example an error message or informations missing) to the new row he created before at the anIndex position (the index one is attributed to the packageSelector stuff) "
	| initialBuilderMainContent tmpBuilderMainContent |
	
	initialBuilderMainContent := self contents submorphs asOrderedCollection .
	"tmpBuilderMainContent represent the new content of main window (in wich we will add the message)"
	tmpBuilderMainContent := OrderedCollection new.
	"all the row before the the row number anIndex don't change"
	1 to: (anIndex - 1) do: [:index | tmpBuilderMainContent add: (initialBuilderMainContent at: index)].
	"We add the message to the row number anIndex"
	tmpBuilderMainContent add: (
		self newRowWith: {
			(initialBuilderMainContent at: anIndex) submorphs detect: [:component | component isKindOf: GroupboxMorph ].
			self newColumnWith: { self newGroupboxNamed:   'Information' With: (self newLabel: aString)}.
		}).
	"the rows remaining don't change'"
	anIndex  to: (initialBuilderMainContent size) - 1 do: [:index | tmpBuilderMainContent add: (initialBuilderMainContent at: (index + 1))].
	
	"we set the new content of the window"
		self contents:(  
		tmpBuilderMainContent
	).
	wizardPane buildDialogWindow  .
	
	
]

{ #category : #'morph initialization' }
ListSelector >> boxInitialization [
	| morphPackagesList morphSelectionList |
	"morphElements add: "(morphSelectionList := self newSelectionList).
	"morphElements add: "(morphPackagesList := self newInitialList).
	self contents:{ self newRowWith: { 
			("morphElements add:" (self 
					newGroupboxNamed: 'Packages' translated
					With: morphPackagesList)).
			(self newColumnWith: { 
					(self newRowWith: {   }).
					(self newRowWith: {   }).
					(self newRowWith: {   }).
					(self newAddButton).
					(self newRowWith: {   }).
					(self newRemoveButton)
				 }).
			(self newColumnWith: { 
					(self 
						newGroupboxNamed: 'Selection' translated
						With: morphSelectionList)
				 })
		 }}
]

{ #category : #'private - customization' }
ListSelector >> deleteStringMessageFromRowIndexedBy: anIndex [
	"allow the user to dynamically delete a message he put before at the row number anIndex (the index 1 is attributed to the PackageSelectorStuff) "
	| initialBuilderMainContent tmpBuilderMainContent |
	
	initialBuilderMainContent := self contents submorphs asOrderedCollection .
	"tmpBuilderMainContent represent the new content of main window (in wich we will add the message)"
	tmpBuilderMainContent := OrderedCollection new.
	"all the row before the the row number anIndex don't change"
	1 to: (anIndex - 1) do: [:index | tmpBuilderMainContent add: (initialBuilderMainContent at: index)].
	"We delete the message from the row number anIndex"
	tmpBuilderMainContent add: (
		self newRowWith: {
			(initialBuilderMainContent at: anIndex) submorphs detect: [:component | (component isKindOf: GroupboxMorph)  ].
			self newColumnWith: { }.
		}).
	"the rows remaining don't change'"
	anIndex  to: (initialBuilderMainContent size) - 1 do: [:index | tmpBuilderMainContent add: (initialBuilderMainContent at: (index + 1))].
	"we set the new content of the window"
		self contents:( 
		tmpBuilderMainContent asArray
	).
	wizardPane buildDialogWindow .
	
]

{ #category : #'initialize-release' }
ListSelector >> initialList: aCollectionOfString [
	"	enable this PackageSelector to use aCollectionOfString as initial packages list"
	initialList := aCollectionOfString asSortedCollection: [ :a :b | a < b ]
]

{ #category : #'initialize-release' }
ListSelector >> initialize [
	super initialize.
	"initialization for the packages list control :"
	"self setDefaultPackagesList."
	initialListSelectionIndex := 0.

	"initialization for the selection list control : "
	selectionListSelectionIndex := 0.
	selectionList := SortedCollection new.
	
]

{ #category : #'morph initialization' }
ListSelector >> newAddButton [ 
	"return the button that will be used to add a package from the packagesList to the selectionList. While no item is selected in the packagesList, this button is disable "
	

	addButton := PluggableButtonMorphPlus
			on: self getState: nil action: #updateWhenAddingItem.
	addButton label: '>>>'.
	addButton disable.
	^addButton
]

{ #category : #'morph initialization' }
ListSelector >> newColumnWith: aCollectionOfMorphElements [

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

{ #category : #'morph initialization' }
ListSelector >> newGroupboxNamed: aString [ 
	"Answer a groupbox with the given label."
	^ GroupboxMorph new
		cornerStyle:#rounded;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		label: aString;
		yourself
		"^ wizardPane dialogWindow newGroupbox: aString"
]

{ #category : #'morph initialization' }
ListSelector >> newGroupboxNamed: aString With: aMorph [ 
	"Answer a groupbox with the given label and control."
	^ (self newGroupboxNamed: aString)
		addContentMorph: aMorph;
		yourself
]

{ #category : #'morph initialization' }
ListSelector >> newGroupboxNamed: aString WithAll: aCollectionOfMorph [ 
	"Answer a groupbox with the given label and controls."
	^ (self newGroupboxNamed: aString)
		addContentMorph: (self newColumnWith: aCollectionOfMorph);
		yourself
]

{ #category : #'morph initialization' }
ListSelector >> newInitialList [
	"return a new list (PluggableListMorph) that will contain the initial list of items that can be selected by the user"
	"^ (PluggableListMorph  
		on: self
		list: #packagesList
		selected: #packagesListSelectionIndex
		changeSelected: #packagesListSelectionIndex:
		)"
		^ (self newListFor: self list: #packagesList  selected: #packagesListSelectionIndex changeSelected: #packagesListSelectionIndex: )
		minWidth: 300;
		minHeight: 400; yourself
]

{ #category : #'morph initialization' }
ListSelector >> newRemoveButton [
	"return the button that will be used to remove a package from the selectionList to the packagesList. While no item is selected in the selectionList, this button is disable "
	

	removeButton := PluggableButtonMorphPlus
			on: self getState: nil action: #updateWhenRemovingItem.
	removeButton label: '<<<'.
	removeButton disable.
	^removeButton
]

{ #category : #'morph initialization' }
ListSelector >> newRowWith: aCollectionOfMorphElements [

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

{ #category : #'morph initialization' }
ListSelector >> newSelectionList [
	"return a new list (PluggableListMorph) that will contain all the packages selected by the user"
	"^ (PluggableListMorph 
		on: self
		list: #selectionList
		selected: #selectionListSelectionIndex
		changeSelected: #selectionListSelectionIndex:)"
	^( self newListFor: self 
			list: #selectionList
			selected:  #selectionListSelectionIndex
			changeSelected: #selectionListSelectionIndex:)
		minWidth: 300;
		minHeight: 400;
		yourself
]

{ #category : #'initial list control' }
ListSelector >> packagesList [
	^ initialList
	
]

{ #category : #'initial list control' }
ListSelector >> packagesList: anObject [ 
	"Set the value of list"
	initialList := anObject.
	self changed: #packagesList.
	
	"Here we check that the selectionIndex is updated according the new list size  "
	self packagesListSelectionIndex > self packagesList size
		ifFalse: [^self ].
	
	self packagesListSelectionIndex: self packagesList size.
	self changed: #selectionListSelectionIndex  
]

{ #category : #'initial list control' }
ListSelector >> packagesListSelectedItem [
	"Answer the currently selected item or nil if none."
	^ self packagesListSelectionIndex = 0 
		ifTrue: [ nil ]
		ifFalse: [ self packagesList at: self packagesListSelectionIndex ]
]

{ #category : #'initial list control' }
ListSelector >> packagesListSelectionIndex [
	^ initialListSelectionIndex
]

{ #category : #'initial list control' }
ListSelector >> packagesListSelectionIndex: anIndex [ 

	initialListSelectionIndex := anIndex.	
		
	initialListSelectionIndex > 0 
	"when a package is selected in the packagesList, .."
		ifTrue: [ 

	"we make sure that the addButton can be clicked on : "
			addButton enable.
	"we disable the selection of the selection list : "
			self selectionListSelectionIndex: 0.
			self changed: # selectionListSelectionIndex]
 
		ifFalse: [ 
			addButton disable 
			].
	
	self changed: #packagesListSelectionIndex.
]

{ #category : #'selection list control' }
ListSelector >> selectionList [
	^ selectionList
	
]

{ #category : #'selection list control' }
ListSelector >> selectionList: anObject [ 
	"Set the value of selectionList"
	selectionList := anObject.
	self changed: #selectionList.
	
	"Here we check that the selectionIndex is updated according the new list size  "
	self selectionListSelectionIndex > self selectionList size
		ifFalse: [^self ].
	
	self selectionListSelectionIndex: self selectionList size.
	self changed: #selectionListSelectionIndex  
			
]

{ #category : #'selection list control' }
ListSelector >> selectionListSelectedItem [ 
	"Answer the currently selected item in the selection list or nil if none."

	^self selectionListSelectionIndex = 0
		ifTrue: [nil]
		ifFalse: [self selectionList at: self selectionListSelectionIndex]
]

{ #category : #'selection list control' }
ListSelector >> selectionListSelectionIndex [

	^ selectionListSelectionIndex.
]

{ #category : #'selection list control' }
ListSelector >> selectionListSelectionIndex: anIndex [

	selectionListSelectionIndex := anIndex.
	self changed: #selectionListSelectionIndex.
	
	
	self selectionListSelectionIndex > 0
		ifTrue: [
		"we make sure that the removeButton is enabled when a package is selected :"
			removeButton enable.
		"we disable the selection of the packages list : "
			self packagesListSelectionIndex: 0.
			self changed: # packagesListSelectionIndex
			]
		ifFalse: [removeButton disable].
]

{ #category : #actions }
ListSelector >> updateWhenAddingItem [
	| tmpPackagesList package initialPackages |
	package := self packagesListSelectedItem asString.
	tmpPackagesList := OrderedCollection withAll: self selectionList.
	tmpPackagesList add: package.

	" we remove the selected package from the initial list :"
	initialPackages := self packagesList.
	initialPackages remove: package.
	self packagesList: initialPackages.
	"if the initial become empty, we disable de add button"
	initialPackages isEmpty ifTrue: [addButton disable].	

	" we update the list of packages of the selection morph list :"
	"listModel packagesList: list."
	self selectionList: tmpPackagesList.

]

{ #category : #actions }
ListSelector >> updateWhenRemovingItem [
	"we remove the selected item from the selection list : "
	| list package tmpPackagesList |
	package := self selectionListSelectedItem.
	list := self selectionList.
	list remove: package.
	self selectionList: list.
	"if the selection become empty, we disable the remove button :"
	list isEmpty ifTrue: [removeButton disable]. 

	"we move the removed package into the packages list :"
	tmpPackagesList := self packagesList.
	tmpPackagesList add: package.
	self packagesList: tmpPackagesList.

]
