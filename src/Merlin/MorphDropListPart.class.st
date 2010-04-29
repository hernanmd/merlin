Class {
	#name : #MorphDropListPart,
	#superclass : #DropListPart,
	#category : #'Merlin-Parts'
}

{ #category : #'initialize-release' }
MorphDropListPart >> initializeDropList [

	dropList := self newDropListSelfControllingFor: {Morph new}
]

{ #category : #'morph content setup tools' }
MorphDropListPart >> newDropListSelfControllingFor: aCollectionOfItems [
			
	| tmpDropList |
	self list: aCollectionOfItems .
	self selectionIndex: 1.
	tmpDropList := (MorphDropListMorph
			on: self
			list: #list 
			selected: #selectionIndex
			changeSelected: #selectionIndex:
			useIndex: true)
		"selectionColor: self selectionColor;
		getEnabledSelector: enabledSel;"
		cornerStyle: #rounded;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
		"setBalloonText: helpText"
		
	
	^ tmpDropList.
	
]

{ #category : #'accessing - wizard mangement' }
MorphDropListPart >> outputValue [

	^self selectionIndex
]
