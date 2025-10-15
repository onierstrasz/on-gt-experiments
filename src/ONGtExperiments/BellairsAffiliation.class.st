"
I represent the Institution of a Bellairs workshop participant.

*NB:* a person might change insituitions over the years.
"
Class {
	#name : #BellairsAffiliation,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'countryName'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsAffiliation >> affiliation [
	^ self
]

{ #category : #accessing }
BellairsAffiliation >> country [
	^ self registry countryNamed: countryName
]

{ #category : #querying }
BellairsAffiliation >> entries [
	^ self json select: [ :d | (d at: 'affiliation') = self name ]
]

{ #category : #views }
BellairsAffiliation >> gtPersonsFor: aView [
	<gtView>
	^ aView forward
		title: 'Persons';
		priority: 20;
		object: [ self participations ];
		view: #gtPersonsFor:
]

{ #category : #views }
BellairsAffiliation >> gtWorkshopsFor: aView [
	<gtView>
	^ aView forward
		title: 'Workshops';
		priority: 10;
		object: [ self participations ];
		view: #gtWorkshopsFor:
]

{ #category : #initialization }
BellairsAffiliation >> initializeFrom: aDictionary [
	name := aDictionary at: 'affiliation'.
	countryName := aDictionary at: 'country'.
]

{ #category : #views }
BellairsAffiliation >> summary [
	^ {{'Name'.
			self name.
			self}.
		{'Country'.
			self country}}
]
