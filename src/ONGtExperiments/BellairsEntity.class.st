Class {
	#name : #BellairsEntity,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #mondrian }
BellairsEntity >> entries [
	self subclassResponsibility
]

{ #category : #views }
BellairsEntity >> gtEntriesFor: aView [
	<gtView>
	^ aView forward
		title: 'Entries';
		priority: 50;
		object: [ self entries ];
		view: #gtTreeFor:context:
]

{ #category : #views }
BellairsEntity >> gtSummaryFor: aView [
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
BellairsEntity >> initializeFrom: aDictionary [
	self subclassResponsibility
]

{ #category : #accessing }
BellairsEntity >> json [
	^ self registry json
]

{ #category : #mondrian }
BellairsEntity >> mondrianBorder [
	^ BlBorder paint: Color black width: 1
]

{ #category : #mondrian }
BellairsEntity >> mondrianChildren [
	^ {}
]

{ #category : #mondrian }
BellairsEntity >> mondrianNodeColor [
	^ Color paleBlue
]

{ #category : #mondrian }
BellairsEntity >> mondrianNodeElement [
	^ BlElement new
		size: 10 @ 10;
		border: self mondrianBorder;
		background: self mondrianNodeColor;
		aptitude: (BrGlamorousWithExplicitTooltipAptitude text: self name)
]

{ #category : #accessing }
BellairsEntity >> name [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BellairsEntity >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
BellairsEntity >> registry [
	^ registry
]

{ #category : #accessing }
BellairsEntity >> registry: anObject [
	registry := anObject
]

{ #category : #views }
BellairsEntity >> summary [
	^ {{'name'.
			self name}}
]
