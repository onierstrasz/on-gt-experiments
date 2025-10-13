"
I represent the Institution of a Bellairs workshop participant.

*NB:* a person might change insituitions over the years.
"
Class {
	#name : #BellairsInstitution,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'institution',
		'country',
		'persons'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsInstitution >> country [
	^ country
]

{ #category : #querying }
BellairsInstitution >> entries [
	^ self json select: [ :d | (d at: 'institution') = self institution ]
]

{ #category : #views }
BellairsInstitution >> gtPersonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Persons';
		priority: 30;
		items: [ self persons sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #initialization }
BellairsInstitution >> initializeFrom: aDictionary [
	institution := aDictionary at: 'institution'.
	country := aDictionary at: 'country'
]

{ #category : #accessing }
BellairsInstitution >> institution [
	^ institution
]

{ #category : #accessing }
BellairsInstitution >> name [
	^ self institution
]

{ #category : #querying }
BellairsInstitution >> persons [
	^ persons
		ifNil: [ persons := (self entries collect: [ :d | d at: 'name' ]) copyWithoutDuplicates
					collect: [ :name | self registry personNamed: name ] ]
]

{ #category : #views }
BellairsInstitution >> summary [
	^ {{'institution'.
			self institution}.
		{'country'.
			self country}}
]
