"
I represent the Institution of a Bellairs workshop participant.

*NB:* a person might change insituitions over the years.
"
Class {
	#name : #BellairsInstitution,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'institution',
		'countryName'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsInstitution >> country [
	^ self registry countryNamed: countryName
]

{ #category : #printing }
BellairsInstitution >> displayName [
	^ self institution
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

{ #category : #views }
BellairsInstitution >> gtWorkshopsFor: aView [
	<gtView>
	^ aView forward
		title: 'Workshops';
		priority: 10;
		object: [ self participations ];
		view: #gtWorkshopsFor:
]

{ #category : #initialization }
BellairsInstitution >> initializeFrom: aDictionary [
	institution := aDictionary at: 'institution'.
	countryName := aDictionary at: 'country'.
]

{ #category : #accessing }
BellairsInstitution >> institution [
	^ institution
]

{ #category : #views }
BellairsInstitution >> summary [
	^ {{'institution'.
			self institution}.
		{'country'.
			self country}}
]
