Class {
	#name : #ChooseFilePart,
	#superclass : #WizardPart,
	#instVars : [
		'fileDialog',
		'fileDialogMorph'
	],
	#category : #'Merlin-Parts'
}

{ #category : #accessing }
ChooseFilePart >> defaultDirectoryPath: aPathString [

	"set the initial list of directories to tne ones included in the directory with path aPathString"
	| fileDirectory |
	fileDirectory := FileDirectory on: aPathString.
	fileDialog directories: ( Array with: (
		FileDirectoryWrapper 
			with: fileDirectory
			name: fileDirectory localName 
			model: fileDialog)).
			
	self populateContents: {fileDialog newContentMorph  }
]

{ #category : #accessing }
ChooseFilePart >> fileDialog [ 

	^ fileDialog ifNil: [fileDialog := self newFileDialogNamed: '']
]

{ #category : #accessing }
ChooseFilePart >> fileDialog: aFileDialog [

	fileDialog := aFileDialog
]

{ #category : #accessing }
ChooseFilePart >> fileDialogMorph [

	^ fileDialogMorph ifNil: [fileDialogMorph := self fileDialog newContentMorph ]

]

{ #category : #accessing }
ChooseFilePart >> fileDialogMorph: aFileDialogMorph [

	fileDialogMorph := aFileDialogMorph

]

{ #category : #'initialize-release' }
ChooseFilePart >> initialize [

	super initialize.
	"self populateContents: {(self newFileDialogNamed: '') newContentMorph}."
	self fileDialog selectPathName: FileDirectory default pathName.
]

{ #category : #accessing }
ChooseFilePart >> latePopulateContents [
	
	|default|
	groupBoxName 
		ifNotNilDo: [:aStringOrABlock |self populateContents: {self newGroupboxNamed: (aStringOrABlock meValue: self requiredInputs)  With: self fileDialogMorph}.]
		ifNil: [self populateContents: {self fileDialogMorph}].

	
	
]

{ #category : #accessing }
ChooseFilePart >> mightHasChanged [
	"The contents of a part might has changed without the part itself know it (This is the case for a textField). This method will be called by the parent wizard pane to be sure all has been corretly done before opening the next pane. By default does nothing. If you have to make something special before opening the next pane, it 's the good place to do it'"
	
	self hasChanged
]

{ #category : #'morph content setup tools' }
ChooseFilePart >> newFileDialogNamed: title [

"Answer a morph representing a file open dialog with the given title"

	|tmpFileDialog|
	tmpFileDialog := FileDialogWindow basicNew
		initialize;
		title: title;
		selectPathName: FileDirectory default pathName;
		answerOpenFile.
	"exts ifNotNil: [fd validExtensions: exts].
	path ifNotNil: [fd selectPathName: path]."
	tmpFileDialog answerOpenFile .
	^ tmpFileDialog
	
]

{ #category : #'accessing - wizard mangement' }
ChooseFilePart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	""
	^ fileDialog selectedPathName
]

{ #category : #accessing }
ChooseFilePart >> selectAndExpandDirectory: aDirectory [
	"select the  specified directory and expand it in the tree list"
	
	fileDialog selectDirectory: aDirectory.
	self populateContents: {fileDialog newContentMorph}.
	fileDialog directoryTreeMorph selectedMorph ifNil: [fileDialog selectDirectory: aDirectory.].
	fileDialog directoryTreeMorph expandFirstLevel:  fileDialog directoryTreeMorph selectedMorph .
	
	"fileDialog selectDirectory: (FileDirectory on: 'Users/delaunay')."
	
]

{ #category : #accessing }
ChooseFilePart >> selectDirectory: aDirectory [
	"select the  specified directory and expand it in the tree list"
	self deprecated: 'use selectAndExpandDirectory instead'.
	fileDialog selectDirectory: aDirectory.
	self populateContents: {fileDialog newContentMorph}.
	fileDialog directoryTreeMorph selectedMorph ifNil: [fileDialog selectDirectory: aDirectory.].
	fileDialog directoryTreeMorph expandFirstLevel:  fileDialog directoryTreeMorph selectedMorph .
	
	"fileDialog selectDirectory: (FileDirectory on: 'Users/delaunay')."
	
]

{ #category : #accessing }
ChooseFilePart >> selectPathName: aPathString [
	""
	fileDialog selectPathName: aPathString.
]

{ #category : #accessing }
ChooseFilePart >> validExtensions: aCollectionOfStrings [

	fileDialog validExtensions: aCollectionOfStrings
]
