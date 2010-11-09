Class {
	#name : #ChooseFilePart,
	#superclass : #WizardPart,
	#instVars : [
		'fileDialog'
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

{ #category : #'initialize-release' }
ChooseFilePart >> initialize [

	super initialize.
	self populateContents: {(self newFileDialogNamed: '') newContentMorph}.
	fileDialog selectPathName: FileDirectory default pathName.
]

{ #category : #'morph content setup tools' }
ChooseFilePart >> newFileDialogNamed: title [

"Answer a morph representing a file open dialog with the given title"

	fileDialog := FileDialogWindow basicNew
		initialize;
		title: title;
		selectPathName: FileDirectory default pathName;
		answerOpenFile.
	"exts ifNotNil: [fd validExtensions: exts].
	path ifNotNil: [fd selectPathName: path]."
	fileDialog answerOpenFile .
	^ fileDialog
	
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
