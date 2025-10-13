"
I am a registry for Bellairs workshops. I am initialized from a JSON produced with the help of the {{gtClass:name=BellairsParser}} from web pages listing the workshop participants.

I hold the JSON and use it to create domain entities representing the workshops, their participants, and their institutions.
"
Class {
	#name : #BellairsWorkshopsRegistry,
	#superclass : #Object,
	#instVars : [
		'json',
		'persons',
		'workshops',
		'institutions'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsWorkshopsRegistry >> countries [
	^ (self participations collect: #country) copyWithoutDuplicates sorted
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtCountriesFor: aView [
	"To do: should a country be a domain entity?"

	<gtView>
	^ aView forward
		title: 'Countries';
		priority: 32;
		object: [ self countries ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 60;
		painting: [ :aMondrian | self workshopPersonsGraph: aMondrian ];
		actionUpdateButton
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtInstitutionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Institutions';
		priority: 30;
		items: [ self institutions values sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtParticipationsFor: aView [
	<gtView>
	^ aView forward
		title: 'Participations';
		priority: 50;
		object: [ self participations ];
		view: #gtParticipationsFor:
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtPersonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Persons';
		priority: 20;
		items: [ self persons values sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtWorkshopsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Workshops';
		priority: 10;
		items: [  self workshops values sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initialize [
	workshops := Dictionary new.
	persons := Dictionary new.
	institutions := Dictionary new.
	participations := OrderedCollection new.
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initializeFromJson: aJson [
	json := aJson.

	json
		do: [ :dict | 
			self participations
				add: (BellairsParticipation new
						registry: self;
						data: dict;
						yourself).
			self workshops
				at: (dict at: 'workshop')
				ifAbsentPut: [ BellairsWorkshop new
						registry: self;
						initializeFrom: dict;
						yourself ].
			self persons
				at: (dict at: 'name')
				ifAbsentPut: [ BellairsPerson new
						registry: self;
						initializeFrom: dict;
						yourself ].
			self institutions
				at: (dict at: 'institution')
				ifAbsentPut: [ BellairsInstitution new
						registry: self;
						initializeFrom: dict;
						yourself ] ]
]

{ #category : #querying }
BellairsWorkshopsRegistry >> institutionNamed: aName [
	^ self institutions detect: [ :inst | inst institution = aName ]
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> institutions [
	^ institutions
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> json [
	^ json
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> participations [
	^ BellairsParticipationGroup new
		registry: self;
		data: self json;
		yourself
]

{ #category : #querying }
BellairsWorkshopsRegistry >> personNamed: aName [
	^ self persons detect: [ :person | person name = aName ]
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> persons [
	^ persons
]

{ #category : #querying }
BellairsWorkshopsRegistry >> workshopNamed: aName [
	^ self workshops detect: [ :workshop | workshop workshop = aName ]
]

{ #category : #mondrian }
BellairsWorkshopsRegistry >> workshopPersonsGraph: aMondrian [
	| nodes |
	nodes := self workshops , self persons.
	aMondrian nodes
		shape: [ :node | node mondrianNodeElement ];
		with: nodes.
	aMondrian edges connectToAll: #mondrianChildren.
	aMondrian layout
		custom: (GtGraphForceBasedLayout new
				charge: -1000;
				length: 50).
	^ aMondrian
]

{ #category : #mondrian }
BellairsWorkshopsRegistry >> workshopPersonsMondrianGraph [
	^ self workshopPersonsGraph:GtMondrian new
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> workshops [
	^ workshops
]
