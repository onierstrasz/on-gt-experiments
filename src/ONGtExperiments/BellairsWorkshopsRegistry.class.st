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

{ #category : #views }
BellairsWorkshopsRegistry >> gtGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		painting: [ :aMondrian | self workshopPersonsGraph: aMondrian ];
		actionUpdateButton
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtInstitutionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Institutions';
		priority: 30;
		items: [ self institutions values sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
BellairsWorkshopsRegistry >> gtPersonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Persons';
		priority: 20;
		items: [ self persons values sortedAs: #name ];
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
		items: [  self workshops values sortedAs: #name ];
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
	institutions := Dictionary new
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initializeFromJson: aJson [
	json := aJson.

	json
		do: [ :dict | 
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
	^ self institutions detect: [ :inst | inst name = aName ]
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> institutions [
	^ institutions
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> json [
	^ json
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
	^ self workshops detect: [ :workshop | workshop name = aName ]
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
