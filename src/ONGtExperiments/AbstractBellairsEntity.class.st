"
I am an abstract parent of various  Bellairs domain entities.
I know  my `registry` and its `json`.

My subclasses should implement `initializeFrom:` and `entries`.

Subclasses may also override their `name`, `printOn:`, `summary` view entries, and `mondrian*` configuration methods.

"
Class {
	#name : #AbstractBellairsEntity,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #testing }
AbstractBellairsEntity class >> isAbstract [
	^ self == AbstractBellairsEntity
]

{ #category : #mondrian }
AbstractBellairsEntity >> entries [
	self subclassResponsibility
]

{ #category : #views }
AbstractBellairsEntity >> gtEntriesFor: aView [
	<gtView>
	^ aView forward
		title: 'Entries';
		priority: 50;
		object: [ self entries ];
		view: #gtTreeFor:context:
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
		aptitude: (BrGlamorousWithExplicitTooltipAptitude text: self name)
]

{ #category : #accessing }
AbstractBellairsEntity >> name [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AbstractBellairsEntity >> printOn: aStream [
	aStream nextPutAll: self name
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
	^ {{'name'.
			self name}}
]
