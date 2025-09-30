Class {
	#name : #BellairsPerson,
	#superclass : #BellairsEntity,
	#instVars : [
		'person',
		'workshops',
		'institutions'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #querying }
BellairsPerson >> entries [
	^ self json select: [ :d | (d at: 'name') = self name ]
]

{ #category : #views }
BellairsPerson >> gtInstitutionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Institutions';
		priority: 30;
		items: [ self institutions sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #views }
BellairsPerson >> gtWorkshopsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Workshops';
		priority: 20;
		items: [ self workshops sortedAs: #name ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #initialization }
BellairsPerson >> initializeFrom: aDictionary [
	person := aDictionary at: 'name'
]

{ #category : #accessing }
BellairsPerson >> institutions [
	^ institutions
		ifNil: [ institutions := (self entries collect: [ :d | d at: 'institution' ]) copyWithoutDuplicates
	collect: [ :name | self registry institutionNamed: name ] ]
]

{ #category : #querying }
BellairsPerson >> isOrganizer [
	^ (self entries collect: [ :d | d at: 'role' ]) includes: 'Organizer'
]

{ #category : #querying }
BellairsPerson >> isParticipant [
	^ (self entries collect: [ :d | d at: 'role' ]) includes: 'Participant'
]

{ #category : #mondrian }
BellairsPerson >> mondrianBorder [
	^ self isOrganizer
		ifTrue: [ BlBorder paint: Color red width: 1 ]
		ifFalse: [ BlBorder paint: Color black width: 1 ]
]

{ #category : #mondrian }
BellairsPerson >> mondrianNodeColor [
	^ self workshops size = 1 ifTrue: [ Color paleGreen ] ifFalse: [ Color green ]
]

{ #category : #mondrian }
BellairsPerson >> mondrianNodeElement [
	^ super mondrianNodeElement
		geometry: BlCircleGeometry new;
		yourself
]

{ #category : #accessing }
BellairsPerson >> name [
	^ self person
]

{ #category : #accessing }
BellairsPerson >> person [
	^ person
]

{ #category : #accessing }
BellairsPerson >> summary [
	^ {{'name'.
			self name}}
]

{ #category : #accessing }
BellairsPerson >> workshops [
	^ workshops
		ifNil: [ workshops := self entries
					collect: [ :d | self registry workshopNamed: (d at: 'workshop') ] ]
]
