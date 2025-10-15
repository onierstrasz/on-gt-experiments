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
BellairsExamples >> firstAffiliation [
	<gtExample>
	| affiliation registry |
	registry := BellairsExamples new bellairsRegistry.
	affiliation := registry affiliations first.
	self assert: affiliation workshops size equals: 1.
	self assert: affiliation persons size equals: 1.
	self assert: affiliation participations size equals: 1.
	^ affiliation
]

{ #category : #examples }
BellairsExamples >> firstCountry [
	<gtExample>
	| country registry |
	registry := BellairsExamples new bellairsRegistry.
	country := registry countries first.
	self assert: country registry equals: registry.
	self assert: country json equals: registry json.
	self assert: country workshops size equals: 4.
	self assert: country persons size equals: 3.
	self assert: country affiliations size equals: 2.
	self assert: country participations size equals: 4.
	^ country
]

{ #category : #examples }
BellairsExamples >> firstPerson [
	<gtExample>
	| person registry |
	registry := BellairsExamples new bellairsRegistry.
	person := registry persons first.
	self assert: person workshops size equals: 1.
	self assert: person affiliations size equals: 1.
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
	self assert: workshop persons size equals: 17.
	self assert: workshop affiliations size equals: 11.
	self assert: workshop countries size equals: 7.
	self assert: workshop participations size equals: 17.
	^ workshop
]
