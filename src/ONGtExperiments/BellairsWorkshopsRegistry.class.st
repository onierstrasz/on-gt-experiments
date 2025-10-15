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
		'instDict',
		'countryDict'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsWorkshopsRegistry >> affiliations [
	^ instDict values
]

{ #category : #requirement }
BellairsWorkshopsRegistry >> countries [
	"^ (self participations collect: #country) copyWithoutDuplicates sorted"
	^ self countryDict values
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> countryDict [
	^ countryDict
]

{ #category : #querying }
BellairsWorkshopsRegistry >> countryNamed: aName [
	^ self countryDict detect: [ :c | c country = aName ]
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initialize [
	workshopDict := Dictionary new.
	personDict := Dictionary new.
	instDict := Dictionary new.
	countryDict := Dictionary new
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
				at: (dict at: 'person')
				ifAbsentPut: [ BellairsPerson new
						registry: self;
						initializeFrom: dict;
						yourself ].
			instDict
				at: (dict at: 'affiliation')
				ifAbsentPut: [ BellairsAffiliation new
						registry: self;
						initializeFrom: dict;
						yourself ].
			countryDict
				at: (dict at: 'country')
				ifAbsentPut: [ BellairsCountry new
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
	^ self instDict detect: [ :inst | inst affiliation = aName ]
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
		searchString: '(all entries)'
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

{ #category : #accessing }
BellairsWorkshopsRegistry >> workshops [
	^ workshopDict values
]
