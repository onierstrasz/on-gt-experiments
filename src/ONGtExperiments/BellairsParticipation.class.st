"
I represent the participation of a person in a given Bellairs workshop.
As such I represent a virtual rather than a physical entity. 
I map directly to the individual lines of the web pages, and to the dictionary entries of the JSON produced from the website..
"
Class {
	#name : #BellairsParticipation,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'data'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsParticipation >> affiliation [
	^ self registry affiliationNamed:  (data at: 'affiliation')
]

{ #category : #converting }
BellairsParticipation >> asCSV [
	^ self csvHeader , String cr , self csvLine
]

{ #category : #converting }
BellairsParticipation >> asCsvLine: aStringArray [
	^ ',' join: (aStringArray collect: [ :field | field surroundedBy: '"' ])
]

{ #category : #converting }
BellairsParticipation >> asString [
	"String for spotter searchers"

	^ '; ' join: self data values
]

{ #category : #accessing }
BellairsParticipation >> country [
	^ self registry countryNamed: (data at: 'country')
]

{ #category : #converting }
BellairsParticipation >> csvFields [
	^ {'workshop'.
		'role'.
		'person'.
		'affiliation'.
		'country'.
		'url'}
]

{ #category : #converting }
BellairsParticipation >> csvHeader [
	^ self asCsvLine: self csvFields
]

{ #category : #converting }
BellairsParticipation >> csvLine [
	^ self
		asCsvLine: (self csvFields collect: [ :field | self data at: field ifAbsent: [ '' ] ])
]

{ #category : #accessing }
BellairsParticipation >> data [
	^ data
]

{ #category : #accessing }
BellairsParticipation >> data: aDictionary [
	data := aDictionary
]

{ #category : #accessing }
BellairsParticipation >> entries [
	^ {data}
]

{ #category : #accessing }
BellairsParticipation >> name [
	^ (data at: 'person') , ' -- ' , (data at: 'workshop')
]

{ #category : #accessing }
BellairsParticipation >> person [
	^ self registry personNamed: (data at: 'person')
]

{ #category : #accessing }
BellairsParticipation >> role [
	^ data at: 'role'
]

{ #category : #accessing }
BellairsParticipation >> summary [
	^ {{'name'.
			self name.
			self}.
		{'workshop'.
			self workshop}.
		{'role'.
			self role}.
		{'affiliation'.
			self affiliation}.
		{'country'.
			self country}.
		{'url'.
			self url}}
]

{ #category : #accessing }
BellairsParticipation >> url [
	^ data
		at: 'url'
		ifPresent: [ :url | ZnUrl fromString: url ]
		ifAbsent: [ '' ]
]

{ #category : #accessing }
BellairsParticipation >> workshop [
	^ self registry workshopNamed: (data at: 'workshop')
]
