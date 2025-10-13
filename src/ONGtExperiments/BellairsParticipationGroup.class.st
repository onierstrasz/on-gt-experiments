"
I represent a group of Participations, typically as the result of a query.

"
Class {
	#name : #BellairsParticipationGroup,
	#superclass : #AbstractBellairsEntity,
	#traits : 'TGtGroup',
	#classTraits : 'TGtGroup classTrait',
	#instVars : [
		'data'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsParticipationGroup >> data [
	^ data
]

{ #category : #accessing }
BellairsParticipationGroup >> data: aDictionary [
	data := aDictionary
]

{ #category : #printing }
BellairsParticipationGroup >> displayName [
	"Display the query?"

	^ 'a participation group'
]

{ #category : #'as yet unclassified' }
BellairsParticipationGroup >> entries [
	^ data
]

{ #category : #views }
BellairsParticipationGroup >> gtParticipationsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Participations';
		priority: 50;
		items: [ self participations ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Workshop'
			text: #workshop
			width: 200;
		column: 'Person'
			text: #name
			width: 180;
		column: 'Role'
			text: #role
			width: 100;
		column: 'Institution'
			text: #institution
			width: 180;
		column: 'Country'
			text: #country
			width: 180;
		column: 'URL'
			text: #url
			width: 180;
		actionUpdateButton
]

{ #category : #accessing }
BellairsParticipationGroup >> items [
	^ self participations
]

{ #category : #accessing }
BellairsParticipationGroup >> participations [
	^ self entries
		collect: [ :dict | 
			BellairsParticipation new
				registry: self registry;
				data: dict;
				yourself ]
]
