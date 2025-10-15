"
I represent a group of Participations, typically as the result of a query.

"
Class {
	#name : #BellairsParticipationGroup,
	#superclass : #AbstractBellairsEntity,
	#traits : 'TGtGroup + TParticipationGroupViews',
	#classTraits : 'TGtGroup classTrait + TParticipationGroupViews classTrait',
	#instVars : [
		'data',
		'searchString'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsParticipationGroup >> affiliations [
	^ (self collect: [ :p | self registry institutionNamed: p affiliation ])
		copyWithoutDuplicates
]

{ #category : #requirement }
BellairsParticipationGroup >> countries [
	^ (self collect: [ :p | self registry countryNamed: p country ])
		copyWithoutDuplicates
]

{ #category : #accessing }
BellairsParticipationGroup >> data [
	^ data
]

{ #category : #accessing }
BellairsParticipationGroup >> data: aDictionary [
	data := aDictionary
]

{ #category : #'as yet unclassified' }
BellairsParticipationGroup >> entries [
	^ data
]

{ #category : #views }
BellairsParticipationGroup >> gtOrganizersFor: aView [
	<gtView>
	^ aView forward
		title: 'Organizers';
		priority: 25;
		object: [ self organizers ];
		view: #gtPersonsFor:
]

{ #category : #views }
BellairsParticipationGroup >> gtParticipationsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Participations';
		priority: 50;
		items: [ self participations ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Workshop'
			text: #workshop
			width: 200;
		column: 'Person'
			text: #name
			width: 180;
		column: 'Role'
			text: #role
			width: 100;
		column: 'Institution'
			text: #affiliation
			width: 180;
		column: 'Country'
			text: #country
			width: 180;
		column: 'URL'
			text: #url
			width: 180;
		actionUpdateButton
]

{ #category : #accessing }
BellairsParticipationGroup >> items [
	^ self entries
		collect: [ :dict | 
			BellairsParticipation new
				registry: self registry;
				data: dict;
				yourself ]
]

{ #category : #printing }
BellairsParticipationGroup >> name [
	"Display the query?"

	^ self searchString ifNil: [ 'a participation group' ]
]

{ #category : #querying }
BellairsParticipationGroup >> organizers [
	^ self
		participationGroupFrom: ((self select: [ :p | p role = 'Organizer' ]) collect: #data)
]

{ #category : #accessing }
BellairsParticipationGroup >> participations [
	^ self "entries
		collect: [ :dict | 
			BellairsParticipation new
				registry: self registry;
				data: dict;
				yourself ]"
]

{ #category : #accessing }
BellairsParticipationGroup >> participationsWithPersonNamed: aName [
	^ (self participationGroupFrom: (data select: [ :d | (d at: 'person') = aName ]))
		searchString: 'for person ', aName
]

{ #category : #accessing }
BellairsParticipationGroup >> persons [
	^ (self collect: [ :p | self registry personNamed: p person ])
		copyWithoutDuplicates
]

{ #category : #accessing }
BellairsParticipationGroup >> searchString [
	^ searchString
]

{ #category : #accessing }
BellairsParticipationGroup >> searchString: aString [
	searchString := aString
]

{ #category : #views }
BellairsParticipationGroup >> summary [
	^ {{'name'.
			self name.
			self}.
		{'# workshops'.
			self workshops size.
			self arrayOrUniqueElement: self workshops}.
		{'# persons'.
			self persons size.
			self arrayOrUniqueElement: self persons}.
		{'# institutions'.
			self affiliations size.
			self arrayOrUniqueElement: self affiliations}.
		{'# countries'.
			self countries size.
			self arrayOrUniqueElement: self countries}.
		{'# participations'.
			self participations size.
			self arrayOrUniqueElement: self participations}}
]

{ #category : #accessing }
BellairsParticipationGroup >> urls [
	^ (self collect: #url) copyWithoutDuplicates
]

{ #category : #accessing }
BellairsParticipationGroup >> workshops [
	^ (self collect: [ :p | self registry workshopNamed: p workshop ])
		copyWithoutDuplicates
]
