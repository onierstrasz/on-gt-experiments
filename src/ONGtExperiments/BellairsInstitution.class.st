"
I represent the Institution of a Bellairs workshop participant.

*NB:* a person might change insituitions over the years.
"
Class {
	#name : #BellairsInstitution,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'countryName'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsInstitution >> country [
	^ self registry countryNamed: countryName
]

{ #category : #querying }
BellairsInstitution >> entries [
	^ self json select: [ :d | (d at: 'institution') = self institution ]
]

{ #category : #views }
BellairsInstitution >> gtPersonsFor: aView [
	<gtView>
	^ aView forward
		title: 'Persons';
		priority: 20;
		object: [ self participations ];
		view: #gtPersonsFor:
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
	name := aDictionary at: 'institution'.
	countryName := aDictionary at: 'country'.
]

{ #category : #accessing }
BellairsInstitution >> institution [
	^ name
]

{ #category : #views }
BellairsInstitution >> summary [
	^ {{'name'.
			self name}.
		{'country'.
			self country}}
]
