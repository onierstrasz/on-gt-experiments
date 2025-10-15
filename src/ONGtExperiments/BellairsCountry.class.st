"
I represent a country of one of the participants of a Bellairs workshop.
"
Class {
	#name : #BellairsCountry,
	#superclass : #AbstractBellairsEntity,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsCountry >> country [
	^ name
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
	name := aDictionary at: 'country'
]

{ #category : #views }
BellairsCountry >> summary [
	^ {{'name'.
			self name.
			self}.
		{'# workshops'.
			self workshops size.
			self arrayOrUniqueElement: self workshops}.
		{'# institutions'.
			self institutions size.
			self arrayOrUniqueElement: self institutions}.
		{'# persons'.
			self persons size.
			self arrayOrUniqueElement: self persons}}
]
