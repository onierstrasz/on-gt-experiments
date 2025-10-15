"
I contain various examples of Bellairs Workshop entities, including relevant tests.

The key example is:
```
BellairsExamples new bellairsRegistry
```

"
Class {
	#name : #BellairsExamples,
	#superclass : #Object,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #examples }
BellairsExamples >> bellairsJsonFromStoredJsonFile [
	<gtExample>
	^ BellairsParserExamples new bellairsJsonFromStoredJsonFile
]

{ #category : #examples }
BellairsExamples >> bellairsRegistry [
	<gtExample>
	| registry |
	registry := BellairsWorkshopsRegistry new initializeFromJson: self bellairsJsonFromStoredJsonFile.
	self assert: registry json size equals: registry participations size.
	^ registry
]

{ #category : #examples }
BellairsExamples >> firstCountry [
	<gtExample>
	| country registry |
	registry := BellairsExamples new bellairsRegistry.
	country := registry countries first.
	"self assert: country registry equals: registry.
	self assert: country json equals: registry json.
	self assert: country countries size equals: 10.
	self assert: country participations size equals: 17."
	^ country
]

{ #category : #examples }
BellairsExamples >> firstInstitution [
	<gtExample>
	| institution registry |
	registry := BellairsExamples new bellairsRegistry.
	institution := registry institutions first.
	self assert: institution workshops size equals: 1.
	self assert: institution persons size equals: 1.
	self assert: institution participations size equals: 1.
	^ institution
]

{ #category : #examples }
BellairsExamples >> firstPerson [
	<gtExample>
	| person registry |
	registry := BellairsExamples new bellairsRegistry.
	person := registry persons first.
	self assert: person workshops size equals: 1.
	self assert: person institutions size equals: 1.
	self assert: person participations size equals: 1.
	^ person
]

{ #category : #examples }
BellairsExamples >> firstWorkshop [
	<gtExample>
	| workshop registry |
	registry := BellairsExamples new bellairsRegistry.
	workshop := registry workshops first.
	self assert: workshop registry equals: registry.
	self assert: workshop json equals: registry json.
	self assert: workshop countries size equals: 7.
	self assert: workshop participations size equals: 17.
	^ workshop
]
