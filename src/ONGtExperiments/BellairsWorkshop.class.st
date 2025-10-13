"
I am a Bellairs workshop held in a given year.

"
Class {
	#name : #BellairsWorkshop,
	#superclass : #AbstractBellairsEntity,
	#instVars : [
		'workshop',
		'persons'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #printing }
BellairsWorkshop >> displayName [
	^ self workshop
]

{ #category : #querying }
BellairsWorkshop >> entries [
	^ self json select: [ :d | (d at: 'workshop') = self workshop ]
]

{ #category : #views }
BellairsWorkshop >> gtPersonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Persons';
		priority: 20;
		items: [ self persons ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #initialization }
BellairsWorkshop >> initializeFrom: aDictionary [
	workshop := aDictionary at: 'workshop'
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianChildren [
	^ self persons
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianNodeColor [
	^ Color paleRed
]

{ #category : #accessing }
BellairsWorkshop >> persons [
	^ persons
		ifNil: [ persons := self entries
					collect: [ :d | self registry personNamed: (d at: 'name') ] ]
]

{ #category : #printing }
BellairsWorkshop >> printOn: aStream [
	aStream nextPutAll: self workshop
]

{ #category : #views }
BellairsWorkshop >> summary [
	^ {{'workshop'.
			self workshop.
			self}.
		{'# persons'.
			self persons size printString.
			self persons}}
]

{ #category : #accessing }
BellairsWorkshop >> workshop [
	^ workshop
]
