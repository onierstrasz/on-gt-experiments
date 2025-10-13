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

{ #category : #printing }
BellairsParticipationGroup >> displayName [
	"Display the query?"

	^ self searchString ifNil: [ 'a participation group' ]
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
			text: #institution
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
BellairsParticipationGroup >> institutions [
	^ (self collect: [ :p | self registry institutionNamed: p institution ])
		copyWithoutDuplicates
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
	^ (self participationGroupFrom: (data select: [ :d | (d at: 'name') = aName ]))
		searchString: 'for person ', aName
]

{ #category : #accessing }
BellairsParticipationGroup >> persons [
	^ (self collect: [ :p | self registry personNamed: p name ])
		copyWithoutDuplicates
]

{ #category : #accessing }
BellairsParticipationGroup >> searchString [
	^ searchString
]

{ #category : #accessing }
BellairsParticipationGroup >> searchString: anObject [
	searchString := anObject
]

{ #category : #accessing }
BellairsParticipationGroup >> workshops [
	^ (self collect: [ :p | self registry workshopNamed: p workshop ])
		copyWithoutDuplicates
]
