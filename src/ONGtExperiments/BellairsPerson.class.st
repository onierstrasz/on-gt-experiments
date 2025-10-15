"
I represent a person who has participated in one or more Bellairs workshops as either an organizer or a regular participant.

*NB:* my name might contain some HTML accents.
"
Class {
	#name : #BellairsPerson,
	#superclass : #AbstractBellairsEntity,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsPerson >> affiliation [
	^ self affiliations size = 1
		ifTrue: [ self affiliations first name ]
		ifFalse: [ self affiliations first name , ' + '
				, (self affiliations size - 1) printString ]
]

{ #category : #accessing }
BellairsPerson >> allRoles [
	^ self rolesIn: self registry participations
]

{ #category : #querying }
BellairsPerson >> entries [
	^ self json select: [ :d | (d at: 'person') = self name ]
]

{ #category : #views }
BellairsPerson >> gtInstitutionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Affiliations';
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
		priority: 86;
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
	name := aDictionary at: 'person'
]

{ #category : #accessing }
BellairsPerson >> initials [
	^ '' join: (self name substrings collect: #first)
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
		ifTrue: [ BlBorder paint: Color red width: 2 ]
		ifFalse: [ BlBorder paint: Color black width: 1 ]
]

{ #category : #mondrian }
BellairsPerson >> mondrianNodeColor [
	self workshops size = 1 ifTrue: [ ^ Color paleGreen ].
	self workshops size < 4 ifTrue: [ ^ Color lightGreen ].
	^ Color lightGreen darker
]

{ #category : #mondrian }
BellairsPerson >> mondrianNodeElement [
	^ BlTextElement new
		text: self initials asRopedText;
		padding: (BlInsets all: 12);
		border: self mondrianBorder;
		background: self mondrianNodeColor;
		aptitude: (BrGlamorousWithExplicitTooltipAptitude text: self name);
		geometry: BlCircleGeometry new;
		yourself
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
	^ {{'Name'.
			self name.
			self}.
		{'# Workshops'.
			self workshops size.
			self arrayOrUniqueElement: self workshops}.
		{'Roles'.
			self allRoles.
			self arrayOrUniqueElement: self participations}.
		{'# Affiliations'.
			self affiliations size.
			self arrayOrUniqueElement: self affiliations}.
		{'# URLs'.
			self urls size.
			self arrayOrUniqueElement: self urls}}
]

{ #category : #accessing }
BellairsPerson >> surname [
	^ self name substrings last
]
