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

{ #category : #converting }
BellairsParticipation >> asString [
	"String for spotter searchers"

	^ '; ' join: self data values
]

{ #category : #accessing }
BellairsParticipation >> country [
	^ data at: 'country'
]

{ #category : #accessing }
BellairsParticipation >> data [
	^ data
]

{ #category : #accessing }
BellairsParticipation >> data: aDictionary [
	data := aDictionary
]

{ #category : #printing }
BellairsParticipation >> displayName [
	^ self workshop , ' -- ' , self person
]

{ #category : #accessing }
BellairsParticipation >> entries [
	^ {data}
]

{ #category : #accessing }
BellairsParticipation >> institution [
	^ data at: 'institution'
]

{ #category : #accessing }
BellairsParticipation >> name [
	^ data at: 'name'
]

{ #category : #accessing }
BellairsParticipation >> person [
	^ data at: 'name'
]

{ #category : #accessing }
BellairsParticipation >> role [
	^ data at: 'role'
]

{ #category : #accessing }
BellairsParticipation >> summary [
	^ {{'person'.
			self displayName.
			self registry personNamed: self person}.
		{'workshop'.
			self workshop.
			self registry workshopNamed: self workshop}.
		{'role'.
			self role}.
		{'institution'.
			self institution.
			self registry institutionNamed: self institution}.
		{'country'.
			self country}.
		{'url'.
			self url}}	"WebBrowser openOn: self url"
]

{ #category : #accessing }
BellairsParticipation >> url [
	^ data at: 'url' ifAbsent: [ '' ]
]

{ #category : #accessing }
BellairsParticipation >> workshop [
	^ data at: 'workshop'
]
