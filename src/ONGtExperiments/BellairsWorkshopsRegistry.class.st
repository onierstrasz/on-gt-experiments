"
I am a registry for Bellairs workshops. I am initialized from a JSON produced with the help of the {{gtClass:name=BellairsParser}} from web pages listing the workshop participants.

I hold the JSON and use it to create domain entities representing the workshops, their participants, and their institutions.
"
Class {
	#name : #BellairsWorkshopsRegistry,
	#superclass : #Object,
	#traits : 'TParticipationGroupViews',
	#classTraits : 'TParticipationGroupViews classTrait',
	#instVars : [
		'json',
		'personDict',
		'workshopDict',
		'instDict'
	],
	#category : #'ONGtExperiments-Bellairs'
}

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
BellairsWorkshopsRegistry >> gtWorkshopsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Workshops';
		priority: 10;
		items: [  self workshops sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initialize [
	workshopDict := Dictionary new.
	personDict := Dictionary new.
	instDict := Dictionary new
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initializeFromJson: aJson [
	json := aJson.

	json
		do: [ :dict | 
			workshopDict
				at: (dict at: 'workshop')
				ifAbsentPut: [ BellairsWorkshop new
						registry: self;
						initializeFrom: dict;
						yourself ].
			personDict
				at: (dict at: 'name')
				ifAbsentPut: [ BellairsPerson new
						registry: self;
						initializeFrom: dict;
						yourself ].
			instDict
				at: (dict at: 'institution')
				ifAbsentPut: [ BellairsInstitution new
						registry: self;
						initializeFrom: dict;
						yourself ] ]
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> instDict [
	^ instDict
]

{ #category : #querying }
BellairsWorkshopsRegistry >> institutionNamed: aName [
	^ self instDict detect: [ :inst | inst institution = aName ]
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> institutions [
	^ instDict values
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

{ #category : #accessing }
BellairsWorkshopsRegistry >> personDict [
	^ personDict
]

{ #category : #querying }
BellairsWorkshopsRegistry >> personNamed: aName [
	^ self personDict detect: [ :person | person name = aName ]
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> persons [
	^ self personDict values
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> workshopDict [
	^ workshopDict
]

{ #category : #querying }
BellairsWorkshopsRegistry >> workshopNamed: aName [
	^ self workshopDict detect: [ :workshop | workshop workshop = aName ]
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
	^ workshopDict values
]
