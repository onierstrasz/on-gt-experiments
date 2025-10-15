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

{ #category : #accessing }
BellairsPerson >> allRoles [
	^ self rolesIn: self registry participations
]

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
	^ aView forward
		title: 'Institutions';
		priority: 30;
		object: [ self participations ];
		view: #gtInstitutionsFor:
]

{ #category : #'as yet unclassified' }
BellairsPerson >> gtOpenWebBrowserActionFor: anAction [
	<todo: 'Create a menu of URLs if there are more than one.'>
	<gtAction>
	self urls isEmpty ifTrue: [ ^ anAction noAction ].
	^ anAction button
		tooltip: 'Open web page';
		icon: BrGlamorousVectorIcons link;
		action: [ :aButton :aTab | WebBrowser openOn: self urls first asZnUrl ]
]

{ #category : #views }
BellairsPerson >> gtWorkshopsFor: aView [
	<gtView>
	^ aView forward
		title: 'Workshops';
		priority: 10;
		object: [ self participations ];
		view: #gtWorkshopsFor:
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
			self arrayOrUniqueElement: self workshops}.
		{'Roles'.
			self allRoles.
			self arrayOrUniqueElement: self participations}.
		{'# institutions'.
			self institutions size.
			self arrayOrUniqueElement: self institutions}.
		{'# urls'.
			self urls size.
			self arrayOrUniqueElement: self urls}}
]

{ #category : #accessing }
BellairsPerson >> surname [
	^ self name substrings last
]
