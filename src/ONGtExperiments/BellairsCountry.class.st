"
I represent a country of one of the participants of a Bellairs workshop.
"
Class {
	#name : #BellairsCountry,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'country'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsCountry >> country [
	^ country
]

{ #category : #accessing }
BellairsCountry >> country: anObject [
	country := anObject
]

{ #category : #printing }
BellairsCountry >> displayName [
	^ self country
]

{ #category : #accessing }
BellairsCountry >> entries [
	^ self json select: [ :d | (d at: 'country') = self country ]
]

{ #category : #views }
BellairsCountry >> gtInstitutionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Institutions';
		priority: 30;
		object: [ self participations ];
		view: #gtInstitutionsFor:
]

{ #category : #views }
BellairsCountry >> gtPersonsFor: aView [
	<gtView>
	^ aView forward
		title: 'Persons';
		priority: 20;
		object: [ self participations ];
		view: #gtPersonsFor:
]

{ #category : #views }
BellairsCountry >> gtWorkshopsFor: aView [
	<gtView>
	^ aView forward
		title: 'Workshops';
		priority: 10;
		object: [ self participations ];
		view: #gtWorkshopsFor:
]

{ #category : #initialization }
BellairsCountry >> initializeFrom: aDictionary [
	country := aDictionary at: 'country'
]

{ #category : #views }
BellairsCountry >> summary [
	^ {{'displayName'.
			self displayName.
			self}.
		{'# workshops'.
			self workshops size.
			self workshops}.
		{'# institutions'.
			self institutions size.
			self institutions}.
		{'# persons'.
			self persons size.
			self persons}}
]
