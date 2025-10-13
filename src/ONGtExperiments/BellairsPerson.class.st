"
I represent a person who has participated in one or more Bellairs workshops as either an organizer or a regular participant.

*NB:* my name might contain some HTML accents.
"
Class {
	#name : #BellairsPerson,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'name'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #printing }
BellairsPerson >> displayName [
	^ self name
]

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
		items: [ self institutions sortedAs: #displayName ];
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
		items: [ self workshops sortedAs: #displayName ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #initialization }
BellairsPerson >> initializeFrom: aDictionary [
	name := aDictionary at: 'name'
]

{ #category : #accessing }
BellairsPerson >> institution [
	^ self institutions size = 1
		ifTrue: [ self institutions first displayString ]
		ifFalse: [ self institutions first displayString , ' + '
				, (self institutions size - 1) printString ]
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
	^ name
]

{ #category : #accessing }
BellairsPerson >> roles [
	^ self rolesIn: self participations
]

{ #category : #accessing }
BellairsPerson >> rolesIn: aParticiationGroup [
	^ ', '
		join: ((aParticiationGroup participationsWithPersonNamed: self name) collect: #role)
				copyWithoutDuplicates
]

{ #category : #accessing }
BellairsPerson >> summary [
	^ {{'displayName'.
			self displayName.
			self}.
		{'# workshops'.
			self workshops size.
			self workshops}.
		{'# institutions'.
			self institutions size.
			self institutions}.
		{'institution'.
			self institution.
			self institutions first}}
]

{ #category : #accessing }
BellairsPerson >> surname [
	^ self name substrings last
]
