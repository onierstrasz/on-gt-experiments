"
I contain various examples of Bellairs Workshop entities, including relevant tests.

The key example is:
```
BellairsExamples new bellairsRegistry
```

This uses a stored JSON file ({{gtMethod:name=BellairsExamples>>#participantsTestFile}}) which has been produced from the source data.
To update this JSON, use the example {{gtMethod:name=BellairsExamples>>#writeParticipantsToTestFile}}.

"
Class {
	#name : #BellairsExamples,
	#superclass : #Object,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #examples }
BellairsExamples >> allLines [
	"Split the data from the cached test file into lines, since parse the input line-by-line."

	<gtExample>
	| allLines |
	allLines := self participantsTestFile contents lines.
	self assert: allLines size > 500.
	^ allLines
]

{ #category : #examples }
BellairsExamples >> bellairsGtJson [
	<gtExample>
	^ self bellairsJson asGtJson
]

{ #category : #examples }
BellairsExamples >> bellairsJson [
	"NB: the assertions will be fragile in case the test data are update."

	<gtExample>
	| parser json |
	parser := BellairsParser new.
	json := self allLines
			collect: [ :line | parser parse: line ]
			thenSelect: #notNil.
	self assert: json size equals: 135.
	self assert: (json collect: [ :d | d at: 'workshop' ]) asSet size equals: 8.
	self assert: (json collect: [ :d | d at: 'role' ]) asSet size equals: 2.
	^ json
]

{ #category : #examples }
BellairsExamples >> bellairsPrettyJsonString [
	<gtExample>
	<noTest>
	^ STONJSON toStringPretty: self bellairsJson
]

{ #category : #examples }
BellairsExamples >> bellairsRegistry [
	<gtExample>
	| registry |
	registry := BellairsWorkshopsRegistry new initializeFromJson: self bellairsJson.
	^ registry
]

{ #category : #examples }
BellairsExamples >> dataFolder [
	<gtExample>
	^ FileLocator gtResource / 'onierstrasz' / 'on-gt-experiments' / 'data'
]

{ #category : #examples }
BellairsExamples >> jsonFromTestFile [
	<gtExample>
	<noTest>
	^ STONJSON fromString: self jsonTestFile contents
]

{ #category : #examples }
BellairsExamples >> jsonTestFile [
	<gtExample>
	^ self dataFolder / 'bellairsParticipants.json'
]

{ #category : #examples }
BellairsExamples >> participants [
	"Only download the source data if we need to update the test file."

	<gtExample>
	<noTest>
	| participants |
	participants := (18 to: 26)
			collect: [ :year | 
				[ ZnClient new
					get: 'https://bellairs20' , year asString , '.ece.mcgill.ca/participants.htm' ]
					onErrorDo: [ nil ] ]
			thenSelect: #notNil.
	^ participants
]

{ #category : #examples }
BellairsExamples >> participantsTestFile [
	<gtExample>
	^ self dataFolder / 'bellairsParticipants.txt'
]

{ #category : #examples }
BellairsExamples >> writeParticipantsToTestFile [
	"Write all of the participant webfiles to a single, cached test file."

	<gtExample>
	<noTest>
	| testFile |
	testFile := self participantsTestFile.
	testFile ensureDelete.
	testFile
		writeStreamDo: [ :aStream | 
			self participants do: [ :each | aStream nextPutAll: each ].
			aStream close ].
	^ testFile
]

{ #category : #examples }
BellairsExamples >> writePrettyJsonTestFile [
	"Pretty print the JSON."

	<gtExample>
	<noTest>
	| jsonFile |
	jsonFile := self jsonTestFile.
	jsonFile ensureDelete.
	jsonFile
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: self bellairsPrettyJsonString.
			aStream close ].
	^ jsonFile
]
