"
I am a Bellairs workshop held in a given year.

"
Class {
	#name : #BellairsWorkshop,
	#superclass : #AbstractBellairsEntity,
	#traits : 'TParticipationGroupViews',
	#classTraits : 'TParticipationGroupViews classTrait',
	#instVars : [
		'workshop'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #querying }
BellairsWorkshop >> countries [
	^ super countries
]

{ #category : #printing }
BellairsWorkshop >> displayName [
	^ self workshop
]

{ #category : #querying }
BellairsWorkshop >> entries [
	^ self json select: [ :d | (d at: 'workshop') = self workshop ]
]

{ #category : #views }
BellairsWorkshop >> gtInstitutionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Institutions';
		priority: 30;
		object: [ self participations ];
		view: #gtInstitutionsFor:
]

{ #category : #views }
BellairsWorkshop >> gtPersonsFor: aView [
	<gtView>
	^ aView forward
		title: 'Persons';
		priority: 20;
		object: [ self participations ];
		view: #gtPersonsFor:
]

{ #category : #initialization }
BellairsWorkshop >> initializeFrom: aDictionary [
	workshop := aDictionary at: 'workshop'
]

{ #category : #accessing }
BellairsWorkshop >> institutions [
	^ super institutions
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianChildren [
	^ self persons
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianNodeColor [
	^ Color paleRed
]

{ #category : #querying }
BellairsWorkshop >> organizers [
	^ self participations organizers
]

{ #category : #requirement }
BellairsWorkshop >> participations [
	^ super participations
]

{ #category : #querying }
BellairsWorkshop >> persons [
	^ super persons
]

{ #category : #printing }
BellairsWorkshop >> printOn: aStream [
	aStream nextPutAll: self workshop
]

{ #category : #views }
BellairsWorkshop >> summary [
	^ {{'workshop'.
			self workshop.
			self}.
		{'# persons'.
			self persons size printString.
			self arrayOrUniqueElement: self persons}.
		{'# institutions'.
			self institutions size printString.
			self arrayOrUniqueElement: self institutions}.
		{'# countries'.
			self countries size printString.
			self arrayOrUniqueElement: self countries}}
]

{ #category : #accessing }
BellairsWorkshop >> workshop [
	^ workshop
]

{ #category : #accessing }
BellairsWorkshop >> workshops [
	^ {self}
]
