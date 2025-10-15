"
I am an abstract parent of various  Bellairs domain entities.
I know  my `registry` and its `json`.
I also store my state in a `data` slot, which could be a dictionary or an array of dictionaries.

My subclasses should implement `entries` and `initializeFrom:`.

Subclasses may also override their `displayName`, `printOn:`, `summary` view entries, and `mondrian*` configuration methods.

"
Class {
	#name : #AbstractBellairsEntity,
	#superclass : #Object,
	#instVars : [
		'registry',
		'name'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #testing }
AbstractBellairsEntity class >> isAbstract [
	^ self == AbstractBellairsEntity
]

{ #category : #accessing }
AbstractBellairsEntity >> arrayOrUniqueElement: anArray [
	^ anArray size = 1 ifTrue: [ anArray first ] ifFalse: [ anArray ]
]

{ #category : #querying }
AbstractBellairsEntity >> countries [
	^ self participations countries
]

{ #category : #printing }
AbstractBellairsEntity >> displayName [
	^ self name
]

{ #category : #accessing }
AbstractBellairsEntity >> entries [
	"Return an array of raw dictionaries"

	self subclassResponsibility
]

{ #category : #actions }
AbstractBellairsEntity >> gtActionInspectParticipationsFor: anAction [
	<gtAction>
	^ anAction button
		priority: 80;
		label: 'P';
		tooltip: 'Inspect participations';
		id: GtInspectorInspectButtonId;
		action: [ :aButton | aButton phlow spawnObject: self participations ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self participations ]
			mouseCursor: BlCopyCursor new
]

{ #category : #views }
AbstractBellairsEntity >> gtEntriesFor: aView [
	"<gtView>"
	^ aView forward
		title: 'Entries';
		priority: 55;
		object: [ self entries ];
		view: #gtTreeFor:context:;
		actionUpdateButton
]

{ #category : #views }
AbstractBellairsEntity >> gtParticipationsFor: aView [
	<gtView>
	^ aView forward
		title: 'Participations';
		priority: 50;
		object: [ self participations ];
		view: #gtParticipationsFor:;
		actionUpdateButton
]

{ #category : #views }
AbstractBellairsEntity >> gtSummaryFor: aView [
	<gtView>
	"self summary ifEmpty: [ ^ aView empty ]."
	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ self summary ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Key'
			text: #first
			width: 100;
		column: 'Value' text: #second;
		send: #last;
		actionUpdateButton
]

{ #category : #initialization }
AbstractBellairsEntity >> initializeFrom: aDictionary [
	self subclassResponsibility
]

{ #category : #accessing }
AbstractBellairsEntity >> institutions [
	^ self participations institutions
]

{ #category : #accessing }
AbstractBellairsEntity >> json [
	^ self registry json
]

{ #category : #mondrian }
AbstractBellairsEntity >> mondrianBorder [
	^ BlBorder paint: Color black width: 1
]

{ #category : #mondrian }
AbstractBellairsEntity >> mondrianChildren [
	^ {}
]

{ #category : #mondrian }
AbstractBellairsEntity >> mondrianNodeColor [
	^ Color paleBlue
]

{ #category : #mondrian }
AbstractBellairsEntity >> mondrianNodeElement [
	^ BlElement new
		size: 10 @ 10;
		border: self mondrianBorder;
		background: self mondrianNodeColor;
		aptitude: (BrGlamorousWithExplicitTooltipAptitude text: self displayName)
]

{ #category : #accessing }
AbstractBellairsEntity >> name [
	^ name
]

{ #category : #factory }
AbstractBellairsEntity >> participationGroupFrom: aDictionaryCollection [
	^ BellairsParticipationGroup new
		registry: self registry;
		data: aDictionaryCollection;
		yourself
]

{ #category : #accessing }
AbstractBellairsEntity >> participations [
	^ (self participationGroupFrom: self entries)
		searchString: 'participations for ' , self displayName;
		yourself
]

{ #category : #accessing }
AbstractBellairsEntity >> persons [
	^ self participations persons
]

{ #category : #printing }
AbstractBellairsEntity >> printOn: aStream [
	aStream nextPutAll: self displayName
]

{ #category : #accessing }
AbstractBellairsEntity >> registry [
	^ registry
]

{ #category : #accessing }
AbstractBellairsEntity >> registry: anObject [
	registry := anObject
]

{ #category : #views }
AbstractBellairsEntity >> summary [
	^ {{'displayName'.
			self displayName.
			self}}
]

{ #category : #querying }
AbstractBellairsEntity >> urls [
	^ self participations urls
]

{ #category : #querying }
AbstractBellairsEntity >> workshops [
	^ self participations workshops
]
